require 'json'
require 'net/http'
require 'uri'
require 'logger'

module Direct7
  class SLACK
    def initialize(client)
      @client = client
      @log = Logger.new(STDOUT) # You can customize the log destination as needed
    end

    def send_slack_message(content, work_space_name, channel_name, report_url = nil)
      message = {
        'channel' => 'slack',
        'content' => content,
        'work_space_name' => work_space_name,
        'channel_name' => channel_name
      }
      message_globals = {
        'report_url' => report_url
      }
      response = @client.post(@client.host, '/messages/v1/send', true, params= {
        'messages' => [message],
        'message_globals' => message_globals
      })

      @log.info('Message sent successfully.')
      response
    end

    def get_status(request_id)
      response = @client.get(@client.host, "/report/v1/message-log/#{request_id}")
      @log.info('Message status retrieved successfully.')
      response
    end
  end
end
