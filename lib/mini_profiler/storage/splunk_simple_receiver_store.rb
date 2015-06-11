module Rack
  class MiniProfiler
    class SplunkSimpleReceiverStore < AbstractStore

      EXPIRES_IN_SECONDS = 60 * 60 * 24
      @service = nil
      @config = nil
      @index = nil
      @default_host = nil

      def initialize(args = nil)
        @args               = args || {}
        @prefix             = @args.delete(:prefix)     || 'MPRedisStore'

        #initialize the service and get the index
        @default_host = `hostname` rescue nil
        defaults = {
          :scheme => "https",
          :host => "localhost",
          :port => 8089,
          :username => "admin",
          :password => "changeme",
          :source => $0,
          :sourcetype => "apm",
          :index => "main"
        }
        @config = defaults.merge @args
        @service = Splunk::connect(@config)
        @index = @service.indexes[@config[:index]]

      end

      def save(page_struct)
        forward_to_splunk(JSON.parse(page_struct.to_json))
      end

      def load(id)
      end

      def set_unviewed(user, id)
      end

      def set_viewed(user, id)
      end

      def get_unviewed_ids(user)
      end

      def diagnostics(user)
      end

      private
      def forward_to_splunk(payload)
        $stderr.puts payload

        #send the data
        [payload].each do |j|
          @index.submit(j.to_json, :sourcetype => @config[:sourcetype], :source => @config[:source], :host => @default_host, :index => @config[:index])
        end
        return true
      end # forward_to_splunk


    end
  end
end
