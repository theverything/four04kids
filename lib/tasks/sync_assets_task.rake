require 's3'
require 'digest/md5'
require 'mime/types'

AWS_ACCESS_KEY_ID = ENV["U_AWS_ACCESS_KEY_ID"]
AWS_SECRET_ACCESS_KEY = ENV["U_AWS_SECRET_KEY"]
AWS_BUCKET = "404kids"

namespace :embed do
  desc "Deploy all assets in public/**/* to S3/Cloudfront"
  task :deploy, :env, :branch do |t, args|
    puts "== Uploading assets to S3"

    service = S3::Service.new(
      :access_key_id => AWS_ACCESS_KEY_ID,
      :secret_access_key => AWS_SECRET_ACCESS_KEY)
    bucket = service.buckets.find(AWS_BUCKET)

    STDOUT.sync = true

    Dir.glob("embed/**/*").each do |file|

      if File.file?(file)

        remote_file = file.gsub("embed/", "")
        begin
          obj = bucket.objects.find_first(remote_file)
        rescue
          obj = nil
        end

        if !obj || (obj.etag != Digest::MD5.hexdigest(File.read(file)))
            print "+"
            obj = bucket.objects.build(remote_file)
            obj.content = open(file)
            obj.content_type = MIME::Types.type_for(file).to_s
            obj.save
        else
          print "."
        end
      end
    end
    STDOUT.sync = false # Done with progress output.

    puts
    puts "== Done syncing assets"
  end
end