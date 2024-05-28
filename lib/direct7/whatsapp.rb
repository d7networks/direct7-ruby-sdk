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

    def send_whatsapp_freeform_message(originator, recipient, message_type, body=nil, first_name=nil, last_name=nil, formatted_name=nil, middle_name=nil, suffix=nil, prefix=nil, birthday=nil, phones=nil, emails=nil, urls=nil, latitude=nil, longitude=nil, name=nil, address=nil, type=nil, url=nil, caption=nil, filename=nil, message_id=nil, emoji=nil, contact_addresses=nil)
      message = {
        'originator' => originator,
        'recipients' => [{'recipient' => recipient}],
        'content' => {
          'message_type' => message_type
        }
      }

      if message_type
        if message_type == 'CONTACTS'
          message['content']['contacts'] = [{
            'name' => {
              'first_name' => first_name,
              'last_name' => last_name,
              'formatted_name' => formatted_name,
              'middle_name' => middle_name,
              'suffix' => suffix,
              'prefix' => prefix,
            },
            'addresses' => contact_addresses,
            'birthday' => birthday,
            'phones' => phones,
            'emails' => emails,
            'urls' => urls
          }]
        end

        if message_type == 'LOCATION'
          message['content']['location'] = {
            'latitude' => latitude,
            'longitude' => longitude,
            'name' => name,
            'address' => address,
          }
        end
        if message_type == 'ATTACHMENT'
          if type
            if type == "document"
              message['content']['attachment'] = {
                'type' => type,
                'url' => url,
                'caption' => caption,
                'filename' => filename
              }
            else
              message['content']['attachment'] = {
                'type' => type,
                'url' => url,
                'caption' => caption
              }
            end
          end
        end

        if message_type == 'TEXT'
          message['content']['text'] = {
            'body' => body,
          }
        end

        if message_type == 'REACTION'
          message['content']['reaction'] = {
            'message_id' => message_id,
            'emoji' => emoji
          }
        end
      end
      response = @client.post(@client.host, '/whatsapp/v2/send', true, params= {'messages' => [message]})
      @log.info('Message sent successfully.')
      response
    end

    def send_whatsapp_templated_message(originator, recipient, template_id, language, body_parameter_values=nil, media_type=nil, text_header_title=nil, media_url=nil, latitude=nil, longitude=nil, name=nil, address=nil, lto_expiration_time_ms=nil, coupon_code=nil, quick_replies=nil, actions=nil, carousel_cards=nil)
      allowed_media_types = ['image', 'document', 'video', 'audio', 'text', 'location']
      template = {
          'template_id' => template_id,
          'language' => language,
          'body_parameter_values' => body_parameter_values ? body_parameter_values : {}
      }

      content = {
          'message_type' => 'TEMPLATE',
          'template' => template
      }

      message = {
        'originator' => originator,
        'recipients' => [{'recipient' => recipient}],
        'content' => content
      }

      if media_type
        unless allowed_media_types.include?(media_type)
          raise ArgumentError, "Invalid media_type: #{media_type}. Allowed values are: #{allowed_media_types.join(', ')}"
        end
        if media_type == 'location'
          message['content']['template']['media'] = {
            'media_type' => media_type,
            'location' => {
              'latitude' => latitude,
              'longitude' => longitude,
              'name' => name,
              'address' => address
            }
          }
        elsif media_type == 'text'
          message['content']['template']['media'] = {
                    'media_type' => media_type, 
                    'text_header_title' => text_header_title
                  }
        else
          message['content']['template']['media'] = { 'media_type' => media_type, 'media_url' => media_url }
        end
      end

      if lto_expiration_time_ms
          message['content']['template']['limited_time_offer'] = {
            'expiration_time_ms' => lto_expiration_time_ms,
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
          'quick_replies' => quick_replies,
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
      response = @client.post(@client.host, '/whatsapp/v2/send', true, params= {'messages' => [message]})
      @log.info('Message sent successfully.')
      response
    end

    def send_whatsapp_interactive_message(originator, recipient, interactive_type, header_type=nil,
      header_text=nil, header_link=nil, header_file_name=nil, body_text=nil,
      footer_text=nil, parameters=nil, sections=nil, buttons=nil,list_button_text=nil)

      message = {
        'originator' => originator,
        'recipients' => [{'recipient' => recipient}],
        'content' => {
          'message_type' => 'INTERACTIVE',
          'interactive' => {
            'type' => interactive_type,
            'header' => {
              'type' => header_type,
            },
            'body' => {
              'text' => body_text,
            },
            'footer' => {
              'text' => footer_text,
            }
          }
        }
      }

      if header_type
        if header_type == 'text'
          message['content']['interactive']['header']["text"] = header_text

        elsif header_type == 'image' || header_type == 'video' || header_type == 'document'
          message['content']['interactive']['header'][header_type] = {
                'filename' => (header_type == "document" ? header_file_name : nil),
                'link' => header_link
            }
        end
      end

      if interactive_type
        if interactive_type == 'cta_url'
          message['content']['interactive']['action'] = {
              'parameters' => parameters,
          }
        elsif interactive_type == 'button'
          message['content']['interactive']['action'] = {
              'buttons' => buttons,
          }
        elsif interactive_type == 'list'
          message['content']['interactive']['action'] = {
              'sections' => sections,
              'button' => list_button_text
          }
        end
      end

      response = @client.post(@client.host, '/whatsapp/v2/send', true, params= { 'messages' => [message] })
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
