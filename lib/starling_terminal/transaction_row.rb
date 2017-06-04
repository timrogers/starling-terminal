# frozen_string_literal: true

module StarlingTerminal
  # A presenter to convert Starling::Resources::TransactionResource instances to
  # presented rows for our transactions table
  class TransactionRow
    # Converts a Starling Bank transaction into a row to be displayed in our transactions
    # table
    #
    # @param transaction [Starling::Resources::TransactionResource] the transaction
    #                                                               resource returned
    #                                                               from the Starling
    #                                                               Bank API
    # @return [Array<String>] a row suitable for presentation through `Terminal::Table`
    def self.present(transaction)
      amount = transaction.amount

      [
        transaction.narrative,
        Utils.float_to_currency(amount, currency: transaction.currency)
             .colorize(Utils.colour_for_amount(amount)),
        Utils.present_time(transaction.created),
        transaction.source.to_s
      ]
    end
  end
end
