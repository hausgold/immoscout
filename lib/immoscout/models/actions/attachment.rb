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

          def save
            attachable_id = attachable.try(:id) || attachable
            response = api.post(
              "user/#{api.user_name}/realestate/#{attachable_id}/attachment",
              nil,
              attachment: Faraday::UploadIO.new(file, content_type, file_name),
              metadata: as_json
            )
            handle_response(response)
            self.id = id_from_response(response)
            self
          end

          def destroy
            attachable_id = attachable.try(:id) || attachable
            response = api.delete(
              "user/#{api.user_name}/realestate/#{attachable_id}/attachment/#{id}",
            )
            handle_response(response)
            self
          end

          private

          def file_extension
            File.extname(file_name)
          end

          def file_name
            File.basename(file)
          end

          def content_type
            self.class.content_type_from_extension file_extension.downcase
          end
        end

        class_methods do
          def content_type_from_extension(ext)
            {
              ".jpg"  => "image/jpeg",
              ".jpeg" => "image/jpeg",
              ".gif"  => "image/gif",
              ".png"  => "image/png",
              ".pdf"  => "application/pdf"
            }.fetch(ext)
          end

          def all(real_estate_id)
            response = api.get(
              "user/#{api.user_name}/realestate/#{real_estate_id}/attachment"
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
