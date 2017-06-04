# frozen_string_literal: true

module StarlingTerminal
  # Raised if there is no access token provided for accessing the Starling Bank API
  class MissingAccessTokenError < StandardError
    def message
      'Starling Terminal needs an access token to access the Starling Bank API on your' \
      ' behalf. Head to the Personal Access section at https://developer.starlingbank.' \
      'com/get-started to get started, then set the environment variable ' \
      '$STARLING_ACCESS_TOKEN.'
    end
    alias to_s message
  end
end
