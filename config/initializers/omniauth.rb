Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_PUBLIC_KEY'], ENV['TWITTER_SECRET_KEY']
end
