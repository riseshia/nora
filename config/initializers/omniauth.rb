require 'omniauth-github'

Nora::Engine.config.middleware.use OmniAuth::Builder do
  options = { scope: 'repo,write:repo_hook' }
  host = ENV['GITHUB_HOST']
  if host.present?
    options.merge!(
      client_options: {
        site: "#{host}/api/v3",
        authorize_url: "#{host}/login/oauth/authorize",
        token_url: "#{host}/login/oauth/access_token",
      }
    )
  end
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], options
end
