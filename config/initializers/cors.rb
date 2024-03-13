if Rails.env.testing? || Rails.env.development?
  require 'rack/cors'
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :any
    end
  end
end
