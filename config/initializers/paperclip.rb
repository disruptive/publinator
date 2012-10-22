Paperclip::Attachment.default_options.merge!(
  :storage        => :s3,
  :path           => ":attachment/#{Rails.env}/:id/:style.:extension")

