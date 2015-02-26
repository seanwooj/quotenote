# https://gist.github.com/t-anjan/9671291

Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_credentials] = {
  :bucket => "quotenote-#{Rails.env}",
  :access_key_id => DREAMOBJECT_API_KEY,
  :secret_access_key => DREAMOBJECT_SECRET_KEY
}

Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = 'objects.dreamhost.com'
Paperclip::Attachment.default_options[:s3_protocol] = 'http'
