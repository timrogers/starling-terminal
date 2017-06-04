# frozen_string_literal: true

module StarlingTerminal
  # Raised if the Starling Bank API access token provided is invalid
  class InvalidAccessTokenError < StandardError
    def message
      'The Starling access token you provided is invalid'
    end
    alias to_s message
  end
end
