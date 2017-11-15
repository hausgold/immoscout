require 'json'
require_relative '../concerns/modelable'

module Immoscout
  module Models
    module Actions
      module RealEstate
        extend ActiveSupport::Concern

        included do
          include Immoscout::Models::Concerns::Modelable

          self.unpack_collection = proc do |hash|
            hash.dig(
              "realestates.realEstates",
              "realEstateList",
              "realEstateElement"
            )
          end

          def save(user_id = :me)
            response = \
              if try(:id)
                api.put("user/#{user_id}/realestate/#{id}", as_json)
              else
                api.post("user/#{user_id}/realestate", as_json)
              end

            handle_response(response)
            self
          end

          def destroy(user_id = :me)
            response = api.delete("user/#{user_id}/realestate/#{id}")
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

          def place(type, user_id = :me)
            check_placement_type(type)
            response = api.post("user/#{user_id}/realestate/#{id}/#{type}")
            handle_response(response)
            self
          end

          def unplace(type, user_id = :me)
            check_placement_type(type)
            response = api.delete("user/#{user_id}/realestate/#{id}/#{type}")
            handle_response(response)
            self
          end

          private

          def check_placement_type(type)
            raise ArgumentError, "Unknown placement type '#{type}'" unless %w[
              topplacement premiumplacement showcaseplacement
            ].include?(type.to_s)
          end
        end

        class_methods do
          def find(id, user_id = :me)
            response = api.get("user/#{user_id}/realestate/#{id}")
            handle_response(response)
            from_raw(response.body)
          end

          def all(user_id = :me)
            response = api.get("user/#{user_id}/realestate")
            handle_response(response)
            objects = unpack_collection.call(response.body)
            objects.map { |object| new(object) }
          end

          def first(user_id = :me)
            all(user_id).first
          end

          def last(user_id = :me)
            all(user_id).last
          end

          def create(hash, user_id = :me)
            instance = new(hash)
            instance.save(user_id)
            instance
          end
        end
      end
    end
  end
end
