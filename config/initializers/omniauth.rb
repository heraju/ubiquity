OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['573585586030691'], ENV['418557e4cf3484c47aea2e27d3a07830']
end