require '../lib/direct7/client'
require '../lib/direct7/errors/errors'
require 'test/unit'
require_relative '../lib/direct7/client'

class TestSERVICES < Test::Unit::TestCase
  def setup
    @client = Direct7::Client.new('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoLWJhY2tlbmQ6YXBwIiwic3ViIjoiOTM2M2FmNTUtYWRmMS00Y2YzLWJhNjEtNGRjNWIxOTE4NGUwIn0.rctBTKBUO2FERmv_j75ItWACpUDQ7NG14v1PeXlM1ks')
  end

  def test_send_message
    response1 = @client.sms.send_message(
        originator='SignOTP',
        report_url='https://the_url_to_recieve_delivery_report.com',
        schedule_time=nil,
        { recipients: ['+918086757074'], content: 'Greetings from D7 API', unicode: false }
    )
    puts response1
#     response2 = @client.sms.get_status(request_id= '001a1a4e-0221-4cb7-a524-a2a5b337cbe8')
#     puts response2
  end
#   def test_slack_send_message
#     response1 = @client.slack.send_slack_message(content="Greetings from D7 API", work_space_name="WorkSpaceName", channel_name="ChannelName", report_url="https://the_url_to_recieve_delivery_report.com" )
#     puts response1
#     response2 = @client.slack.get_status(request_id= '002599bf-e53d-46ad-b784-34f8fd5b6cf3')
#     puts response2
#   end
#
#   def test_send_viber_message
#     response1 = @client.viber.send_viber_message(recipients=["+91999999XXXX"], content="Greetings from D7 API", label="PROMOTION", originator="SignOTP", call_back_url="https://the_url_to_recieve_delivery_report.com")
#     puts response1
#     response2 = @client.viber.get_status(request_id= 'd1319cc5-7183-43ff-8d98-0c18c5a62f1b')
#     puts response2
#   end
#
#   def test_search_number_details
#     response = @client.number_lookup.search_number_details(recipients="+91999999XXXX")
#     puts response
#   end
#
#   def test_send_otp
#     response = @client.verify.send_otp(originator="SignOTP", recipient="+91999999XXXX", content="Greetings from D7 API, your mobile verification code is: {}", data_coding="text", expiry=600)
#     puts response
#     response = @client.verify.resend_otp(otp_id="bb0e35ea-b094-40c6-9dda-06e37e801446")
#     puts response
#     response = @client.verify.verify_otp(otp_id="bb0e35ea-b094-40c6-9dda-06e37e801446", otp_code="022089")
#     puts response
#     response = @client.verify.get_status(otp_id="bb0e35ea-b094-40c6-9dda-06e37e801446")
#     puts response
#   end
#
#   def test_send_whatsapp_templated_message
#     response = @client.whatsapp.send_whatsapp_templated_message(originator="919061525574", recipient="91999999XXXX",
#     template_id="marketing_media_image", body_parameter_values={"0": "Customer"}, media_type="image",
#     media_url="https://d7networks.com/static/resources/css/img/favicon.d27f70e6ebd0.png"
#     )
#     puts response
#     response = @client.whatsapp.send_whatsapp_freeform_message(
#         originator= "91906154XXXX",
#         recipient= "+91999999XXXX",
#         message_type="CONTACTS", first_name="Amal", last_name="Anu", display_name="Amal Anu", phone="91906152XXXX", email = "amal@gmail.com"
#     )
#     response = @client.whatsapp.get_status(request_id="81eca535-8131-4866-be18-b3d933604069")
#     puts response
#   end
end
