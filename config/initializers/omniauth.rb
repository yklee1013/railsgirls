Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :identity, fields: [:name, :email], on_failed_registration: UsersController.action(:new)
end
