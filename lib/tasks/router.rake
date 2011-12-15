namespace :router do
  task :router_environment do
    Bundler.require :router, :default

    require 'logger'
    @logger = Logger.new STDOUT
    @logger.level = Logger::DEBUG

    @router = Router::Client.new :logger => @logger
  end

  task :register_application => :router_environment do
    platform = ENV['FACTER_govuk_platform']
    url = "fco.#{platform}.alphagov.co.uk/"
    @logger.info "Registering application..."
    @router.applications.update application_id: "fco", backend_url: url
  end

  task :register_routes => [ :router_environment, :environment ] do
    begin
    @logger.info "Registering prefix /travel-advice"
    @router.routes.update application_id: "fco", route_type: :prefix,
     incoming_path: "/travel-advice"

    @logger.info "Registering asset path /fco-assets"
    @router.routes.update application_id: "fco", route_type: :prefix,
      incoming_path: "/fco-assets"
    rescue => e
      @logger.error [ e.message, e.backtrace ].flatten.join("\n")
      raise
    end
  end

  desc "Register fco application and routes with the router (run this task on server in cluster)"
  task :register => [ :register_application, :register_routes ]
end
