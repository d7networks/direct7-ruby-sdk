require 'json'
require 'net/http'
require 'uri'

module Direct7
    class SMS
      def initialize(client)
        @client = client
      end
  
      def send_message(recipients, content, originator, report_url = nil, unicode = false)
        message = {
          'channel' => 'sms',
          'content' => content,
          'msg_type' => 'text',
          'data_coding' => unicode ? 'unicode' : 'text',
          'recipients' => recipients
        };
        message_globals = {
          'originator' => originator,
          'report_url' => report_url,
        };
        response = @client.post(@client.host, '/messages/v1/send', true, params= {
          'messages' => [message],
          'message_globals' => message_globals
        })
        # puts "Message sent successfully."
        response
      end
  
      def get_status(request_id)
        response = @client.get(@client.host, "/report/v1/message-log/#{request_id}")
        puts'Message status retrieved successfully.'
        response
      end
    end
  end