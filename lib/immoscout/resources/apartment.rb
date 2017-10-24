# frozen_string_literal: true

module Immoscout
  module Resources
    class Apartment < Residential
      property :apartment_type, from: :apartmentType
      property :floor
      property :lift
      property :assisted_living, from: :assistedLiving
      property :built_in_kitchen, from: :builtInKitchen
      property :balcony
      property :certificate_of_eligibility_needed,
               from: :certificateOfEligibilityNeeded
      property :garden
      property :service_charge, from: :serviceCharge
    end
  end
end
