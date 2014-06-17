KueStatus Widget
=====

A widget shows current status of [Kue](https://github.com/learnboost/kue) job queue.

## Usage

Add the widget HTML to your dashboard

```html
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
    <div data-id="kue-information" data-view="KueStatus" data-title="Kue information"></div>
</li>
````

## Job

An example of `jobs/kue_status_job.rb`

```ruby
# built-in Kue helpers
require 'dashing-contrib/bottles/kue'

SCHEDULER.every '10s' do
  # Use .env file in your project to extract endpoint value
  # if dev and production enviroment are different
  client = DashingContrib::Kue::Client.new(endpoint: 'http://kue.example.com')
  stats = client.stats

  metrics = [
      { label: 'Processed',  value: stats[:complete_count] },
      { label: 'Processing', value: stats[:active_count] },
      { label: 'Failed',     value: stats[:failed_count] },
      { label: 'Queued',     value: stats[:inactive_count] },
      { label: 'Delayed',     value: stats[:delayed_count] }
  ]
  send_event('kue-information', { metrics: metrics } )
end
````
