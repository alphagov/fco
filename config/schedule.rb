set :output, {:error => 'log/cron.error.log', :standard => 'log/cron.log'}

every 15.minutes do
  rake "api:import"
end
