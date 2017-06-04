# frozen_string_literal: true

module StarlingTerminal
  # Builds a Starling statement for output to the terminal
  class Statement
    # The headings to be displayed in our table of transactions
    TRANSACTIONS_TABLE_HEADINGS = ['Narrative',
                                   'Amount',
                                   'Date and time',
                                   'Source'].freeze

    # @param access_token [String] The Starling Bank API access token
    # @raise [MissingAccessTokenError] if no access token was provided, or it is `nil`
    def initialize(access_token: ENV['STARLING_ACCESS_TOKEN'])
      raise MissingAccessTokenError unless access_token
      @access_token = access_token
    end

    # Outputs a complete statement to the provided output
    # @param output [#puts] The output to print the statement to
    # @raise [InvalidAccessTokenError] if the Starling Bank API access token provided is
    #                                  invalid
    # @raise [Starling::Errors::ApiError] if something else goes wrong with the Starling
    #                                     Bank API
    # @return [#puts] the output
    def generate(output: STDOUT)
      output.puts balance_line
      output.puts pending_transactions_line
      output.puts available_to_spend_line
      output.puts "#{transactions_table}\n\n"
      output
    rescue Starling::Errors::ApiError => error
      raise InvalidAccessTokenError if [401, 403].include?(error.status)
      raise
    end

    private

    attr_reader :access_token, :output

    def balance_line
      amount = account_balance.amount
      balance_colour = Utils.colour_for_amount(amount)
      balance = Utils.float_to_currency(amount, currency: account_balance.currency)

      "\n\nBalance: #{balance}".colorize(balance_colour)
    end

    def pending_transactions_line
      pending_transactions = Utils.float_to_currency(
        account_balance.pending_transactions,
        currency: account_balance.currency
      )

      "Pending: #{pending_transactions}"
    end

    def available_to_spend_line
      available_to_spend = Utils.float_to_currency(
        account_balance.available_to_spend,
        currency: account_balance.currency
      )

      "Available to spend: #{available_to_spend}\n\n"
    end

    def transactions_table
      Terminal::Table.new(headings: TRANSACTIONS_TABLE_HEADINGS,
                          rows: transaction_rows)
    end

    def transaction_rows
      @transaction_rows = transactions.map { |tx| TransactionRow.present(tx) }
    end

    def starling
      @starling ||= Starling::Client.new(access_token: access_token)
    end

    def account_balance
      @account_balance ||= starling.account_balance.get
    end

    def transactions
      @transactions ||= starling.transactions.list
    end
  end
end
