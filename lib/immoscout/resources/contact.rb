# frozen_string_literal: true

require_relative 'concerns/renderable'
require_relative 'concerns/with_address'

module Immoscout
  module Resources
    class Contact < Model
      include Immoscout::Resources::Concerns::Renderable
      include Immoscout::Resources::Concerns::WithAddress

      def self.json_root_matcher
        /^common.realtorContactDetail/
      end

      def self.url_identifier
        'contact'
      end

      def self.unpack_collection
        proc do |body|
          body.dig(
            "common.realtorContactDetailsList",
            "realtorContactDetails"
          )
        end
      end

      property :@id, from: :id
      alias_method :id, :@id
      property :email
      property :salutation
      property :title
      property :country_code, from: :countryCode
      property :firstname
      property :lastname
      property :addition_name, from: :additionName
      property :fax_number_country_code, from: :faxNumberCountryCode
      property :fax_number_area_code, from: :faxNumberAreaCode
      property :fax_number_subscriber, from: :faxNumberSubscriber
      property :phone_number_country_code, from: :phoneNumberCountryCode
      property :phone_number_area_code, from: :phoneNumberAreaCode
      property :phone_number_subscriber, from: :phoneNumberSubscriber
      property :cell_phone_number_country_code,
               from: :cellPhoneNumberCountryCode
      property :cell_phone_number_area_code, from: :cellPhoneNumberAreaCode
      property :cell_phone_number_subscriber, from: :cellPhoneNumberSubscriber
      property :homepage_url, from: :homepageUrl
      property :position
      property :office_hours, from: :officeHours
      property :default_contact, from: :defaultContact
      property :local_partner_contact, from: :localPartnerContact
      property :business_card_contact, from: :businessCardContact
      property :real_estate_reference_count, from: :realEstateReferenceCount
      property :external_id, from: :externalId
      property :show_on_profile_page, from: :showOnProfilePage
    end
  end
end
