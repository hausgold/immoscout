# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Immoscout::Configuration do
  let(:instance) { described_class.new }

  before do
    instance.oauth_token = nil
    instance.use_sandbox = nil
  end

  it 'can set oauth_token' do
    expect { instance.oauth_token = 'token' }.to \
      change(instance, :oauth_token).to('token')
  end

  it 'can set use_sandbox' do
    expect { instance.use_sandbox = true }.to \
      change(instance, :use_sandbox).to(true)
  end
end
