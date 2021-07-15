# frozen_string_literal: true

require 'json'
require_relative '../concerns/modelable'

# rubocop:disable Metrics/BlockLength because this is how an ActiveSupport
#   concern looks like
module Immoscout
  module Models
    module Actions
      module Contact
        extend ActiveSupport::Concern

        included do
          include Immoscout::Models::Concerns::Modelable

          self.unpack_collection = proc do |hash|
            hash
              .fetch('common.realtorContactDetailsList', {})
              .fetch('realtorContactDetails', nil)
          end

          # rubocop:disable Metrics/AbcSize because this is the
          #   bare minimum logic
          def save
            response = \
              if id
                api.put("user/#{api.user_name}/contact/#{id}", as_json)
              else
                api.post("user/#{api.user_name}/contact", as_json)
              end

            handle_response(response)
            self.id = id_from_response(response) unless id
            self
          end
          # rubocop:enable Metrics/AbcSize

          def destroy
            response = api.delete("user/#{api.user_name}/contact/#{id}")
            handle_response(response)
            self
          end
        end

        class_methods do
          def find(id)
            response = api.get("user/#{api.user_name}/contact/#{id}")
            handle_response(response)
            from_raw(response.body)
          end

          def find_by(hash)
            external_id = hash.symbolize_keys.fetch(:external_id)
            find("ext-#{external_id}")
          end

          def all
            response = api.get("user/#{api.user_name}/contact")
            handle_response(response)
            objects = unpack_collection.call(response.body)
            objects.map { |object| new(object) }
          end

          def first
            all.first
          end

          def last
            all.last
          end

          def create(hash)
            instance = new(hash)
            instance.save
            instance
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
