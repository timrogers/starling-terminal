# frozen_string_literal: true

require 'spec_helper'
require 'stringio'

RSpec.describe StarlingTerminal::Statement do
  subject(:statement) { described_class.new(access_token: access_token) }

  let(:access_token) { 'dummy-access-token' }

  describe '#initialize' do
    context 'with a nil access token' do
      let(:access_token) { nil }

      it 'raises an error' do
        expect { statement }.to raise_error(StarlingTerminal::MissingAccessTokenError)
      end
    end

    context 'with an access token, even that is invalid' do
      it { is_expected.to be_a(StarlingTerminal::Statement) }
    end
  end

  describe '#generate' do
    let(:output) { StringIO.new }
    subject { output.string }

    context 'with a valid access token' do
      let(:account_balance) do
        double(amount: 1000.0,
               currency: 'GBP',
               pending_transactions: 10.0,
               available_to_spend: 990.0)
      end

      let(:transactions) do
        [
          double(amount: -5.00,
                 currency: 'GBP',
                 source: :master_card,
                 narrative: 'Aldi',
                 created: Time.parse('2017-05-30T18:06:28.773Z')),
          double(amount: 10,
                 currency: 'GBP',
                 source: :faster_payments_in,
                 narrative: 'Dinner',
                 created: Time.parse('2017-05-30T18:06:28.773Z'))
        ]
      end

      before do
        allow_any_instance_of(Starling::Services::AccountBalanceService)
          .to receive(:get).and_return(account_balance)
        allow_any_instance_of(Starling::Services::TransactionsService)
          .to receive(:list).and_return(transactions)
      end

      it 'prints the statement to the output' do
        statement.generate(output: output)
        expect(output.string).to match_snapshot('output')
      end
    end

    context 'with an invalid access token' do
      before do
        env = double(status: 401)

        allow_any_instance_of(Starling::Services::AccountBalanceService)
          .to receive(:get).and_raise(Starling::Errors::ApiError, env)
      end

      it 'raises an error' do
        expect { statement.generate(output: output) }
          .to raise_error(StarlingTerminal::InvalidAccessTokenError)
      end
    end
  end
end
