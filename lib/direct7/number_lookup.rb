require 'json'
require 'net/http'
require 'uri'
require 'logger'

module Direct7
  class NUMBER_LOOKUP
    def initialize(client)
      @client = client
      @log = Logger.new(STDOUT) # You can customize the log destination as needed
    end

    def search_number_details(recipient)
      """
      Search number details.
      :param params: dict - The search request parameters.
      :return:
      """
      params = {
        'recipient' => recipient
      }
      response = @client.post(@client.host, '/hlr/v1/lookup',true, params= params)
      @log.info('Search request is success.')
      response
    end
  end
end
