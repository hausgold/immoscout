# frozen_string_literal: true

require_relative 'concerns/renderable'
require_relative 'concerns/with_address'
require_relative 'concerns/with_contact'
require_relative 'concerns/with_price'
require_relative 'concerns/with_courtage'
require_relative 'concerns/with_api_search_data'
require_relative 'concerns/with_energy_source'

module Immoscout
  module Resources
    class Residential < Base
      include Immoscout::Resources::Concerns::Renderable
      include Immoscout::Resources::Concerns::WithAddress
      include Immoscout::Resources::Concerns::WithContact
      include Immoscout::Resources::Concerns::WithPrice
      include Immoscout::Resources::Concerns::WithCourtage
      include Immoscout::Resources::Concerns::WithApiSearchData
      include Immoscout::Resources::Concerns::WithEnergySource

      # TODO: move to module/class
      def self.find(id, user_id = :me)
        client = Immoscout::Api::Client.new
        response = client.get("user/#{user_id}/realestate/#{id}")
        new(response.values.first)
      end

      def self.all(user_id = :me)
        client = Immoscout::Api::Client.new
        response = client.get("user/#{user_id}/realestate")
        objects = response["realestates.realEstates"]["realEstateList"]["realEstateElement"]
        objects.map { |object| new(object) }
      end

      def save(user_id = :me)
        client = Immoscout::Api::Client.new
        response = client.put("user/#{user_id}/realestate/#{id}", as_json)
      end

      property :id, from: :@id
      property :creation_date, from: :creationDate
      property :last_modification_date, from: :lastModificationDate
      property :title
      property :external_id, from: :externalId
      property :description_note, from: :descriptionNote
      property :furnishing_note, from: :furnishingNote
      property :location_note, from: :locationNote
      property :other_note, from: :otherNote
      property :cellar
      property :handicapped_accessible, from: :handicappedAccessible
      property :number_of_parking_spaces, from: :numberOfParkingSpaces
      property :condition
      property :last_refurbishment, from: :lastRefurbishment
      property :interior_quality, from: :interiorQuality
      property :construction_year, from: :constructionYear
      property :free_from, from: :freeFrom
      property :heating_type_enev2014, from: :heatingTypeEnev2014
      property :building_energy_rating_type, from: :buildingEnergyRatingType
      property :thermal_characteristic, from: :thermalCharacteristic
      property :energy_consumption_contains_warm_water,
               from: :energyConsumptionContainsWarmWater
      property :number_of_floors, from: :numberOfFloors
      property :usable_floor_space, from: :usableFloorSpace
      property :number_of_bed_rooms, from: :numberOfBedRooms
      property :number_of_bath_rooms, from: :numberOfBathRooms
      property :guest_toilet, from: :guestToilet
      property :parking_space_type, from: :parkingSpaceType
      property :rented
      property :rental_income, from: :rentalIncome
      property :listed
      property :parking_space_price, from: :parkingSpacePrice
      property :summer_residence_practical, from: :summerResidencePractical
      property :living_space, from: :livingSpace
      property :number_of_rooms, from: :numberOfRooms
      property :energy_performance_certificate,
               from: :energyPerformanceCertificate
    end
  end
end
