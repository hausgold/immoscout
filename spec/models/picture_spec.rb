# frozen_string_literal: true

require "spec_helper"

PICTURE_ACCESSORS = %w[
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
].freeze

RSpec.describe Immoscout::Models::Picture do
  let(:json) { file_fixture("picture.json").read }
  let(:parsed_json) { JSON.parse(json) }

  describe '#new' do
    context 'with hash argument' do
      let(:hash) do
        {
          title: "Wohnzimmer"
        }
      end

      let(:subject) { described_class.new(hash) }

      it 'assigns title' do
        expect(subject.title).to eq "Wohnzimmer"
      end
    end
  end

  describe '#from_raw' do
    context 'with hash argument' do
      let(:subject) { described_class.from_raw(json) }

      PICTURE_ACCESSORS.each do |attribute|
        it "assigns #{attribute}" do
          expect(subject.send(attribute)).to be
        end
      end
    end
  end

  describe '#save', vcr: true do
    let(:picture) { described_class.new title: "Wohnzimmer" }
    let(:file) { file_fixture("png.png") }
    let(:attachable) { "68492877" }

    it 'set attributes' do
      picture.file = file
      picture.attachable = attachable
      expect(picture.save).to be
    end
  end
end
