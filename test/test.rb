$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require 'direct7/client'
require 'direct7/errors/errors'
require 'test/unit'

class TestSERVICES < Test::Unit::TestCase
  def setup
    @client = Direct7::Client.new('API TOKEN')
  end

  def test_send_message
    response1 = @client.sms.send_message(
        originator='SignOTP',
        report_url='https://the_url_to_recieve_delivery_report.com',
        schedule_time=nil,
        { recipients: ['+991999999XXXX'], content: 'New', unicode: false }
    )
    puts response1
    response2 = @client.sms.send_message(
        originator='SignOTP',
        report_url='https://the_url_to_recieve_delivery_report.com',
        schedule_time=nil,
        { recipients: ['+991999999XXXX'], content: 'مرحبا بالعالم!', unicode: true }
    )
    puts response2
    response3 = @client.sms.get_status(request_id= '001a1a4e-0221-4cb7-a524-a2a5b337cbe8')
    puts response3
  end

  def test_slack_send_message
    response1 = @client.slack.send_slack_message(content="Greetings from D7 API", work_space_name="WorkSpaceName", channel_name="ChannelName", report_url="https://the_url_to_recieve_delivery_report.com" )
    puts response1
    response2 = @client.slack.get_status(request_id= '002599bf-e53d-46ad-b784-34f8fd5b6cf3')
    puts response2
  end

  def test_send_viber_message
    response1 = @client.viber.send_viber_message(recipients=["+91999999XXXX"], content="Greetings from D7 API", label="PROMOTION", originator="SignOTP", call_back_url="https://the_url_to_recieve_delivery_report.com")
    puts response1
    response2 = @client.viber.get_status(request_id= 'd1319cc5-7183-43ff-8d98-0c18c5a62f1b')
    puts response2
  end

  def test_search_number_details
    response = @client.number_lookup.search_number_details(recipients="+91999999XXXX")
    puts response
  end

  def test_send_otp
    response = @client.verify.send_otp(originator="SignOTP", recipient="+91999999XXXX", content="Greetings from D7 API, your mobile verification code is: {}", data_coding="text", expiry=600)
    puts response
    response = @client.verify.resend_otp(otp_id="bb0e35ea-b094-40c6-9dda-06e37e801446")
    puts response
    response = @client.verify.verify_otp(otp_id="bb0e35ea-b094-40c6-9dda-06e37e801446", otp_code="022089")
    puts response
    response = @client.verify.get_status(otp_id="bb0e35ea-b094-40c6-9dda-06e37e801446")
    puts response
  end


  # Whatsapp
  # Freeform: Contacts

  def test_send_whatsapp_freeform_contact
    contact_addresses = [
        {
            "street": "1 Lucky Shrub Way",
            "city": "Menlo Park",
            "state": "CA",
            "zip": "94025",
            "country": "United States",
            "country_code": "US",
            "type": "WORK"
        },
        {
            "street": "1 Hacker Way",
            "city": "Menlo Park",
            "state": "CA",
            "zip": "94025",
            "country": "United States",
            "country_code": "US",
            "type": "WORK"
        }
    ]
    phones = [
        {
            "phone": "+16505559999",
            "type": "HOME"
        },
        {
            "phone": "+19175559999",
            "type": "WORK",
            "wa_id": "19175559999"
        }
    ]

    emails = [
        {
            "email": "bjohnson@luckyshrub.com",
            "type": "WORK"
        },
        {
            "email": "bjohnson@luckyshrubplants.com",
            "type": "HOME"
        }
    ]
    urls = [
        {
            "url": "https://www.luckyshrub.com",
            "type": "WORK"
        },
        {
            "url": "https://www.facebook.com/luckyshrubplants",
            "type": "WORK"
        }
    ]
    response = @client.whatsapp.send_whatsapp_freeform_message(
        originator= "971563XXXXXX",
        recipient= "991999999XXXX",
        message_type="CONTACTS",
        body=nil,
        first_name="Barbara",
        last_name="Johnson",
        formatted_name="Barbara J. Johnson",
        middle_name="Joana",
        suffix="Esq.",
        prefix="Dr.",
        birthday='4567-12-12',
        phones=phones,
        emails=emails,
        urls=urls,
        latitude=nil, longitude=nil, name=nil, address=nil, type=nil, url=nil, caption=nil, filename=nil, message_id=nil, emoji=nil,
        contact_addresses=contact_addresses,

    )
    # response = @client.whatsapp.get_status(request_id="81eca535-8131-4866-be18-b3d933604069")
    puts response
  end

  # Freeform: Text
  def test_send_whatsapp_freeform_text
    response = @client.whatsapp.send_whatsapp_freeform_message(
      originator='971563XXXXXX',
      recipient='+991999999XXXX',
      message_type='TEXT',
      body='HI',

    )
    puts response
  end


  # Freeform: Reaction
  def test_send_whatsapp_freeform_text
    response = @client.whatsapp.send_whatsapp_freeform_message(
      originator='971563XXXXXX',
      recipient='+991999999XXXX',
      message_type='REACTION',
      body=nil, first_name=nil, last_name=nil, formatted_name=nil, middle_name=nil, suffix=nil, prefix=nil, birthday=nil, phones=nil, emails=nil, urls=nil, latitude=nil, longitude=nil, name=nil, address=nil, type=nil, url=nil, caption=nil, filename=nil,
      message_id="3e382940-1cd6-11ef-883c-0242ac1b002c",
      emoji= "😀"
    )
    puts response
  end


    # // ATTACHMENT: image
    def test_send_whatsapp_freeform_text
      response = @client.whatsapp.send_whatsapp_freeform_message(
        originator='971563XXXXXX',
        recipient='+991999999XXXX',
        message_type='ATTACHMENT',
        body=nil, first_name=nil, last_name=nil, formatted_name=nil, middle_name=nil, suffix=nil, prefix=nil, birthday=nil, phones=nil, emails=nil, urls=nil, latitude=nil, longitude=nil, name=nil, address=nil,
        type='image',
        url='https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
        caption='Tet'
      )
      puts response
    end


    # // ATTACHMENT: video
    def test_send_whatsapp_freeform_text
      response = @client.whatsapp.send_whatsapp_freeform_message(
        originator='971563XXXXXX',
        recipient='+991999999XXXX',
        message_type='ATTACHMENT',
        body=nil, first_name=nil, last_name=nil, formatted_name=nil, middle_name=nil, suffix=nil, prefix=nil, birthday=nil, phones=nil, emails=nil, urls=nil, latitude=nil, longitude=nil, name=nil, address=nil,
        type='video',
        url='https://www.onirikal.com/videos/mp4/nestlegold.mp4',
        caption='Tet'
      )
      puts response
    end

    # // ATTACHMENT: document
    def test_send_whatsapp_freeform_text
      response = @client.whatsapp.send_whatsapp_freeform_message(
        originator='971563XXXXXX',
        recipient='+991999999XXXX',
        message_type='ATTACHMENT',
        body=nil, first_name=nil, last_name=nil, formatted_name=nil, middle_name=nil, suffix=nil, prefix=nil, birthday=nil, phones=nil, emails=nil, urls=nil, latitude=nil, longitude=nil, name=nil, address=nil,
        type='document',
        url='https://www.clickdimensions.com/links/TestPDFfile.pdf',
        caption= "Test PDF file pdf",
        filename= "TestPDFfile.pdf"
      )
      puts response
    end

    # // ATTACHMENT: audio
    def test_send_whatsapp_freeform_text
      response = @client.whatsapp.send_whatsapp_freeform_message(
        originator='971563XXXXXX',
        recipient='+991999999XXXX',
        message_type='ATTACHMENT',
        body=nil, first_name=nil, last_name=nil, formatted_name=nil, middle_name=nil, suffix=nil, prefix=nil, birthday=nil, phones=nil, emails=nil, urls=nil, latitude=nil, longitude=nil, name=nil, address=nil,
        type='audio',
        url='http://fate-suite.ffmpeg.org/mpegaudio/extra_overread.mp3'
      )
      puts response
    end


    # // ATTACHMENT: sticker
    def test_send_whatsapp_freeform_text
      response = @client.whatsapp.send_whatsapp_freeform_message(
        originator='971563XXXXXX',
        recipient='+991999999XXXX',
        message_type='ATTACHMENT',
        body=nil, first_name=nil, last_name=nil, formatted_name=nil, middle_name=nil, suffix=nil, prefix=nil, birthday=nil, phones=nil, emails=nil, urls=nil, latitude=nil, longitude=nil, name=nil, address=nil,
        type='sticker',
        url='https://raw.githubusercontent.com/sagarbhavsar4328/dummys3bucket/master/sample3.webp'
      )
      puts response
    end

    # // Location
    def test_send_whatsapp_freeform_text
      response = @client.whatsapp.send_whatsapp_freeform_message(
        originator='971563XXXXXX',
        recipient='+991999999XXXX',
        message_type='LOCATION',
        body=nil, first_name=nil, last_name=nil, formatted_name=nil, middle_name=nil, suffix=nil, prefix=nil, birthday=nil, phones=nil, emails=nil, urls=nil,
        latitude='12.93803129081362',
        longitude='77.61088653615994',
        name='Mobile Pvt Ltd',
        address='Bengaluru, Karnataka 56009'
      )
      puts response
    end

  # // Templated: no body parm
  def test_send_whatsapp_templated_message
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="testing_alpha", language="en"
    )
    puts response
  end

  # // Templated: with body parm
  def test_send_whatsapp_templated_message
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="with_personalize",
      language="en",
      body_parameter_values={"0": "Anil"}
    )
    puts response
  end

  # Templated: Text
  def test_send_whatsapp_templated_message
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="header_param", language="en",
      body_parameter_values=nil,
      media_type="text",
      text_header_title="Ds"
    )
    puts response
  end

  # Templated: Image
  def test_send_whatsapp_templated_message
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="image",
      language="en",
      body_parameter_values=nil,
      media_type="image",
      text_header_title=nil,
      media_url='https://miro.medium.com/max/780/1*9Wdo1PuiJTZo0Du2A9JLQQ.jpeg'
    )
    puts response
  end

   # Templated: Video
   def test_send_whatsapp_templated_message
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="video",
      language="en",
      body_parameter_values=nil,
      media_type="video",
      text_header_title=nil,
      media_url='http://www.onirikal.com/videos/mp4/nestlegold.mp4'
    )
    puts response
  end

   # Templated: document
   def test_send_whatsapp_templated_message
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="document",
      language="en",
      body_parameter_values={"0": "first_parameter_in_your_template"},
      media_type="document",
      text_header_title=nil,
      media_url='https://www.clickdimensions.com/links/TestPDFfile.pdf'
    )
    puts response
  end

  # Templated: Location
  def test_send_whatsapp_templated_message
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id='location',
      language='en',
      body_parameter_values=nil,
      media_type='location',
      text_header_title=nil, media_url=nil,
      latitude='12.93803129081362',
      longitude='77.61088653615994',
      name='Mobile Pvt Ltd',
      address='30, Hosur Rd, 7th Block, Koramangala, Bengaluru, Karnataka 560095'
    )
    puts response
  end

  #  # Templated: quick_replies
  def test_send_whatsapp_templated_message
    quick_replies = [
          {
              "button_index" => "0",
              "button_payload" => "1"
          },
          {
              "button_index" => "1",
              "button_payload" => "2"
          }
      ]
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="quick_reply",
      language="en",
      body_parameter_values=nil, media_type=nil, text_header_title=nil, media_url=nil, latitude=nil, longitude=nil, name=nil, address=nil,lto_expiration_time_ms=nil, coupon_code=nil,
      quick_replies=quick_replies
    )
    puts response
  end

   # Templated :button_flow
    button_flow=[
              {"flow_token":"unused",
                "action_type":"flow",
                "index":"0",
                "flow_action_data":{}
                }
            ]
    def test_send_whatsapp_templated_message
    button_flow=[
              {"flow_token":"unused",
                "action_type":"flow",
                "index":"0",
                "flow_action_data":{}
                }
            ]
    response = @client.whatsapp.send_whatsapp_templated_message(
       originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="call_to_action",
      language="en",
      body_parameter_values=nil, media_type=nil, text_header_title=nil, media_url=nil, latitude=nil, longitude=nil, name=nil, address=nil,lto_expiration_time_ms=nil, coupon_code=nil,
      quick_replies=nil,
      actions=nil,
      button_flow=button_flow
    )
    puts response
  end

   # Templated: actions
  actions = [
    {
      "action_type" => "url",
      "action_index" => "0",
      "action_payload" => "dash"
    }
  ]

  def test_send_whatsapp_templated_message
    actions = [
      {
        "action_type" => "url",
        "action_index" => "0",
        "action_payload" => "dash"
      }
    ]
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="call_to_action",
      language="en",
      body_parameter_values=nil, media_type=nil, text_header_title=nil, media_url=nil, latitude=nil, longitude=nil, name=nil, address=nil,lto_expiration_time_ms=nil, coupon_code=nil,
      quick_replies=nil,
      actions=actions
    )
    puts response
  end

  # // Templated: coupon_code
  def test_send_whatsapp_templated_message
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="coupon_code",
      language="en",
      body_parameter_values={"0": "first_parameter_in_your_template"},
      media_type=nil, text_header_title=nil, media_url=nil, latitude=nil, longitude=nil, name=nil, address=nil,lto_expiration_time_ms=nil,
      coupon_code="DAS558HG"
    )
    puts response
  end

  # Templated: LTO
  def test_send_whatsapp_templated_message
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="limited_time_offer", language="en",
      body_parameter_values=nil,
      media_type="image",
      text_header_title=nil,
      media_url="https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg",
      latitude=nil, longitude=nil, name=nil, address=nil,
      lto_expiration_time_ms="1708804800000",
      coupon_code="DWS44"
    )
    puts response
  end

  # // Templated: Carousel
  def test_send_whatsapp_templated_message
    cards = [
        {
          "card_index" => "0",
          "components" => [
            {
              "type" => "header",
              "parameters" => [
                {
                  "type" => "image",
                  "image" => {
                    "link" => "https://miro.medium.com/max/780/1*9Wdo1PuiJTZo0Du2A9JLQQ.jpeg"
                  }
                }
              ]
            },
            {
              "type" => "button",
              "sub_type" => "quick_reply",
              "index" => "0",
              "parameters" => [
                {
                  "type" => "payload",
                  "payload" => "2259NqSd"
                }
              ]
            }
          ]
        },
        {
          "card_index" => "1",
          "components" => [
            {
              "type" => "header",
              "parameters" => [
                {
                  "type" => "image",
                  "image" => {
                    "link" => "https://www.selfdrive.ae/banner_image/desktop/21112023164328_409449002729.jpg"
                  }
                }
              ]
            },
            {
              "type" => "button",
              "sub_type" => "quick_reply",
              "index" => "0",
              "parameters" => [
                {
                  "type" => "payload",
                  "payload" => "59NqSdd"
                }
              ]
            }
          ]
        }
      ]
    response = @client.whatsapp.send_whatsapp_templated_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      template_id="carousel_card",
      language="en",
      body_parameter_values=nil, media_type=nil, text_header_title=nil, media_url=nil, latitude=nil, longitude=nil, name=nil, address=nil,lto_expiration_time_ms=nil, coupon_code=nil,
      quick_replies=nil, actions=nil, carousel_cards=cards
    )
    puts response
  end

  # Interactive : cta
  def test_send_whatsapp_interactive_message
    parameters = {
          "display_text": "Visit Us",
          "url": "https://www.luckyshrub.com?clickID=kqDGWd24Q5TRwoEQTICY7W1JKoXvaZOXWAS7h1P76s0R7Paec4"
        }
    response = @client.whatsapp.send_whatsapp_interactive_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      interactive_type= "cta_url",
      header_type= "text",
      header_text= "Payment$ for D7 Whatsapp Service",
      header_link=nil, header_file_name=nil,
      body_text= "Direct7 Networks is a messaging service provider that specializes in helping organizations efficiently communicate with their customers.",
      footer_text= "Thank You",
      parameters= parameters
    )
    puts response
  end


   # Interactive : button
   def test_send_whatsapp_interactive_message
    buttons = [{"type": "reply", "reply": {"id": "1", "title": "Debit Card"}}, {
            "type": "reply",
            "reply": {"id": "2", "title": "Credit"}
        }]
    response = @client.whatsapp.send_whatsapp_interactive_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      interactive_type= "button",
      header_type= "text",
      header_text= "Payment$ for D7 Whatsapp Service",
      header_link=nil, header_file_name=nil,
      body_text= "Direct7 Networks is a messaging service provider that specializes in helping organizations efficiently communicate with their customers.",
      footer_text= "Thank You",
      parameters= nil, sections=nil,
      buttons=buttons
    )
    puts response
  end

   # Interactive : location request
   def test_send_whatsapp_interactive_message
    response = @client.whatsapp.send_whatsapp_interactive_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      interactive_type= "location_request_message",
      header_type= nil,
      header_text= nil,
      header_link=nil, header_file_name=nil,
      body_text= "Lets make a trip!",
      footer_text= nil,
      parameters= nil, sections=nil,
      buttons=nil
    )
    puts response
  end

    # Interactive : address message
    def test_send_whatsapp_interactive_message
      parameters = {
        "country": "IN",
        "values": {
           "name": "Steni Mariya",
           "phone_number": "+97156965xxxx",
           "in_pin_code": 680026,
           "house_number": "45",
           "floor_number": "3",
          "tower_number": 34,
          "building_name": "Excel",
          "address": "House name",
          "landmark_area": "Near Mobile Tower",
          "city": "Thrissur",
          "state": "Kerala"
        },
      "saved_addresses": [
          {
          "id": "address1",
           "value": {
           "name": "Lifiya Mariya",
           "phone_number": "+971569xxxxx",
           "in_pin_code": 680026,
           "house_number": "45",
           "floor_number": "3",
          "tower_number": 34,
          "building_name": "Excel",
          "address": "House name",
          "landmark_area": "Near Mobile Tower",
          "city": "Thrissur",
          "state": "Kerala"
        }
          },
          {
          "id": "address1",
           "value": {
           "name": "Mariya",
           "phone_number": "+971569658xxx",
           "in_pin_code": 680026,
           "house_number": "45",
           "floor_number": "3",
          "tower_number": 34,
          "building_name": "Excel",
          "address": "House name",
          "landmark_area": "Near Mobile Tower",
          "city": "Thrissur",
          "state": "Kerala"
        }
          }
      ]
     }
      response = @client.whatsapp.send_whatsapp_interactive_message(
        originator='971563XXXXXX',
        recipient='991999999XXXX',
        interactive_type= "address_message",
        header_type= "text",
        header_text= "Payment$ for D7 Whatsapp Service",
        header_link=nil, header_file_name=nil,
        body_text= "Direct7 Networks is a messaging service provider that specializes in helping organizations efficiently communicate with their customers.",
        footer_text= "Thank You",
        parameters= parameters
      )
      puts response
    end
  # Interactive :Flow
  def test_send_whatsapp_templated_message
      flow_parameter= {
                        "name": "flow",
                        "parameters": {
                        "flow_message_version": "3",
                        "flow_token": "unused",
                        "flow_id": "530404409952136",
                        "flow_cta": "Book Demo",
                        "flow_action": "navigate",
                        "flow_action_payload": {
                        "screen": "screen_"
                        }
                      }
                    }

      response = @client.whatsapp.send_whatsapp_interactive_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      interactive_type= "flow",
      header_type= "text",
      header_text= "Payment$ for D7 Whatsapp Service",
      header_link=nil, header_file_name=nil,
      body_text= "Direct7 Networks is a messaging service provider that specializes in helping organizations efficiently communicate with their customers.",
      footer_text= "Thank You",
      parameters=flow_parameter,
    )
    puts response
  end
  #  Interactive : list
  def test_send_whatsapp_interactive_message
    sections = [
      {
          "title": "SMS Messaging",
          "rows": [
              {
                  "id": "1",
                  "title": "Normal SMS",
                  "description": "Signup for free at the D7 platform to use our Messaging APIs."
              },
              {
                  "id": "2",
                  "title": "Verify",
                  "description": "D7 Verify API is to applications requires SMS based OTP authentications."
              }
          ]
      },
      {
          "title": "Whatsapp",
          "rows": [
              {
                  "id": "3",
                  "title": "WhatsApp Messages",
                  "description": "D7 Whatsapp API is to applications requires pre-registration."
              }
          ]
      }
    ]
    response = @client.whatsapp.send_whatsapp_interactive_message(
      originator='971563XXXXXX',
      recipient='991999999XXXX',
      interactive_type= "list",
      header_type= "text",
      header_text= "Payment$ for D7 Whatsapp Service",
      header_link=nil, header_file_name=nil,
      body_text= "Direct7 Networks is a messaging service provider that specializes in helping organizations efficiently communicate with their customers.",
      footer_text= "Thank You",
      parameters= nil, sections=sections,
      buttons=nil, list_button_text='Choose Service'
    )
    puts response
  end

end
