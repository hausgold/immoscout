# frozen_string_literal: true

module Immoscout
  module Models
    # The Publish (object) of a Real Estate.
    # See: https://bit.ly/3ZFoYYI
    class Publish < Base
      include Immoscout::Models::Concerns::Renderable
      include Immoscout::Models::Concerns::Propertiable
      include Immoscout::Models::Actions::Publish

      self.json_wrapper = 'common.publishObject'

      property :real_estate, coerce: Immoscout::Models::Parts::RealEstate
      property :publish_channel,
               coerce: Immoscout::Models::Parts::PublishChannel
    end
  end
end
