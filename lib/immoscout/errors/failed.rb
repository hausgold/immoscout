# frozen_string_literal: true

module Immoscout
  module Errors
    class Failed < StandardError
      def initialize(response)
        @status = response.status
        @body   = response.body
        super(["HTTP #{@status}", @body])
      end
    end
  end
end
