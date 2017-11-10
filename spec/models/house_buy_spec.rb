# frozen_string_literal: true

require "spec_helper"

HOUSE_ACCESSORS = %w[
  building_type
  lodger_flat
  construction_phase
  plot_area
].freeze

RSpec.describe Immoscout::Models::HouseBuy do
  let(:json) { file_fixture("house.json").read }
  let(:parsed_json) { JSON.parse(json) }
  let(:instance) { described_class.new_raw(json) }

  it_behaves_like "a residential property" do
    let(:json) { JSON.parse(file_fixture("house.json").read) }
    let(:resource_id) { "68481600" }
    let(:create_hash) do
      {
        title: "test title",
        address: {
          street: "Berliner straße",
          house_number: 10,
          postcode: "10243",
          city: "Berlin"
        },
        building_type: "SINGLE_FAMILY_HOUSE",
        plot_area: 10_000,
        living_space: 100,
        number_of_rooms: 4,
        price: {
          currency: "EUR",
          marketing_type: "PURCHASE",
          price_interval_type: "ONE_TIME_CHARGE",
          value: 400_000
        }
      }
    end
  end

  describe '.new_raw' do
    context 'with hash argument' do
      let(:subject) { described_class.new_raw(parsed_json) }

      HOUSE_ACCESSORS.each do |attribute|
        it "assigns #{attribute}" do
          expect(subject.send(attribute)).to be
        end
      end
    end

    context 'with json argument' do
      let(:subject) { described_class.new_raw(json) }

      HOUSE_ACCESSORS.each do |attribute|
        it "assigns #{attribute}" do
          expect(subject.send(attribute)).to be
        end
      end
    end
  end

  describe '#to_json' do
    it 'renders energy_sources_enev2014' do
      expect(instance.to_json).to include_json(
        'realestates.houseBuy' => {
          energySourcesEnev2014: {
            energySourceEnev2014: be_instance_of(Array)
          }
        }
      )
    end
  end
end
