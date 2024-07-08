# frozen_string_literal: true

RSpec.shared_examples 'a residential property' do
  describe '.new' do
    it 'returns residential object' do
      expect(described_class.new).to be_instance_of described_class
    end
  end

  describe '.from_raw' do
    let(:instance) { described_class.from_raw(json) }

    %w[
      id
      creation_date
      last_modification_date
      title
      external_id
      description_note
      furnishing_note
      location_note
      other_note
      cellar
      handicapped_accessible
      number_of_parking_spaces
      condition
      last_refurbishment
      interior_quality
      construction_year
      free_from
      heating_type_enev2014
      building_energy_rating_type
      thermal_characteristic
      energy_consumption_contains_warm_water
      number_of_floors
      usable_floor_space
      number_of_bed_rooms
      number_of_bath_rooms
      guest_toilet
      parking_space_type
      rented
      rental_income
      listed
      parking_space_price
      summer_residence_practical
      living_space
      number_of_rooms
      energy_performance_certificate
    ].each do |attribute|
      it "assigns #{attribute}" do
        expect(instance.send(attribute)).not_to be_nil
      end
    end

    it 'assigns address parts (street)' do
      expect(instance.address.street).not_to be_nil
    end

    it 'assigns address parts (house_number)' do
      expect(instance.address.house_number).not_to be_nil
    end

    it 'assigns address parts (postcode)' do
      expect(instance.address.postcode).not_to be_nil
    end

    it 'assigns address parts (city)' do
      expect(instance.address.city).not_to be_nil
    end

    it 'assigns address parts (international_country_region.country)' do
      expect(instance.address.international_country_region.country).not_to \
        be_nil
    end

    it 'assigns address parts (international_country_region.region)' do
      expect(instance.address.international_country_region.region).not_to \
        be_nil
    end

    it 'assigns address parts (show_address)' do
      expect(instance.show_address).not_to be_nil
    end

    it 'assigns contact parts' do
      expect(instance.contact.id).not_to be_nil
    end

    it 'assigns price parts (value)' do
      expect(instance.price.value).not_to be_nil
    end

    it 'assigns price parts (currency)' do
      expect(instance.price.currency).not_to be_nil
    end

    it 'assigns price parts (marketing_type)' do
      expect(instance.price.marketing_type).not_to be_nil
    end

    it 'assigns price parts (price_interval_type)' do
      expect(instance.price.price_interval_type).not_to be_nil
    end

    it 'assigns courtage parts (has_courtage)' do
      expect(instance.courtage.has_courtage).not_to be_nil
    end

    it 'assigns courtage parts (courtage)' do
      expect(instance.courtage.courtage).not_to be_nil
    end

    it 'assigns courtage parts (courtage_note)' do
      expect(instance.courtage.courtage_note).not_to be_nil
    end

    it 'assigns api search data parts (search_field1)' do
      expect(instance.api_search_data.search_field1).not_to be_nil
    end

    it 'assigns api search data parts (search_field2)' do
      expect(instance.api_search_data.search_field2).not_to be_nil
    end

    it 'assigns api search data parts (search_field3)' do
      expect(instance.api_search_data.search_field3).not_to be_nil
    end

    it 'assigns energy source parts' do
      expect(
        instance.energy_sources_enev2014.energy_source_enev2014
      ).to be_instance_of(Array)
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

    it 'returns instances' do
      expect(result).to all(be_a(described_class))
    end
  end

  describe '.create', :vcr do
    it 'returns the instance' do
      expect(
        described_class.create(create_hash)
      ).to be_a(described_class)
    end
  end

  describe '#save', :vcr do
    context 'when not persisted' do
      let(:estate) { described_class.new(create_hash) }

      it 'returns the instance' do
        expect(estate.save).to be_a(described_class)
      end
    end

    context 'when persisted' do
      let(:estate) { described_class.find(resource_id) }

      it 'changes attributes' do
        estate.title = 'Neuer Titel'
        estate.save
        expect(estate.title).to eql('Neuer Titel')
      end
    end
  end

  describe '#publish', :vcr do
    let(:estate) { described_class.find(resource_id) }

    it 'returns publish instance' do
      expect(estate.publish).to be_instance_of(Immoscout::Models::Publish)
    end
  end

  describe '#unpublish', :vcr do
    let(:estate) { described_class.find(resource_id) }

    it 'returns publish instance' do
      expect(estate.unpublish).to be_instance_of(Immoscout::Models::Publish)
    end
  end

  describe '#destroy', :vcr do
    let(:estate) { described_class.find(resource_id) }

    it 'returns the deleted object' do
      expect(estate.destroy).to be_a(described_class)
    end
  end
end
