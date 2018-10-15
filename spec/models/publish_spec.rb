# frozen_string_literal: true

require "spec_helper"

RSpec.describe Immoscout::Models::Publish do
  let(:json) { file_fixture("publish.json").read }
  let(:parsed_json) { JSON.parse(json) }
  let(:resource_id) { "68492877" }
  let(:publish_channel) { 10_000 } # means: listed on immoscout

  describe '#new' do
    context 'with hash argument' do
      let(:hash) do
        {
          real_estate: { id: "id" }, publish_channel: { id: publish_channel }
        }
      end

      let(:subject) { described_class.new(hash) }

      it 'assigns real_estate id' do
        expect(subject.real_estate.id).to eq "id"
      end

      it 'assigns publish_channel id' do
        expect(subject.publish_channel.id).to eq publish_channel
      end
    end
  end

  describe '#from_raw' do
    context 'with hash argument' do
      let(:subject) { described_class.from_raw(json) }

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
        publish.real_estate.id = resource_id
        publish.build_publish_channel
        expect(publish.save).to be
      end
    end
  end

  describe '#destroy', vcr: true do
    let(:hash) do
      {
        real_estate: { id: resource_id },
        publish_channel: { id: publish_channel }
      }
    end
    let(:publish) { described_class.new(hash) }

    it 'returns the deleted object' do
      expect(publish.destroy).to be
    end
  end
end
