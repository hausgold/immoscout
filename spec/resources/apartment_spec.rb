# frozen_string_literal: true

require "spec_helper"

RSpec.describe Immoscout::Resources::Apartment do
  let(:json) { JSON.parse(file_fixture("apartment.json").read) }
  let(:instance) { described_class.new(json) }

  it_behaves_like "a residential property" do
    let(:json) { JSON.parse(file_fixture("apartment.json").read) }
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
