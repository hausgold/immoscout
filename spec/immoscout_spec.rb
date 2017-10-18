# frozen_string_literal: true

require "spec_helper"

RSpec.describe Immoscout do
  describe '.configure' do
    it 'sets access_token' do
      expect { described_class.configure { |c| c.access_token = 'token' } }.to \
        change { described_class.configuration.access_token } \
        .from(nil).to('token')
    end

    it 'sets use_sandbox' do
      expect { described_class.configure { |c| c.use_sandbox = true } }.to \
        change { described_class.configuration.use_sandbox } \
        .from(nil).to(true)
    end
  end
end
