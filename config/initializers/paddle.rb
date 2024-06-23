PaddlePay.configure do |config|

  if Rails.env.production?
    config.environment = :production
    config.vendor_id = ENV['PADDLE_SELLER_ID']
    config.vendor_auth_code = ENV['PADDLE_SANDBOX_API_KEY']
  else
    config.environment = :development # or :sandbox
    config.vendor_id = ENV['PADDLE_SELLER_ID']
    config.vendor_auth_code = ENV['PADDLE_SANDBOX_API_KEY']
  end

end
