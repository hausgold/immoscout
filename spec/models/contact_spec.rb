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

RSpec.describe Immoscout::Models::Contact do
  let(:json) { JSON.parse(file_fixture("contact.json").read) }
  let(:instance) { described_class.new_raw(json) }
  let(:resource_id) { '82295371' }

  describe '.new_raw' do
    context 'with hash argument' do
      let(:subject) { described_class.new_raw(json) }

      CONTACT_ACCESSORS.each do |attribute|
        it "assigns #{attribute}" do
          expect(subject.send(attribute)).to be
        end
      end
    end
  end

  describe '.find', vcr: true do
    it 'returns an instance' do
      expect(described_class.find(resource_id)).to \
        be_an_instance_of(described_class)
    end
  end

  describe '.all', vcr: true do
    let(:result) { described_class.all }

    it 'returns an array' do
      expect(result).to be_an(Array)
    end

    it 'returns instances of contact' do
      expect(result.all? { |c| c.is_a? described_class }).to be
    end
  end

  describe '#save', vcr: true do
    context 'not persisted' do
      let(:contact) { described_class.new }

      it 'set attributes' do
        contact.firstname = "Hans"
        contact.lastname = "Meiser"
        contact.email = "hans.meiser@example.com"
        expect(contact.save).to be
        expect(contact.email).to eq "hans.meiser@example.com"
        expect(contact.firstname).to eq "Hans"
        expect(contact.lastname).to eq "Meiser"
      end
    end

    context 'persisted' do
      let(:contact) { described_class.find(resource_id) }

      it 'changes attributes' do
        contact.email = "mynemail@example.com"
        expect(contact.save).to be
        expect(contact.email).to eq "mynemail@example.com"
      end
    end
  end

  describe '#destroy', vcr: true do
    let(:contact) { described_class.find("82495983") }

    it 'returns the deleted object' do
      expect(contact.destroy).to be
    end
  end
end
