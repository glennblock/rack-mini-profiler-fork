module Rack
  class MiniProfiler
    class SplunkStore < AbstractStore

      EXPIRES_IN_SECONDS = 60 * 60 * 24

      def initialize(args = nil)
        @args               = args || {}
        @prefix             = @args.delete(:prefix)     || 'MPRedisStore'
      end

      def save(page_struct)
        forward_to_splunk(JSON.parse(page_struct.to_json), @args)
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
      def forward_to_splunk(payload, params={})
        # GLENN TO WRITE CODE HERE
      end # forward_to_splunk


    end
  end
end
