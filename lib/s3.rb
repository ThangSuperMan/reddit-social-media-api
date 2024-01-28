module S3
  def s3_upload(file)
    s3_bucket = Aws::S3::Resource.new.bucket(ENV['AWS_S3_BUCKET'])

    upload_file(s3_bucket, file)
  end

  def upload_file(s3_bucket, file)
    file_name = generate_file_name(file)
    object = s3_bucket.object(file_name)
    file_temp_location_path = file.tempfile.path
    object.upload_file(file_temp_location_path)
    file_name
  end

  def generate_file_name(file)
    random_name = SecureRandom.hex(8)
    original_file_extension = File.extname(file.original_filename)
    "#{random_name}#{original_file_extension}"
  end
end
