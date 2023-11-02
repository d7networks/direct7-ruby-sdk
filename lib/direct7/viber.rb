require 'json'
require 'net/http'
require 'uri'
require 'logger'

module Direct7
  class VIBER
    def initialize(client)
      @client = client
      @log = Logger.new(STDOUT) # You can customize the log destination as needed
    end

    def send_viber_message(recipients, content, label, originator, call_back_url = nil)
      message = {
        'channel' => 'viber',
        'recipients' => recipients,
        'content' => content,
        'label' => label
      }
      message_globals = {
        'originator' => originator,
        'call_back_url' => call_back_url
      }

      response = @client.post(@client.host, '/viber/v1/send', true, params= { 'messages' => [message], 'message_globals' => message_globals })
      @log.info('Message sent successfully.')
      response
    end

    def get_status(request_id)
      response = @client.get(
        @client.host,
        "/report/v1/viber-log/#{request_id}"
      )
      @log.info('Message status retrieved successfully.')
      response
    end
  end
end
