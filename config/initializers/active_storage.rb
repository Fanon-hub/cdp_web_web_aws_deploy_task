# ensure AWS SDK is loaded when ActiveStorage service is S3
require 'aws-sdk-s3' if Rails.env.production? || Rails.env.staging?