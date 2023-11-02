module Direct7
  class AuthenticationError < StandardError
    def initialize(message)
      super(message)
    end
  end

  class ClientError < StandardError
  end

  class ValidationError < StandardError
  end

  class InsufficientCreditError < StandardError
  end

  class NotFoundError < StandardError
  end

  class ServerError < StandardError
  end

  class BadRequest < StandardError
  end
end
