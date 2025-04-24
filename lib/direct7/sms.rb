require 'json'
require 'net/http'
require 'uri'

module Direct7
    class SMS
      def initialize(client)
        @client = client
      end
  
      def send_message(originator, report_url, schedule_time, tag, *args)
        messages = []
        args.each do |message|
          messages << {
            'channel' => 'sms',
            'recipients' => message[:recipients] || [],
            'content' => message[:content] || '',
            'msg_type' => 'text',
            'data_coding' => message[:unicode] ? 'unicode' : 'text'
          }
        end
        message_globals = {
          'originator' => originator,
          'report_url' => report_url,
          'schedule_time' => schedule_time,
          'tag' => tag
        };
        payload = {
            'messages' => messages,
            'message_globals' => message_globals
        }
        response = @client.post(@client.host, '/messages/v1/send', true,  params=payload)
        puts "Message sent successfully."
        response
      end
  
      def get_status(request_id)
        response = @client.get(@client.host, "/report/v1/message-log/#{request_id}")
        puts'Message status retrieved successfully.'
        response
      end
    end
  end