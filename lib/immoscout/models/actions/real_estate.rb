# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength -- because this is how an ActiveSupport
#   concern looks like
module Immoscout
  module Models
    module Actions
      # Actions to work with real estate objects.
      module RealEstate
        extend ActiveSupport::Concern

        included do
          include Immoscout::Models::Concerns::Modelable

          self.unpack_collection = proc do |hash|
            hash
              .fetch('realestates.realEstates', {})
              .fetch('realEstateList', {})
              .fetch('realEstateElement', nil)
          end

          def save
            response =
              if id
                api.put("user/#{api.user_name}/realestate/#{id}", as_json)
              else
                api.post("user/#{api.user_name}/realestate", as_json)
              end

            handle_response(response)
            self.id = id_from_response(response) unless id
            self
          end

          def destroy
            response = api.delete("user/#{api.user_name}/realestate/#{id}")
            handle_response(response)
            self
          end

          def publish(channel = 10_000)
            publisher = Immoscout::Models::Publish.new(
              real_estate: { id: id },
              publish_channel: { id: channel }
            )
            publisher.save
            publisher
          end

          def unpublish(channel = 10_000)
            publisher = Immoscout::Models::Publish.new(
              real_estate: { id: id },
              publish_channel: { id: channel }
            )
            publisher.destroy
            publisher
          end

          def place(type)
            check_placement_type(type)
            response = api.post(
              "user/#{api.user_name}/realestate/#{id}/#{type}"
            )
            handle_response(response)
            self
          end

          def unplace(type)
            check_placement_type(type)
            response = api.delete(
              "user/#{api.user_name}/realestate/#{id}/#{type}"
            )
            handle_response(response)
            self
          end

          protected

          def check_placement_type(type)
            raise ArgumentError, "Unknown placement type '#{type}'" unless %w[
              topplacement premiumplacement showcaseplacement
            ].include?(type.to_s)
          end
        end

        class_methods do
          def find(id)
            response = api.get("user/#{api.user_name}/realestate/#{id}")
            handle_response(response)
            from_raw(response.body)
          end

          def find_by(hash)
            external_id = hash.symbolize_keys.fetch(:external_id)
            find("ext-#{external_id}")
          end

          def all
            response = api.get("user/#{api.user_name}/realestate")
            handle_response(response)
            objects = unpack_collection.call(response.body)
            objects
              .map { |object| new(object) }
              .select { |object| object.type =~ /#{name.demodulize}/i }
          end
          delegate :first, to: :all
          delegate :last, to: :all

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
