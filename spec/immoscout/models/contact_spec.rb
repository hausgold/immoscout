# frozen_string_literal: true

require 'spec_helper'

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
  let(:json) { file_fixture('contact.json').read }
  let(:parsed_json) { JSON.parse(json) }
  let(:instance) { described_class.from_raw(json) }
  let(:resource_id) { '82295371' }

  describe '.from_raw' do
    context 'with hash argument' do
      let(:instance) { described_class.from_raw(parsed_json) }

      CONTACT_ACCESSORS.each do |attribute|
        it "assigns #{attribute}" do
          expect(instance.send(attribute)).not_to be_nil
        end
      end
    end

    context 'with json argument' do
      let(:instance) { described_class.from_raw(json) }

      CONTACT_ACCESSORS.each do |attribute|
        it "assigns #{attribute}" do
          expect(instance.send(attribute)).not_to be_nil
        end
      end
    end
  end

  describe '.find', :vcr do
    it 'returns an instance' do
      expect(described_class.find(resource_id)).to \
        be_an_instance_of(described_class)
    end
  end

  describe '.all', :vcr do
    let(:result) { described_class.all }

    it 'returns an array' do
      expect(result).to be_an(Array)
    end

    it 'returns instances of contact' do
      expect(result.all? { |c| c.is_a? described_class }).not_to be_nil
    end
  end

  describe '.create', :vcr do
    let(:hash) do
      {
        email: 'hans.meiser@example.com',
        firstname: 'Hans',
        lastname: 'Meiser'
      }
    end

    it 'returns instance' do
      expect(
        described_class.create(hash)
      ).to be_instance_of(described_class)
    end
  end

  describe '#save', :vcr do
    context 'when not persisted' do
      let(:instance) { described_class.new }

      before do
        instance.firstname = 'Hans'
        instance.lastname = 'Meiser'
        instance.email = 'hans.meiser@example.com'
      end

      it 'set attributes' do
        expect(instance.save).to be(instance)
      end

      it 'set attributes (email)' do
        expect(instance.email).to eql('hans.meiser@example.com')
      end

      it 'set attributes (firstname)' do
        expect(instance.firstname).to eql('Hans')
      end

      it 'set attributes (lastname)' do
        expect(instance.lastname).to eql('Meiser')
      end
    end

    context 'when persisted' do
      let(:instance) { described_class.find(resource_id) }

      it 'changes attributes' do
        instance.email = 'mynemail@example.com'
        expect(instance.save).to be(instance)
      end

      it 'changes attributes (email)' do
        expect(instance.email).to eql('mynemail@example.com')
      end
    end
  end

  describe '#destroy', :vcr do
    let(:instance) { described_class.find('82495983') }

    it 'returns the deleted object' do
      expect(instance.destroy).to be(instance)
    end
  end
end
