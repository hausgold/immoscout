# frozen_string_literal: true

require_relative 'concerns/renderable'
require_relative 'concerns/propertiable'
require_relative 'actions/contact'
require_relative 'parts/address'

module Immoscout
  module Models
    class Contact < Base
      include Immoscout::Models::Concerns::Renderable
      include Immoscout::Models::Concerns::Propertiable
      include Immoscout::Models::Actions::Contact

      self.json_wrapper = "common.realtorContactDetail"

      property :id, alias: :@id
      property :email
      property :salutation
      property :firstname
      property :lastname
      property :fax_number
      property :fax_number_country_code,
               readonly: proc { |contact| contact.fax_number.present? }
      property :fax_number_area_code,
               readonly: proc { |contact| contact.fax_number.present? }
      property :fax_number_subscriber,
               readonly: proc { |contact| contact.fax_number.present? }
      property :phone_number
      property :phone_number_country_code,
               readonly: proc { |contact| contact.phone_number.present? }
      property :phone_number_area_code,
               readonly: proc { |contact| contact.phone_number.present? }
      property :phone_number_subscriber,
               readonly: proc { |contact| contact.phone_number.present? }
      property :cell_phone_number
      property :cell_phone_number_country_code,
               readonly: proc { |contact| contact.cell_phone_number.present? }
      property :cell_phone_number_area_code,
               readonly: proc { |contact| contact.cell_phone_number.present? }
      property :cell_phone_number_subscriber,
               readonly: proc { |contact| contact.cell_phone_number.present? }
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
