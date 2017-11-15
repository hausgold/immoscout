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

          def save
            response = \
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

          private

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

          def all
            response = api.get("user/#{api.user_name}/realestate")
            handle_response(response)
            objects = unpack_collection.call(response.body)
            objects
              .map { |object| new(object) }
              .select { |object| object.type =~ /#{name.demodulize}/i }
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
