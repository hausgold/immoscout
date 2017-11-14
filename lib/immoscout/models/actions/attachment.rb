require 'json'
require_relative '../concerns/modelable'

module Immoscout
  module Models
    module Actions
      module Attachment
        extend ActiveSupport::Concern

        included do
          include Immoscout::Models::Concerns::Modelable

          EXTENSION_CONTENT_TYPE_MAPPING = {
            ".jpg"  => "image/jpeg",
            ".jpeg" => "image/jpeg",
            ".gif"  => "image/gif",
            ".png"  => "image/png",
            ".pdf"  => "application/pdf"
          }.freeze

          self.unpack_collection = proc do |hash|
            hash
              .fetch("common.attachments")
              .first
              .fetch("attachment")
          end

          def save(user_id = :me)
            attachable_id = attachable.try(:id) || attachable
            response = api.post(
              "user/#{user_id}/realestate/#{attachable_id}/attachment",
              nil,
              attachment: Faraday::UploadIO.new(file, content_type, file_name),
              metadata: as_json
            )
            handle_response(response)
            self
          end

          # def destroy
          #   response = api.delete(
          #     "publish/#{real_estate.id}_#{publish_channel.id}"
          #   )
          #   handle_response(response)
          #   self
          # end

          private

          def file_extension
            File.extname(file_name)
          end

          def file_name
            File.basename(file)
          end

          def content_type
            EXTENSION_CONTENT_TYPE_MAPPING.fetch file_extension.downcase
          end
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
