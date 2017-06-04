# frozen_string_literal: true

require 'spec_helper'

RSpec.describe StarlingTerminal::TransactionRow do
  subject(:transaction_row) { described_class.present(transaction) }

  let(:transaction) do
    double(amount: -5.00,
           currency: 'GBP',
           source: :master_card,
           narrative: 'Aldi',
           created: Time.parse('2017-05-30T18:06:28.773Z'))
  end

  it 'builds a row for the table' do
    is_expected.to eq(['Aldi',
                       "\e[0;31;49m£-5.00\e[0m",
                       '30/5/2017 18:06',
                       'master_card'])
  end
end
