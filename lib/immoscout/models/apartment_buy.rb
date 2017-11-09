# frozen_string_literal: true

require_relative 'concerns/renderable'
require_relative 'concerns/propertiable'

require_relative 'actions/real_estate'

require_relative 'parts/api_search_data'
require_relative 'parts/address'
require_relative 'parts/contact'
require_relative 'parts/price'
require_relative 'parts/courtage'
require_relative 'parts/energy_source'

module Immoscout
  module Models
    class ApartmentBuy < Base
      include Immoscout::Models::Concerns::Renderable
      include Immoscout::Models::Concerns::Propertiable
      include Immoscout::Models::Actions::RealEstate

      self.json_wrapper = "realestates.apartmentBuy"

      property :id, alias: :@id
      property :address, coerce: Immoscout::Models::Parts::Address
      property :creation_date
      property :price, coerce: Immoscout::Models::Parts::Price
      property :courtage, coerce: Immoscout::Models::Parts::Courtage
      property :energy_sources_enev2014,
               coerce: Immoscout::Models::Parts::EnergySource
      property :contact, coerce: Immoscout::Models::Parts::Contact
      property :last_modification_date
      property :title
      property :external_id
      property :description_note
      property :furnishing_note
      property :location_note
      property :other_note
      property :cellar
      property :api_search_data, coerce: Immoscout::Models::Parts::ApiSearchData
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
      property :show_address

      property :apartment_type
      property :floor
      property :lift
      property :assisted_living
      property :built_in_kitchen
      property :balcony
      property :certificate_of_eligibility_needed
      property :garden
      property :service_charge
    end
  end
end
