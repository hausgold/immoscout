# frozen_string_literal: true

require_relative 'concerns/renderable'
require_relative 'concerns/propertiable'
require_relative 'parts/address'

module Immoscout
  module Models
    class Contact < Model
      include Immoscout::Models::Concerns::Renderable
      include Immoscout::Models::Concerns::Propertiable

      self.url_identifier = 'contact'
      self.json_wrapper   = "common.realtorContactDetail"

      def self.unpack_collection(hash)
        hash.dig(
          "common.realtorContactDetailsList",
          "realtorContactDetails"
        )
      end

      def self.identifies?(hash)
        hash.count == 1 && hash.keys.first == json_wrapper
      end

      property :id, alias: :@id
      property :email
      property :salutation
      property :firstname
      property :lastname
      property :fax_number_country_code
      property :fax_number_area_code
      property :fax_number_subscriber
      property :phone_number_country_code
      property :phone_number_area_code
      property :phone_number_subscriber
      property :cell_phone_number_country_code
      property :cell_phone_number_area_code
      property :cell_phone_number_subscriber
      property :address, coerce: Immoscout::Models::Parts::Address
      property :country_code
      property :title
      property :addition_name
      property :company
      property :homepage_url
      property :position
      property :office_hours
      property :default_contact
      property :local_partner_contact
      property :business_card_contact
      property :real_estate_reference_count
      property :external_id
      property :show_on_profile_page
    end
  end
end
