VCR.configure do |config|
  config.hook_into :webmock
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.configure_rspec_metadata!

  config.default_cassette_options = {
    preserve_exact_body_bytes: true,
    decode_compressed_response: true,
    record: :once
  }

  config.before_record do |env|
    env.response.headers.delete('Set-Cookie')
    env.request.headers.delete('Authorization')
  end

  config.around_http_request do |request|
    tape_sha = Digest::SHA1.hexdigest [
      request.method,
      request.uri,
      if request.body.include?("RubyMultipartPost")
        request.headers.except("Authorization", "Content-Type").to_s
      else
        request.headers.except("Authorization").to_s
      end,
      request.body.to_s.gsub(
        /RubyMultipartPost-\w{32}/,
        "RubyMultipartPost-#{'1' * 32}"
      )
    ].join('')
    tape_name = URI(request.uri)
                .path
                .split("/")
                .delete_if(&:empty?)
                .unshift(request.method)
                .join("_")
                .gsub(/\W/, "_")
    VCR.use_cassette("#{tape_name}_#{tape_sha}", &request)
  end
end
