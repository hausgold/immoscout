ACCESSORS = %w[
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
  let(:subject) { described_class.new(json) }

  describe '#new' do
    ACCESSORS.each do |attribute|
      it "assigns #{attribute}" do
        expect(subject.send(attribute)).to be
      end
    end

    it 'assigns energy_sources_enev2014' do
      expect(
        subject.energy_sources_enev2014.energy_source_enev2014
      ).to be_instance_of(Array)
    end
  end

  describe '.find' do
    it 'works' do
      expect(described_class.find('68422021')).to be_an_instance_of(described_class)
    end
  end

  describe '.all' do
    it 'works' do
      expect(described_class.all).to be_an(Array)
    end
  end

  describe '#save' do
    let(:estate) { described_class.find('68422021') }

    it 'works' do
      estate.title = "Neuer Titel"
      expect(estate.save).to be
    end
  end
end
