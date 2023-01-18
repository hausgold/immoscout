# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Immoscout::Models::Publish do
  let(:json) { file_fixture('publish.json').read }
  let(:parsed_json) { JSON.parse(json) }
  let(:resource_id) { '68492877' }
  let(:publish_channel) { 10_000 } # means: listed on immoscout

  describe '#new' do
    context 'with hash argument' do
      let(:hash) do
        {
          real_estate: { id: 'id' }, publish_channel: { id: publish_channel }
        }
      end
      let(:instance) { described_class.new(hash) }

      it 'assigns real_estate id' do
        expect(instance.real_estate.id).to eq 'id'
      end

      it 'assigns publish_channel id' do
        expect(instance.publish_channel.id).to eq publish_channel
      end
    end
  end

  describe '#from_raw' do
    context 'with hash argument' do
      let(:instance) { described_class.from_raw(json) }

      it 'assigns real_estate id' do
        expect(instance.real_estate.id).not_to be_nil
      end

      it 'assigns publish_channel id' do
        expect(instance.publish_channel.id).not_to be_nil
      end
    end
  end

  describe '#save', vcr: true do
    context 'when not persisted' do
      let(:instance) { described_class.new }

      it 'set attributes' do
        instance.build_real_estate
        instance.real_estate.id = resource_id
        instance.build_publish_channel
        expect(instance.save).to be(instance)
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
    let(:instance) { described_class.new(hash) }

    it 'returns the deleted object' do
      expect(instance.destroy).to be_a(described_class)
    end
  end
end
