VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.ignore_hosts(
    "localhost",
    "127.0.0.1"
  )
end
