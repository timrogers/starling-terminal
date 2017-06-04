# frozen_string_literal: true

module StarlingTerminal
  # Utility functions for building, formatting and styling the statement
  module Utils
    # A map from currency code (e.g. "GBP", "EUR") to symbol for display in the table
    CURRENCY_SYMBOLS = {
      'GBP' => '£',
      'USD' => '$',
      'EUR' => '€'
    }.freeze

    # Converts a Float to a currency valuable with symbol or code, suitable for display
    #
    # @param float [Float] the float to convert to currency
    # @param currency [String] the currency code (e.g. "GBP", "EUR") which will be
    #                          converted to a symbol if possible, or displayed in full
    # @return [String] the currency amount, suitable for display (e.g. $5.99, 50 UAH)
    def self.float_to_currency(float, currency:)
      currency_symbol = CURRENCY_SYMBOLS.fetch(currency, nil)

      return format("#{currency_symbol}%.2f", float) if currency_symbol
      format("%.2f #{currency}", float)
    end

    # Presents a Time as a string in the standard UK format
    #
    # @param time [Time] the time
    # @return [String] the string formatted in the standard UK form (e.g.
    #                  "4/6/2017 10:00")
    def self.present_time(time)
      time.strftime('%-d/%-m/%Y %H:%M')
    end

    # Returns the colour an amount should be displayed in (red for negative amounts,
    # green for positive)
    #
    # @param amount [Float] the amount
    # @return [:red, :green] the colour the amount should be displayed in
    def self.colour_for_amount(amount)
      amount > 0 ? :green : :red
    end
  end
end
