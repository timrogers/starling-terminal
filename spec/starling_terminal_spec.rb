# frozen_string_literal: true

require 'spec_helper'

RSpec.describe StarlingTerminal do
  it 'has a version number' do
    expect(StarlingTerminal::VERSION).not_to be nil
  end
end
