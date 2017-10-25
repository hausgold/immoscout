# frozen_string_literal: true

require "spec_helper"

CONTACT_ACCESSORS = %w[
  id
  email
  salutation
  title
  country_code
  firstname
  lastname
  addition_name
  fax_number_country_code
  fax_number_area_code
  fax_number_subscriber
  phone_number_country_code
  phone_number_area_code
  phone_number_subscriber
  cell_phone_number_country_code
  cell_phone_number_area_code
  cell_phone_number_subscriber
  homepage_url
  position
  office_hours
  default_contact
  local_partner_contact
  business_card_contact
  real_estate_reference_count
  external_id
  show_on_profile_page
].freeze

RSpec.describe Immoscout::Resources::Contact do
  let(:json) { JSON.parse(file_fixture("contact.json").read) }
  let(:instance) { described_class.new(json) }

  describe '#new' do
    context 'with hash argument' do
      let(:subject) { described_class.new(json) }

      CONTACT_ACCESSORS.each do |attribute|
        it "assigns #{attribute}" do
          expect(subject.send(attribute)).to be
        end
      end
    end
  end

  describe '.find', vcr: true do
    it 'returns an instance' do
      expect(described_class.find('82295371')).to \
        be_an_instance_of(described_class)
    end
  end

  describe '.all', vcr: true do
    it 'returns an array of instances' do
      expect(described_class.all).to be_an(Array)
    end
  end

  describe '#save', vcr: true do
    let(:contact) { described_class.find('82295371') }

    it 'changes attributes' do
      contact.email = "mynemail@example.com"
      expect(contact.save).to be
      expect(contact.email).to eq "mynemail@example.com"
    end
  end
end
