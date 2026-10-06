require 'minitest/autorun'
require_relative '../lib/direct7/verify'

class FakeClient
  attr_reader :posts, :gets

  def initialize
    @posts = []
    @gets = []
  end

  def host
    'https://api.d7networks.com'
  end

  def post(host, path, body_is_json, params)
    @posts << { path: path, body_is_json: body_is_json, params: params }
    {}
  end

  def get(host, path, params = nil)
    @gets << { path: path }
    {}
  end
end

class TestVerify < Minitest::Test
  OTP_ID = '0012c7f5-2ba5-49db-8901-4ee9be6dc8d1'

  def setup
    @client = FakeClient.new
    @verify = Direct7::VERIFY.new(@client)
  end

  def test_verify_v1_post_paths_unchanged
    @verify.send_otp('SignOTP', '+97150900XXXX', 'Your code is: {}', 'text', 600)
    @verify.resend_otp(OTP_ID)
    @verify.verify_otp(OTP_ID, '1425')
    assert_equal ['/verify/v1/otp/send-otp', '/verify/v1/otp/resend-otp', '/verify/v1/otp/verify-otp'],
                 @client.posts.map { |c| c[:path] }
    assert_equal({ 'originator' => 'SignOTP', 'recipient' => '+97150900XXXX',
                   'content' => 'Your code is: {}', 'expiry' => 600, 'data_coding' => 'text' },
                 @client.posts[0][:params])
  end

  def test_verify_v1_get_status_path_unchanged
    @verify.get_status(OTP_ID)
    assert_equal "/verify/v1/report/#{OTP_ID}", @client.gets.last[:path]
  end

  def test_verify_v2_post_paths
    @verify.v2.resend_otp(OTP_ID)
    @verify.v2.verify_otp(OTP_ID, '1425')
    assert_equal ['/verify/v2/otp/resend-otp', '/verify/v2/otp/verify-otp'], @client.posts.map { |c| c[:path] }
    assert_equal({ 'otp_id' => OTP_ID }, @client.posts[0][:params])
    assert_equal({ 'otp_id' => OTP_ID, 'otp_code' => '1425' }, @client.posts[1][:params])
  end

  def test_verify_v2_send_otp
    @verify.v2.send_otp('+97150900XXXX', 'login_flow')
    assert_equal '/verify/v2/otp/send-otp', @client.posts.last[:path]
    assert @client.posts.last[:body_is_json]
    assert_equal({ 'recipient' => '+97150900XXXX', 'flow_id' => 'login_flow' }, @client.posts.last[:params])
  end

  def test_verify_v2_get_status_path
    @verify.v2.get_status(OTP_ID)
    assert_equal "/verify/v2/report/#{OTP_ID}", @client.gets.last[:path]
  end
end
