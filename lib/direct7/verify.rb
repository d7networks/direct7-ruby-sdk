require 'json'
require 'net/http'
require 'uri'
require 'logger'

module Direct7
  class VERIFY
    attr_reader :v2

    def initialize(client)
      @client = client
      @log = Logger.new(STDOUT) # You can customize the log destination as needed
      @v2 = VERIFY_V2.new(client)
    end

    def send_otp(originator, recipient, content= nil, data_coding= nil, expiry= nil, template_id= nil)
      if template_id.nil?
        params = {
          'originator' => originator,
          'recipient' => recipient,
          'content' => content,
          'expiry' => expiry,
          'data_coding' => data_coding
        }
      else
        params = {
          'originator' => originator,
          'recipient' => recipient,
          'template_id' => template_id
        }
      end
      response = @client.post(@client.host, '/verify/v1/otp/send-otp', true, params= params)
      @log.info('OTP Message sent successfully.')
      response
    end

    def resend_otp(otp_id)
      params = {
        'otp_id' => otp_id
      }
      response = @client.post(
        @client.host,
        '/verify/v1/otp/resend-otp', true,
        params= params
      )
      @log.info('OTP Message Re-sent successfully.')
      response
    end

    def verify_otp(otp_id, otp_code)
      params = {
        'otp_id' => otp_id,
        'otp_code' => otp_code
      }
      response = @client.post(@client.host, '/verify/v1/otp/verify-otp', true, params= params)
      @log.info('OTP Message verified successfully.')
      response
    end

    def get_status(otp_id)
      response = @client.get(
        @client.host,
        "/verify/v1/report/#{otp_id}"
      )
      @log.info('OTP Message status retrieved successfully.')
      response
    end
  end

  class VERIFY_V2
    def initialize(client)
      @client = client
      @log = Logger.new(STDOUT) # You can customize the log destination as needed
    end

    # Send an OTP using a verification flow created in the dashboard.
    def send_otp(recipient, flow_id)
      params = {
        'recipient' => recipient,
        'flow_id' => flow_id
      }
      response = @client.post(@client.host, '/verify/v2/otp/send-otp', true, params= params)
      @log.info('OTP Message sent successfully.')
      response
    end

    def resend_otp(otp_id)
      params = {
        'otp_id' => otp_id
      }
      response = @client.post(
        @client.host,
        '/verify/v2/otp/resend-otp', true,
        params= params
      )
      @log.info('OTP Message Re-sent successfully.')
      response
    end

    def verify_otp(otp_id, otp_code)
      params = {
        'otp_id' => otp_id,
        'otp_code' => otp_code
      }
      response = @client.post(@client.host, '/verify/v2/otp/verify-otp', true, params= params)
      @log.info('OTP Message verified successfully.')
      response
    end

    def get_status(otp_id)
      response = @client.get(
        @client.host,
        "/verify/v2/report/#{otp_id}"
      )
      @log.info('OTP Message status retrieved successfully.')
      response
    end
  end
end
