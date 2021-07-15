# frozen_string_literal: true

require 'spec_helper'

DOCUMENT_ACCESSORS = %w[
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
  url
].freeze

RSpec.describe Immoscout::Models::Document do
  let(:json) { file_fixture('document.json').read }
  let(:parsed_json) { JSON.parse(json) }
  let(:attachable_id) { '68492877' }
  let(:resource_id) { '672642911' }

  describe '#new' do
    context 'with hash argument' do
      let(:hash) do
        {
          title: 'Grundriss'
        }
      end

      let(:subject) { described_class.new(hash) }

      it 'assigns title' do
        expect(subject.title).to eq 'Grundriss'
      end
    end
  end

  describe '#from_raw' do
    context 'with hash argument' do
      let(:subject) { described_class.from_raw(json) }

      DOCUMENT_ACCESSORS.each do |attribute|
        it "assigns #{attribute}" do
          expect(subject.send(attribute)).to be
        end
      end
    end
  end

  describe '#save', vcr: true do
    let(:document) { described_class.new title: 'Grundriss' }
    let(:file) { file_fixture('pdf.pdf') }

    it 'set attributes' do
      document.file = file
      document.attachable = attachable_id
      expect(document.id).to be_nil
      expect(document.save).to be
      expect(document.id).to be
    end
  end

  describe '#destroy', vcr: true do
    let(:document) { described_class.new(id: resource_id) }

    before do
      document.attachable = attachable_id
    end

    it 'returns the deleted object' do
      expect(document.destroy).to be
    end
  end
end
