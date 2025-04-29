# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength -- because this is how an ActiveSupport
#   concern looks like
module Immoscout
  module Models
    module Actions
      # Actions to work with attachments.
      module Attachment
        extend ActiveSupport::Concern

        included do
          include Immoscout::Models::Concerns::Modelable

          self.unpack_collection = proc do |hash|
            hash
              .fetch('common.attachments')
              .first
              .fetch('attachment')
          end

          # rubocop:disable Metrics/AbcSize -- because this is the bare minimum
          #   logic
          # rubocop:disable Metrics/MethodLength -- ditto
          def save
            attachable_id = attachable.try(:id) || attachable
            response = api.post(
              "user/#{api.user_name}/realestate/#{attachable_id}/attachment",
              nil,
              attachment: Faraday::UploadIO.new(file, content_type, file_name),
              metadata: Faraday::UploadIO.new(
                StringIO.new(to_json),
                'application/json',
                'metadata.json'
              )
            )
            handle_response(response)
            self.id = id_from_response(response)
            self
          end
          # rubocop:enable Metrics/AbcSize
          # rubocop:enable Metrics/MethodLength

          def destroy
            attachable_id = attachable.try(:id) || attachable
            response = api.delete(
              "user/#{api.user_name}/" \
              "realestate/#{attachable_id}/" \
              "attachment/#{id}"
            )
            handle_response(response)
            self
          end

          protected

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
              '.jpg' => 'image/jpeg',
              '.jpeg' => 'image/jpeg',
              '.gif' => 'image/gif',
              '.png' => 'image/png',
              '.pdf' => 'application/pdf'
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
# rubocop:enable Metrics/BlockLength
