module Nora
  class Engine < ::Rails::Engine
    isolate_namespace Nora

    initializer 'nora.config' do
      Nora::Engine.routes.default_url_options = {
        protocol: 'https',
        host: ENV.fetch('APP_HOST', 'example.com')
      }
    end
  end
end
