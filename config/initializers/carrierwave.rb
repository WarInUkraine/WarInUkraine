CarrierWave.configure do |config|
  config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      ENV['AWS_SECRET_KEY_ID'],
      aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
      region:                 ENV['AWS_REGION'],
      endpoint:               ENV['AWS_ENDPOINT']
  }

  config.fog_directory  = 'warinukraine'
  config.fog_public     = false
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
end