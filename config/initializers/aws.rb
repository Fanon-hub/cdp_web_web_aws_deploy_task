# ensure the AWS SDK picks up the region/credentials correctly
if Rails.application.credentials.dig(:aws, :access_key_id).present?
  Aws.config.update(
    access_key_id:     Rails.application.credentials.dig(:aws, :access_key_id),
    secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
    region:            Rails.application.credentials.dig(:aws, :region) || 'us-east-1'
  )
elsif ENV['AWS_ACCESS_KEY_ID'].present?
  Aws.config.update(
    region: ENV['AWS_REGION'] || 'us-east-1'
  )
end
