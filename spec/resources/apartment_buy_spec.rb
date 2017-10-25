# frozen_string_literal: true

require "spec_helper"

APARTMENT_ACCESSORS = %w[
  apartment_type
  floor
  lift
  assisted_living
  built_in_kitchen
  balcony
  certificate_of_eligibility_needed
  garden
  service_charge
].freeze

RSpec.describe Immoscout::Resources::ApartmentBuy do
  let(:json) { JSON.parse(file_fixture("apartment.json").read) }
  let(:instance) { described_class.new(json) }

  it_behaves_like "a residential property" do
    let(:json) { JSON.parse(file_fixture("apartment.json").read) }
  end

  describe '#new' do
    context 'with hash argument' do
      let(:subject) { described_class.new(json) }

      APARTMENT_ACCESSORS.each do |attribute|
        it "assigns #{attribute}" do
          expect(subject.send(attribute)).to be
        end
      end
    end
  end

  describe '#to_json' do
    it 'renders energy_sources_enev2014' do
      expect(instance.to_json).to include_json(
        'realestates.apartmentBuy' => {
          energySourcesEnev2014: {
            energySourceEnev2014: be_instance_of(Array)
          }
        }
      )
    end
  end
end
