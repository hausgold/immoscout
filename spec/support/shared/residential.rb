RESIDENTIAL_ACCESSORS = %w[
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
].freeze

RSpec.shared_examples "a residential property" do
  describe '#new' do
    context 'without arguments' do
      it "returns residential object" do
        expect(described_class.new).to be_instance_of described_class
      end
    end

    context 'with hash argument' do
      let(:subject) { described_class.new(json) }
      RESIDENTIAL_ACCESSORS.each do |attribute|
        it "assigns #{attribute}" do
          expect(subject.send(attribute)).to be
        end
      end

      it 'assigns address parts' do
        expect(subject.address.street).to be
        expect(subject.address.house_number).to be
        expect(subject.address.postcode).to be
        expect(subject.address.city).to be
        expect(subject.show_address).to be
      end

      it 'assigns contact parts' do
        expect(subject.contact.id).to be
      end

      it 'assigns price parts' do
        expect(subject.price.value).to be
        expect(subject.price.currency).to be
        expect(subject.price.marketing_type).to be
        expect(subject.price.price_interval_type).to be
      end

      it 'assigns courtage parts' do
        expect(subject.courtage.has_courtage).to be
        expect(subject.courtage.courtage).to be
        expect(subject.courtage.courtage_note).to be
      end

      it 'assigns api search data parts' do
        expect(subject.api_search_data.search_field1).to be
        expect(subject.api_search_data.search_field2).to be
        expect(subject.api_search_data.search_field3).to be
      end

      it 'assigns energy source parts' do
        expect(
          subject.energy_sources_enev2014.energy_source_enev2014
        ).to be_instance_of(Array)
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
    it 'returns an array of instances' do
      expect(described_class.all).to be_an(Array)
    end
  end

  describe '#save', vcr: true do
    context 'not persisted' do
      let(:estate) { described_class.new(json) }

      it 'set attributes' do
        estate.delete("@id") # remove ids and mimic not persisted object
        estate.delete("external_id")
        estate.contact.id = '82295371' # link existent contact
        estate.title = "Neuer Immo Titel"
        expect(estate.save).to be
        expect(estate.title).to eq "Neuer Immo Titel"
      end
    end

    context 'persisted' do
      let(:estate) { described_class.find(resource_id) }

      it 'changes attributes' do
        estate.title = "Neuer Titel"
        expect(estate.save).to be
        expect(estate.title).to eq "Neuer Titel"
      end
    end
  end

  describe '#destroy', vcr: true do
    let(:estate) { described_class.find(resource_id) }

    it 'returns the deleted object' do
      expect(estate.destroy).to be
    end
  end
end
