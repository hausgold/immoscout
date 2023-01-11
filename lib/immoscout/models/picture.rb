# frozen_string_literal: true

require_relative 'concerns/renderable'
require_relative 'concerns/propertiable'
require_relative 'parts/urls'
require_relative 'actions/attachment'

module Immoscout
  module Models
    # Attachment (picture) of a Real Estate.
    # See: https://bit.ly/3iE6K9h
    class Picture < Base
      include Immoscout::Models::Concerns::Renderable
      include Immoscout::Models::Concerns::Propertiable
      include Immoscout::Models::Actions::Attachment

      attr_accessor :attachable, :file

      self.json_wrapper = 'common.attachment'

      property :id, alias: :@id
      property :type, alias: :'@xsi.type', default: 'common:Picture'
      property :href, alias: :'@xlink.href'
      property :publish_date, alias: :@publish_date
      property :creation, alias: :@creation
      property :modification, alias: :@modification
      property :title
      property :external_id
      property :external_check_sum
      property :floorplan
      property :title_picture
      property :urls, coerce: Immoscout::Models::Parts::Urls, array: true
    end
  end
end
