require 'json'
require 'net/http'
require 'uri'
require 'http'
require 'net-http-persistent'
require_relative '../direct7/version'
require_relative '../direct7/sms'
require_relative '../direct7/verify'
require_relative '../direct7/slack'
require_relative '../direct7/viber'
require_relative '../direct7/number_lookup'
require_relative '../direct7/whatsapp'

module Direct7
    class Client
      attr_accessor :timeout, :session, :adapter

      def initialize(api_token = nil, timeout = 30, pool_connections = 10, pool_maxsize = 10, max_retries = 3)
        @api_token = api_token
        @host = 'https://api.d7networks.com'
        user_agent = "direct7-ruby-sdk/#{Direct7::VERSION} ruby/#{RUBY_VERSION}"
        @headers = {
          'User-Agent' => user_agent,
          'Accept' => 'application/json'
        }

        def sms
            @sms
        end
        def verify
            @verify
        end
        def slack
            @slack
        end
        def viber
            @viber
        end
        def number_lookup
            @number_lookup
        end
        def whatsapp
            @whatsapp
        end
        @sms = Direct7::SMS.new(self)
        @verify = Direct7::VERIFY.new(self)
        @slack = Direct7::SLACK.new(self)
        @viber = Direct7::VIBER.new(self)
        @number_lookup = Direct7::NUMBER_LOOKUP.new(self)
        @whatsapp = Direct7::WHATSAPP.new(self)
        # ... initialize other services ...
  
        @session = HTTP.persistent(@host)
            @session.headers('User-Agent' => user_agent, 'Accept' => 'application/json')
            @session.timeout(write: timeout, connect: timeout)
            # @session.connect('pool_size'=> pool_connections, 'pool_max' => pool_maxsize)
 
      end
  
      def host(value = nil)
        if value.nil?
          @host
        else
          @host = value
        end
      end
  
      def process_response(host, response)
        # puts "Response headers #{response}"
        case response.code.to_i
        when 401
          raise AuthenticationError, 'Invalid API token'
        when 200..299
          begin
            result = JSON.parse(response.body)
            # puts "Successful process response: #{result}"
            result
          rescue JSON::ParserError
            nil
          end
        when 400..499
        puts "Client error: #{response.code} #{response.body.inspect}"
          case response.code.to_i
          when 400
            raise BadRequest, response.body.inspect
          when 404
            raise NotFoundError, response.body.inspect
          when 402
            raise InsufficientCreditError, response.body.inspect
          when 422
            raise ValidationError, response.body.inspect
          else
            raise ClientError, "#{response.code} response from #{host}"
          end
        when 500..599
        puts "Server error: #{response.code} #{response.body.inspect}"
          raise ServerError, "#{response.code} response from #{host}"
        else
          nil
        end
      end
  
      def get(host, path, params = nil)
        request_url = "#{host}#{path}"
        request_headers = @headers.merge('Authorization' => create_bearer_token_string)
        # puts "GET request sent to #{request_url} with headers #{request_headers} and params #{params}"
        response = @session.get(URI(request_url), headers: request_headers)
        process_response(host, response)
      end
  
      def post(host, path, body_is_json, params)
        request_url = "#{host}#{path}"
        request_headers = @headers.merge('Authorization' => create_bearer_token_string)
        request_headers['Content-Type'] = body_is_json ? 'application/json' : 'application/x-www-form-urlencoded'
        #  puts "POST request sent to #{request_url} with headers #{request_headers} and params #{params}"
        params_json = JSON.generate(params)
        response = if body_is_json
            @session.post(URI(request_url), headers: request_headers, json: params)
          else
            @session.post(URI(request_url), data: params, headers: request_headers)
          end
        # puts response
        process_response(host, response)
      end
  
      private
  
      def create_bearer_token_string
        "Bearer #{@api_token}"
      end
    end
  end