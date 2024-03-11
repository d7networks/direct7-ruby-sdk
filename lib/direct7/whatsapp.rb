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

    def send_whatsapp_freeform_message(originator, recipient, message_type, body=nil, first_name=nil, last_name=nil, formatted_name=nil, phones=nil, emails=nil, urls=nil, latitude=nil, longitude=nil, name=nil, address=nil, type=nil, url=nil, caption=nil)
      message = {
        'originator' => originator,
        'recipients' => [{'recipient' => recipient}],
        'content' => {
          'message_type' => message_type
        }
      }

      case message_type
      when 'CONTACTS'
        message['content']['contacts'] = [{
          'name' => {
            'first_name' => first_name,
            'last_name' => last_name,
            'formatted_name' => formatted_name,
          },
          'phones' => (phones.map { |phone| { 'phone' => phone } } if phones),
          'emails' => (emails.map { |email| { 'email' => email } } if emails),
          'urls' => (urls.map { |url| { 'url' => url } } if urls),
        }]
      when 'LOCATION'
        message['content']['location'] = {
          'latitude' => latitude,
          'longitude' => longitude,
          'name' => name,
          'address' => address,
        }
      when 'ATTACHMENT'
        message['content']['attachment'] = {
          'type' => type,
          'url' => url,
          'caption' => caption,
        }
      when 'TEXT'
        message['content']['text'] = {
          'body' => body,
        }
      end

      response = @client.post(@client.host, '/whatsapp/v2/send', params: { 'messages' => [message] })
      @log.info('Message sent successfully.')
      response
    end

    def send_whatsapp_templated_message(originator, recipient, template_id,
                                         body_parameter_values, media_type=nil, media_url=nil,
                                         latitude=nil, longitude=nil, location_name=nil,
                                         location_address=nil,lto_expiration_time_ms=nil, coupon_code=nil, quick_replies= nil, actions= nil, carousel_cards=nil)
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

      if lto_expiration_time_ms
          message['content']['template']['limited_time_offer'] = {
            'expiration_time_ms' => 'lto_expiration_time_ms',
          }
      end

      if coupon_code
        message['content']['template']['buttons'] = {
          'coupon_code' => [
            {
                "index"=> 0,
                "type"=> "copy_code",
                "coupon_code"=> coupon_code
            }
          ]
        }
      end

      if quick_replies
        message['content']['template']['buttons'] = {
          'quick_replies' => actquick_repliesions,
        }
      end

      if actions
        message['content']['template']['buttons'] = {
          'actions' => actions,
        }
      end

      if carousel_cards
        message['content']['template']['carousel'] = {
          'cards' => carousel_cards,
        }
      end

      response = @client.post(@client.host, '/whatsapp/v2/send', true, params: { 'messages' => [message] })
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
