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
end
