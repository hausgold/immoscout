# frozen_string_literal: true

module Immoscout
  module Models
    # Attachment (document) of a Real Estate.
    # See: https://bit.ly/3Xx32gj
    class Document < Base
      include Immoscout::Models::Concerns::Renderable
      include Immoscout::Models::Concerns::Propertiable
      include Immoscout::Models::Actions::Attachment

      attr_accessor :attachable, :file

      self.json_wrapper = 'common.attachment'

      property :id, alias: :@id
      property :type, alias: :'@xsi.type'
      property :href, alias: :'@xlink.href'
      property :publish_date, alias: :@publish_date
      property :creation, alias: :@creation
      property :modification, alias: :@modification
      property :title
      property :external_id
      property :external_check_sum
      property :floorplan
      property :url
    end
  end
end
