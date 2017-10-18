# frozen_string_literal: true

require "spec_helper"

RSpec.describe Immoscout::Configuration do
  let(:instance) { described_class.new }

  it "can set access_token" do
    expect { instance.access_token = 'token' }.to \
      change { instance.access_token }.from(nil).to('token')
  end

  it "can set use_sandbox" do
    expect { instance.use_sandbox = true }.to \
      change { instance.use_sandbox }.from(nil).to(true)
  end
end
