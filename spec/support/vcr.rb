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

  ignore_req_headers = %w[Authorization User-Agent].freeze
  ignore_res_headers = %w[Set-Cookie].freeze

  config.before_record do |env|
    ignore_req_headers.each { |header| env.request.headers.delete(header) }
    ignore_res_headers.each { |header| env.response.headers.delete(header) }
  end

  config.around_http_request do |request|
    headers =
      if request.body.include?('RubyMultipartPost')
        request.headers.except('Content-Type', *ignore_req_headers)
      else
        request.headers.except(*ignore_req_headers)
      end
    headers = headers.map { |key, val| %("#{key}"=>#{val}) }.join(', ')
    headers = "{#{headers}}"

    tape_sha = Digest::SHA1.hexdigest [
      request.method,
      request.uri,
      headers,
      request.body.to_s.gsub(
        /RubyMultipartPost-\w{32}/,
        "RubyMultipartPost-#{'1' * 32}"
      )
    ].join

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
