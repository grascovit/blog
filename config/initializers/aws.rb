# frozen_string_literal: true

require 'aws-sdk-s3'

Paperclip::Attachment.default_options.merge!(
  storage: Rails.env.test? ? :filesystem : :s3,
  s3_credentials: {
    bucket: ENV['S3_BUCKET_NAME'],
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    s3_region: ENV['AWS_REGION'],
    s3_host_name: "s3-#{ENV['AWS_REGION']}.amazonaws.com"
  }
)
