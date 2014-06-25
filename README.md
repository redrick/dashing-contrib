# dashing-contrib 

[![Build Status](https://travis-ci.org/QubitProducts/dashing-contrib.svg?branch=master)](https://travis-ci.org/QubitProducts/dashing-contrib)


This project is an extension to Shopify's Dashing. It aims to solve a couple of problems:

 * Extend the Dashing's widgets functionality in a healthy pattern
 * Embrace sharing, reusing, testing common jobs data manipulation functionality
 * A common way to load external configuration via dotenv
 * Central place keeping track of extension updates, commits and contributions from multiple sources
 
Read each individual widget documentation to use dashing-contrib built-in widgets in this project after the installation steps.

## Installation
Add this line to your Dashing's dashboard Gemfile:

    gem 'dashing-contrib', '~> 0.0.5'

And then execute:

    $ bundle

Add the following on top of the `config.ru`

    $: << File.expand_path('./lib', __dir__)
    require 'dashing-contrib'
    require 'dashing'
    DashingContrib.configure
    
Add these lines to `assets/javascripts/application.coffee`

    #=require dashing-contrib/assets/widgets

Add these lines to `assets/stylesheets/application.scss`

    //=require dashing-contrib/assets/widgets

## Job Parameters

Shared job parameters are managed by `dotenv` gem. Add a `.env` file in your dashing project root. dashing-contrib will load your configuration from `.env` file automatically. An example `.env` file:

```ruby
NAGIOS_ENDPOINT: http://example.com/nagios3/cgi-bin
NAGIOS_USERNAME: dasher
NAGIOS_PASSWORD: readonly

PINGDOM_USERNAME: ping
PINGDOM_PASSWORD: pong
PINGDOM_API_KEY: pingpongpingpong
```

These values can be accessed in jobs `ENV['NAGIOS_ENDPOINT']`

## Widgets Doc

 * [Rickshawgraph](https://github.com/QubitProducts/dashing-contrib/tree/master/lib/dashing-contrib/assets/widgets/rickshawgraph) made by [jwalton](https://github.com/jwalton)
 * [Sidekiq](https://github.com/QubitProducts/dashing-contrib/tree/master/lib/dashing-contrib/assets/widgets/sidekiq) made by [pallan](https://github.com/pallan)
 * [Pingdom Uptime](https://github.com/QubitProducts/dashing-contrib/tree/master/lib/dashing-contrib/assets/widgets/pingdom_uptime) inspired by [Edools](https://github.com/Edools/dashing-pingdom)
 * [Kue Status](https://github.com/QubitProducts/dashing-contrib/tree/master/lib/dashing-contrib/assets/widgets/kue_status)

## Job Definition

dashing-contrib gem provides a standard job definition wrapper. This replaces the 'SCHEDULE.every' call:

 * defines common data processing and testable/reusable modules
 * in addition to dashing's default 'updatedAt', introduced an optional `state` information used across all widgets
 

A custom job declaration:

```ruby
module MyCustomJob
  # provides some dashing hooks 
  extend DashingContrib::RunnableJob
  
  # Overrides to extract some data for display
  # generated hash will be available for widget to access
  def self.metrics(options)
    { metrics: { failed: 500, ok: 123013 } }
  end
  
  
  # By default this always returns OK state
  # You can customize the state return value by lookup generated metrics and user provided options 
  def self.validate_state(metrics, options = {})
    # `metrics` parameter is the value return by `metrics` method
    failed_value = metrics[:metrics][:failed]
    
    return DashingContrib::RunnableJob::OK if failed_value == 0
    return DashingContrib::RunnableJob::WARNING if failed_value <= 100
    DashingContrib::RunnableJob::CRITICAL
  end
end
```

When using job:

```ruby
# make sure this module is required
# default every 30s and job is executed once at start
MyCustomJob.run(event: 'custom-job-event', every: '20s')


# Custom job also has a block syntax if you are setting up some global settings
MyCustomJob.run(event: 'custom-job-event') do
  # setup redis client etc
end

# metrics and validate_state method will be able to use `my_custom_param` and `custom_threshold`
# to make configurable metrics fetch and state validation
MyCustomJob.run(event: 'custom-job-event', my_custom_param: 123, custom_threshold: 3)
```
    
This is nice that backend data fetching can be now unit tested and reused. Dashing widget view layer can reuse the same job processor and present data in multiple forms. 

## How to contribute

There are a couple of ways to contribute. Brining those widgets scattered in github, in multiple format into this repository. They usually falling into the following categories:

 * Widgets, common widgets should be generic solution to a common requirements. e.g. line graph, better clock with common functionalities. Documentation should be written as a README.md file under widget's own directory, include a preview.png file in the widget folder.
 * Jobs utils, common Job data processing for graphing purpose 
 * Fix and add test
 * Improve documentation



