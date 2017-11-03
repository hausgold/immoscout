# frozen_string_literal: true

require_relative 'base'

module Immoscout
  module Models
    class Model < Base
      def self.url_identifier
        raise NotImplmentedError
      end

      def self.unpack_collection
        raise NotImplmentedError
      end

      def self.identifies?
        raise NotImplmentedError
      end

      def self.unpack(hash)
        raise ArgumentError unless identifies?(hash)
        hash.count == 1 ? hash.values.first : hash
      end

      def initialize(hash = {})
        klass = self.class
        if klass.identifies?(hash)
          super(klass.unpack(hash))
        else
          super
        end
      end

      def as_json
        {
          self.class.json_wrapper => super
        }
      end

      def self.find(id, user_id = :me)
        response = Immoscout::Api::Client.instance.get(
          "user/#{user_id}/#{url_identifier}/#{id}"
        )
        handle_response(response)
        new(response.body)
      end

      def self.all(user_id = :me)
        response = Immoscout::Api::Client.instance.get(
          "user/#{user_id}/#{url_identifier}"
        )
        handle_response(response)
        objects = unpack_collection(response.body)
        # objects.select! { |json| identifies?(json) } if is_a?(
        #   Immoscout::Models::Residential
        # )
        objects.map { |object| new(object) }
      end

      def self.first(user_id = :me)
        all(user_id).first
      end

      def self.last(user_id = :me)
        all(user_id).last
      end

      def save(user_id = :me)
        klass = self.class
        url_identifier = klass.url_identifier
        response = \
          if try(:id)
            Immoscout::Api::Client.instance.put(
              "user/#{user_id}/#{url_identifier}/#{id}",
              as_json
            )
          else
            Immoscout::Api::Client.instance.post(
              "user/#{user_id}/#{url_identifier}",
              as_json
            )
          end

        klass.handle_response(response)
        self
      end

      def update(hash, user_id = :me)
        save(user_id)
        self
      end

      def self.create(hash, user_id = :me)
        instance = new(hash)
        instance.save(user_id)
        instance
      end

      def destroy(user_id = :me)
        klass = self.class
        response = Immoscout::Api::Client.instance.delete(
          "user/#{user_id}/#{klass.url_identifier}/#{id}"
        )
        klass.handle_response(response)
        self
      end

      def self.handle_response(response)
        return response if response.success?
        raise Immoscout::Errors::NotFound, response.body
      end
    end
  end
end
