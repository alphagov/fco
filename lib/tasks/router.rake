namespace :router do
  task :router_environment do
    Bundler.require :router, :default

    require 'logger'
    @logger = Logger.new STDOUT
    @logger.level = Logger::DEBUG

    http = Router::HttpClient.new "http://cache.cluster:8080/router", @logger

    @router = Router::Client.new http
  end

  task :register_application => :router_environment do
    platform = ENV['FACTER_govuk_platform']
    url = "fco.#{platform}.alphagov.co.uk/"
    begin
      @logger.info "Registering application..."
      @router.applications.create application_id: "fco", backend_url: url
    rescue Router::Conflict
      application = @router.applications.find "fco"
      puts "Application already registered: #{application.inspect}"
    end
  end

  task :register_routes => [ :router_environment, :environment ] do
    begin
      @logger.info "Registering prefix /travel-advice"
      @router.routes.create application_id: "fco", route_type: :prefix,
        incoming_path: "/travel-advice"
    rescue => e
      puts [ e.message, e.backtrace ].join("\n")
    end

    begin
      @logger.info "Registering asset path /fco-assets"
      @router.routes.create application_id: "fco", route_type: :prefix,
        incoming_path: "/fco-assets"
    rescue => e
      puts [ e.message, e.backtrace ].join("\n")
    end
  end

  desc "Register fco application and routes with the router (run this task on server in cluster)"
  task :register => [ :register_application, :register_routes ]
end
