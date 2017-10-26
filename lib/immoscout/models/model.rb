# frozen_string_literal: true

require_relative 'base'

module Immoscout
  module Models
    class Model < Base
      attr_reader :type_identifier

      def self.json_root_matcher
        raise NotImplmentedError
      end

      def self.url_identifier
        raise NotImplmentedError
      end

      def self.unpack_collection
        raise NotImplmentedError
      end

      def initialize(hash = nil)
        klass = self.class
        if hash && hash.count == 1 && hash.keys.first =~ klass.json_root_matcher
          @type_identifier = hash.keys.first
          super(hash.values.first)
        else
          @type_identifier = klass.name.demodulize.camelize(:lower)
          super
        end
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
        objects = unpack_collection.call(response.body)
        objects.map { |object| new(object) }
      end

      def save(user_id = :me)
        klass = self.class
        response = Immoscout::Api::Client.instance.put(
          "user/#{user_id}/#{klass.url_identifier}/#{id}",
          as_json
        )

        klass.handle_response(response)
        update_attributes!(response.body)
      end

      def update(hash, user_id = :me)
        # TODO: implement me
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
