# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Immoscout::Models::Picture do
  let(:json) { file_fixture('picture.json').read }
  let(:parsed_json) { JSON.parse(json) }
  let(:attachable_id) { '68492877' }
  let(:resource_id) { '672642550' }

  describe '#new' do
    context 'with hash argument' do
      let(:hash) do
        {
          title: 'Wohnzimmer'
        }
      end
      let(:instance) { described_class.new(hash) }

      it 'assigns title' do
        expect(instance.title).to eq 'Wohnzimmer'
      end
    end
  end

  describe '#from_raw' do
    context 'with hash argument' do
      let(:instance) { described_class.from_raw(json) }

      %w[
        id
        type
        href
        publish_date
        creation
        modification
        title
        external_id
        external_check_sum
        floorplan
        title_picture
        urls
      ].each do |attribute|
        it "assigns #{attribute}" do
          expect(instance.send(attribute)).not_to be_nil
        end
      end
    end
  end

  describe '#save', :vcr do
    let(:instance) { described_class.new title: 'Wohnzimmer' }
    let(:file) { file_fixture('png.png') }

    before do
      instance.file = file
      instance.attachable = attachable_id
    end

    it 'set attributes' do
      expect { instance.save }.to \
        change(instance, :id).from(nil).to('672642901')
    end
  end

  describe '#destroy', :vcr do
    let(:instance) { described_class.new(id: resource_id) }

    before { instance.attachable = attachable_id }

    it 'returns the deleted object' do
      expect(instance.destroy).to be(instance)
    end
  end
end
