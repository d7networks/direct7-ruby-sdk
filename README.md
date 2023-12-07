# Direct7 Ruby SDK

This Ruby SDK provides a convenient and easy-to-use interface to the Direct7 REST API. The SDK allows you to perform
all the operations that are available through the REST API.

## Installation
The SDK is available on RubyGems and can be installed using two methods:
Add this line to your application's Gemfile:

```bash
gem 'direct7', '~> 0.0.11'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install direct7
```

## Usage

The SDK is designed to be easy to use. The library needs to be configured with your account's secret key, which is available in your [Direct7 Dashboard](https://app.d7networks.com/api-tokens). To get started, create a client instance by providing the key. If you haven't already, you can Login [here](https://app.d7networks.com/signin) to access your dashboard.


### Send SMS

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

client.sms.send_message( recipients =['+91999999XXXX'], content ='Greetings from D7 API', originator ='SignOTP', report_url ='https://the_url_to_recieve_delivery_report.com', unicode =true)
```

### Send SMS (Unicode)

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

client.sms.send_message(recipients = ["+97150900XXXX","+97845900XXX"], content = "مرحبا بالعالم!", originator = "SignOTP", report_url = "https://the_url_to_recieve_delivery_report.com", unicode = True)
```

### Get Request Status

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

# request_id is the id returned in the response of send_message
client.sms.get_status(request_id= '001a1a4e-0221-4cb7-a524-a2a5b337cbe8')
```

### Send OTP

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

client.verify.send_otp(originator="SignOTP", recipient="+97150900XXXX", content = "Greetings from D7 API, your mobile verification code is: {}", expiry = 600, data_coding = "text")
```

### Re-Send OTP

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

client.verify.resend_otp(otp_id="0012c7f5-2ba5-49db-8901-4ee9be6dc8d1")
```

### Verify OTP

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

client.verify.verify_otp(otp_id="0012c7f5-2ba5-49db-8901-4ee9be6dc8d1", otp_code="1425")
```

### Get Request Status

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

# otp_id is the id returned in the response of send_otp
client.verify.get_status(otp_id="0012c7f5-2ba5-49db-8901-4ee9be6dc8d1")
```

### Send Viber Message

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

client.viber.send_viber_message(recipients=["+97150900XXXX","+97845900XXX"], content="Greetings from D7 API", label="PROMOTION", originator="INFO2WAY", call_back_url="https://the_url_to_recieve_delivery_report.com")
```


### Get Request Status

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

# request_id is the id returned in the response of send_viber_message
client.viber.get_status(request_id="0012c7f5-2ba5-49db-8901-4ee9be6dc8d1")
```

### Send Slack Message

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

client.slack.send_slack_message(content="Greetings from D7 API", work_space_name="WorkspaceName", channel_name="ChannelName", report_url="https://the_url_to_recieve_delivery_report.com")
```


### Get Request Status

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

# request_id is the id returned in the response of send_slack_message
client.slack.get_status(request_id="0012c7f5-2ba5-49db-8901-4ee9be6dc8d1")
```

### Search Your Number details

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

client.number_lookup.search_number_details(recipient="+914257845XXXX")
```

### Send Whatsapp Free-form Message (Contact Details)

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

client.whatsapp.send_whatsapp_freeform_message(originator="91906152XXXX", recipient="91906152XXXX", message_type="CONTACTS", first_name="Amal", last_name="Anu", display_name="Amal Anu", phone="91906152XXXX", email = "amal@gmail.com")
```

### Send Whatsapp Templated Message.

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

client.whatsapp.send_whatsapp_templated_message(originator="91906152XXXX", recipient="91906152XXXX", message_type="TEMPLATE", template_id="monthly_promotion", body_parameter_values={"0": "promotion"})
```

### Get Request Status

```ruby
require 'direct7'

client = Direct7::Client.new('Your API token')

# request_id is the id returned in the response of send_message
client.whatsapp.get_status(request_id="0012c7f5-2ba5-49db-8901-4ee9be6dc8d1")
```

## FAQ

### How do I get my API token?

You can get your API token from the Direct7 dashboard. If you don't have an account yet, you can create one for free.

### Supported ruby versions

The SDK supports ruby 3.0 and higher.

### Supported APIs

As of now, the SDK supports the following APIs:

| API                    |        Supported?        |
|------------------------|:------------------------:|
| SMS API                |            ✅             |
| Verify API             |            ✅             |
| Whatsapp API           |            ✅             |
| Number Lookup API      |            ✅             |
| Viber API              |            ✅             |
| Slack API              |            ✅             |

### How do I get started?

You can find the platform documentation @ [Direct7 Docs](https://d7networks.com/docs/).

### How do I get help?

If you need help using the SDK, you can create an issue on GitHub or email to support@d7networks.com

## Contributing

We welcome contributions to the Direct7 ruby SDK. If you have any ideas for improvements or bug fixes, please feel
free to create an issue on GitHub.
