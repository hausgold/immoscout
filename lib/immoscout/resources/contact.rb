# frozen_string_literal: true

require_relative 'concerns/renderable'
require_relative 'concerns/with_address'

module Immoscout
  module Resources
    class Contact < Base
      include Immoscout::Resources::Concerns::Renderable
      include Immoscout::Resources::Concerns::WithAddress

      attr_reader :type_identifier

      def initialize(hash = nil)
        if hash && hash.count == 1 && hash.keys.first =~ /^common.realtorContactDetail/
          @type_identifier = hash.keys.first
          super(hash.values.first)
        else
          @type_identifier = self.class.name.demodulize.camelize(:lower)
          super
        end
      end

      def self.client
        @@client ||= Immoscout::Api::Client.new
      end

      # TODO: move to module/class
      def self.find(id, user_id = :me)
        response = client.get("user/#{user_id}/contact/#{id}")
        raise Immoscout::Errors::NotFound, "#{response.status} with '#{response.body}'" unless response.success?
        new(response.body)
      end

      def self.all(user_id = :me)
        response = client.get("user/#{user_id}/contact")
        raise Immoscout::Errors::NotFound, "#{response.status} with '#{response.body}'" unless response.success?
        objects = response.body["common.realtorContactDetailsList"]["realtorContactDetails"]
        objects.map { |object| new(object) }
      end

      def save(user_id = :me)
        response = self.class.client.put("user/#{user_id}/contact/#{id}", as_json)
        raise Immoscout::Errors::NotFound, "#{response.status} with '#{response.body}'" unless response.success?
        update_attributes!(response.body)
      end

      def update(hash, user_id = :me)
        # TODO: implement me
      end

      def destroy(user_id = :me)
        # TODO: implement me
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
