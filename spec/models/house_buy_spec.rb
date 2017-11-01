# frozen_string_literal: true

require "spec_helper"

HOUSE_ACCESSORS = %w[
  building_type
  lodger_flat
  construction_phase
  plot_area
].freeze

RSpec.describe Immoscout::Models::HouseBuy do
  let(:json) { JSON.parse(file_fixture("house.json").read) }
  let(:instance) { described_class.new(json) }

  it_behaves_like "a residential property" do
    let(:json) { JSON.parse(file_fixture("house.json").read) }
    let(:resource_id) { "68492873" }
  end

  describe '#new' do
    context 'with hash argument' do
      let(:subject) { described_class.new(json) }

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
