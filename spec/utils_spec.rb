# frozen_string_literal: true

require 'date'
require 'spec_helper'

RSpec.describe StarlingTerminal::Utils do
  describe '.present_time' do
    subject { described_class.present_time(time) }

    let(:time) { Time.parse('2017-05-30T18:06:28.773Z') }

    it { is_expected.to eq('30/5/2017 18:06') }
  end

  describe '.colour_for_amount' do
    subject { described_class.colour_for_amount(amount) }

    context 'with an amount greater than zero' do
      let(:amount) { 5.00 }

      it { is_expected.to eq(:green) }
    end

    context 'with an amount of zero' do
      let(:amount) { 0.00 }

      it { is_expected.to eq(:red) }
    end

    context 'with an amount less than zero' do
      let(:amount) { -5.00 }

      it { is_expected.to eq(:red) }
    end
  end

  describe '.float_to_currency' do
    subject { described_class.float_to_currency(float, currency: currency) }

    context 'with a known currency' do
      let(:currency) { 'GBP' }

      context 'and a positive amount' do
        let(:float) { 1337.99 }

        it { is_expected.to eq('£1337.99') }
      end

      context 'and a negative amount' do
        let(:float) { -1337.99 }

        it { is_expected.to eq('£-1337.99') }
      end
    end

    context 'with an unknown currency' do
      let(:currency) { 'UAH' }

      context 'and a positive amount' do
        let(:float) { 1337.99 }

        it { is_expected.to eq('1337.99 UAH') }
      end

      context 'and a negative amount' do
        let(:float) { -1337.99 }

        it { is_expected.to eq('-1337.99 UAH') }
      end
    end
  end
end
