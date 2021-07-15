# frozen_string_literal: true

VCR.configure do |config|
  config.hook_into :webmock
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.configure_rspec_metadata!

  config.default_cassette_options = {
    preserve_exact_body_bytes: true,
    decode_compressed_response: true,
    record: :once
  }

  IGNORE_REQ_HEADERS = %w[Authorization User-Agent].freeze
  IGNORE_RES_HEADERS = %w[Set-Cookie].freeze

  config.before_record do |env|
    IGNORE_REQ_HEADERS.each { |header| env.request.headers.delete(header) }
    IGNORE_RES_HEADERS.each { |header| env.response.headers.delete(header) }
  end

  config.around_http_request do |request|
    tape_sha = Digest::SHA1.hexdigest [
      request.method,
      request.uri,
      if request.body.include?('RubyMultipartPost')
        request.headers.except('Content-Type', *IGNORE_REQ_HEADERS).to_s
      else
        request.headers.except(*IGNORE_REQ_HEADERS).to_s
      end,
      request.body.to_s.gsub(
        /RubyMultipartPost-\w{32}/,
        "RubyMultipartPost-#{'1' * 32}"
      )
    ].join('')

    tape_name = URI(request.uri)
                .path
                .split('/')
                .delete_if(&:empty?)
                .unshift(request.method)
                .join('_')
                .gsub(/\W/, '_')
    VCR.use_cassette("#{tape_name}_#{tape_sha}", &request)
  end
end
