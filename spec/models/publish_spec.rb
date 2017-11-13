# frozen_string_literal: true

require "spec_helper"

RSpec.describe Immoscout::Models::Publish do
  let(:json) { JSON.parse(file_fixture("publish.json").read) }
  let(:instance) { described_class.new_raw(json) }

  describe '#new_raw' do
    context 'with hash argument' do
      let(:subject) { described_class.new_raw(json) }

      it 'assigns real_estate id' do
        expect(subject.real_estate.id).to be
      end

      it 'assigns publish_channel id' do
        expect(subject.publish_channel.id).to be
      end
    end
  end

  describe '#save', vcr: true do
    context 'not persisted' do
      let(:publish) { described_class.new }

      it 'set attributes' do
        publish.build_real_estate
        publish.real_estate.id = "68492877"
        publish.build_publish_channel
        expect(publish.save).to be
      end
    end
  end

  describe '#destroy', vcr: true do
    let(:hash) do
      {
        real_estate: { id: "68492877" }, publish_channel: { id: 10_000 }
      }
    end
    let(:publish) { described_class.new(hash) }

    it 'returns the deleted object' do
      expect(publish.destroy).to be
    end
  end
end