require "grape/rails/cache/version"
require "grape/rails/cache/formatter"

module Grape
  module Rails
    module Cache
      extend ActiveSupport::Concern

      included do
        formatter :json, Grape::Rails::Cache::JsonFormatter

        helpers do
          def set_headers(expiration_time, stale_time)
            header "Cache-Control", "no-cache, no-store, must-revalidate"
            header "Surrogate-Control", "max-age=#{expiration_time}, stale-if-error=#{stale_time}" if expiration_time > 0
          end

          def default_stale_if_error_time
            24.hours
          end

          def default_expire_time
            2.hours
          end

          # Usage:
          #
          #   cache(key: "your_cache_key", expires_in: 20.minutes, stale_for: 3.hours) do
          #     SomeExpensiveMethod.new
          #     render "index"
          #   end
          def cache(opts = {}, &block)
            expiration_time = (opts[:expires_in] || default_expire_time).to_i
            stale_time = (opts[:stale_for] || default_stale_if_error_time).to_i
            cache_key = opts[:key]

            set_headers(expiration_time, stale_time)

            if expiration_time > 0
              ::Rails.cache.fetch(cache_key, raw: true, expires_in: expiration_time) do
                block.call.to_json
              end
            else
              block.call.to_json
            end
          end
        end
      end
    end
  end
end
