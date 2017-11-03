# frozen_string_literal: true

require_relative 'concerns/renderable'
require_relative 'concerns/propertiable'

require_relative 'parts/api_search_data'
require_relative 'parts/address'
require_relative 'parts/contact'
require_relative 'parts/price'
require_relative 'parts/courtage'
require_relative 'parts/energy_source'

require_relative 'model'

module Immoscout
  module Models
    class HouseBuy < Model
      include Immoscout::Models::Concerns::Renderable
      include Immoscout::Models::Concerns::Propertiable

      property :id, alias: :@id
      property :external_id
      property :title
      property :creation_date
      property :last_modification_date
      property :address, coerce: Immoscout::Models::Parts::Address
      property :api_search_data, coerce: Immoscout::Models::Parts::ApiSearchData
      property :real_estate_state
      property :description_note
      property :furnishing_note
      property :location_note
      property :other_note
      property :show_address
      property :contact, coerce: Immoscout::Models::Parts::Contact
      property :building_type

      property :price, coerce: Immoscout::Models::Parts::Price
      property :courtage, coerce: Immoscout::Models::Parts::Courtage
      property :energy_sources_enev2014,
               coerce: Immoscout::Models::Parts::EnergySource
      property :cellar
      property :handicapped_accessible
      property :number_of_parking_spaces
      property :condition
      property :last_refurbishment
      property :interior_quality
      property :construction_year
      property :free_from
      property :heating_type_enev2014
      property :building_energy_rating_type
      property :thermal_characteristic
      property :energy_consumption_contains_warm_water
      property :number_of_floors
      property :usable_floor_space
      property :number_of_bed_rooms
      property :number_of_bath_rooms
      property :guest_toilet
      property :parking_space_type
      property :rented
      property :rental_income
      property :listed
      property :parking_space_price
      property :summer_residence_practical
      property :living_space
      property :number_of_rooms
      property :energy_performance_certificate
      property :lodger_flat
      property :construction_phase
      property :plot_area

      def self.url_identifier
        'realestate'
      end

      def self.unpack_collection(hash)
        hash.dig(
          "realestates.realEstates",
          "realEstateList",
          "realEstateElement"
        )
      end

      def self.json_wrapper
        "realestates.houseBuy"
      end

      def self.identifies?(hash)
        (
          hash.count == 1 && hash.keys.first =~ /^realestates.houseBuy/
        ) || hash["@xsi.type"] == "offerlistelement:OfferHouseBuy"
      end
    end
  end
end
