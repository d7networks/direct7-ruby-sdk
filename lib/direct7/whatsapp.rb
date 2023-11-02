require 'json'
require 'net/http'
require 'uri'
require 'logger'

module Direct7
  class WHATSAPP
    def initialize(client)
      @client = client
      @log = Logger.new(STDOUT) # You can customize the log destination as needed
    end

    def send_whatsapp_freeform_message(originator, recipient, message_type, message_text= nil, first_name= nil,
                                       last_name= nil, display_name= nil, phone= nil,
                                       email= nil, url= nil, latitude= nil, longitude= nil,
                                       location_name= nil, location_address= nil,
                                       attachment_type= nil, attachment_url= nil,
                                       attachment_caption= nil)
      message = {
        'originator' => originator,
        'recipients' => [{'recipient' => recipient}],
        'content' => {
          'message_type' => message_type
        }
      }

      case message_type
      when 'CONTACTS'
        message['content']['contact'] = {
          'first_name' => first_name,
          'last_name' => last_name,
          'display_name' => display_name,
          'phone' => phone,
          'email' => email,
          'url' => url
        }
      when 'LOCATION'
        message['content']['location'] = {
          'latitude' => latitude,
          'longitude' => longitude,
          'name' => location_name,
          'address' => location_address
        }
      when 'ATTACHMENT'
        message['content']['attachment'] = {
          'attachment_type' => attachment_type,
          'attachment_url' => attachment_url,
          'attachment_caption' => attachment_caption
        }
      when 'TEXT'
        message['content']['message_text'] = message_text
      end
      puts message
      response = @client.post(@client.host, '/whatsapp/v1/send', true, params= { 'messages' => [message] })
      @log.info('Message sent successfully.')
      response
    end

    def send_whatsapp_templated_message(originator, recipient, template_id,
                                        body_parameter_values, media_type= nil, media_url= nil,
                                        latitude= nil, longitude= nil, location_name= nil,
                                        location_address= nil)
      message = {
        'originator' => originator,
        'recipients' => [{'recipient' => recipient}],
        'content' => {
          'message_type' => 'TEMPLATE',
          'template' => {
            'template_id' => template_id,
            'body_parameter_values' => body_parameter_values
          }
        }
      }

      if media_type
        if media_type == 'location'
          message['content']['template']['media'] = {
            'media_type' => 'location',
            'location' => {
              'latitude' => latitude,
              'longitude' => longitude,
              'name' => location_name,
              'address' => location_address
            }
          }
        else
          message['content']['template']['media'] = { 'media_type' => media_type, 'media_url' => media_url }
        end
      end
      
      response = @client.post(@client.host, '/whatsapp/v1/send', true, params= { 'messages' => [message] })
      @log.info('Message sent successfully.')
      response
    end

    def get_status(request_id)
      response = @client.get(
        @client.host,
        "/whatsapp/v1/report/#{request_id}"
      )
      @log.info('Message status retrieved successfully.')
      response
    end
  end
end
