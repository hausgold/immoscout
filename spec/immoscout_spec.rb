# frozen_string_literal: true

require "spec_helper"

RSpec.describe Immoscout do
  describe '.configure' do
    it 'sets oauth_token' do
      expect { described_class.configure { |c| c.oauth_token = 'token' } }.to \
        change { described_class.configuration.oauth_token }.to('token')
    end

    it 'sets use_sandbox' do
      expect { described_class.configure { |c| c.use_sandbox = true } }.to \
        change { described_class.configuration.use_sandbox }.to(true)
    end
  end
end
