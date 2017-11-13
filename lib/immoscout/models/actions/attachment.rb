require 'json'
require_relative '../concerns/modelable'

module Immoscout
  module Models
    module Actions
      module Attachment
        extend ActiveSupport::Concern

        included do
          include Immoscout::Models::Concerns::Modelable

          self.unpack_collection = proc do |hash|
            hash
              .fetch("common.attachments")
              .first
              .fetch("attachment")
          end

          # def save
          #   response = api.post("publish", as_json)
          #   handle_response(response)
          #   self
          # end
          #
          # def destroy
          #   response = api.delete(
          #     "publish/#{real_estate.id}_#{publish_channel.id}"
          #   )
          #   handle_response(response)
          #   self
          # end
        end

        class_methods do
          def all(real_estate_id, user_id = :me)
            response = api.get(
              "user/#{user_id}/realestate/#{real_estate_id}/attachment"
            )
            handle_response(response)
            objects = unpack_collection.call(response.body)
            objects
              .map { |object| new(object) }
              .select { |object| object.type =~ /#{name.demodulize}/i }
          end
        end
      end
    end
  end
end
