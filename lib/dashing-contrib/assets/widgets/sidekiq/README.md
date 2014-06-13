Sidekiq Widget
===============

Sidekiq widget and documentation is intially developed by [pallan](https://github.com/pallan)

## Usage

Add the widget HTML to your dashboard
```
    <li data-row="2" data-col="4" data-sizex="2" data-sizey="2">
      <div data-id="sidekiq" data-view="Sidekiq" data-title="Sidekiq" style=""></div>
    </li>
```

## Settings

In `/jobs/sidekiq.rb` you need to configure the connection to your Redis server that backs Sidekiq.

````

require 'sidekiq/api'

# redis_uri = "redis://:#{YOUR_REDIS_PASSWORD}@#{YOUR_REDIS_HOST}:#{YOUR_REDIS_PORT}"

Sidekiq.configure_client do |config|
  config.redis = { url: redis_uri, namespace: 'myapp:namespace' }
end

SCHEDULER.every '10s' do
  stats = Sidekiq::Stats.new
  metrics = [
      {label: 'Processed', value: stats.processed },
      {label: 'Failed', value: stats.failed },
      {label: 'Retries', value: stats.retry_size },
      {label: 'Dead', value: stats.dead_size },
      {label: 'Enqueued', value: stats.enqueued }
  ]
  send_event('sidekiq', { metrics: metrics } )
end
````
