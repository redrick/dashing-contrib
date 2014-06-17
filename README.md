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

````
NAGIOS_ENDPOINT: http://example.com/nagios3/cgi-bin
NAGIOS_USERNAME: dasher
NAGIOS_PASSWORD: readonly

PINGDOM_USERNAME: ping
PINGDOM_PASSWORD: pong
PINGDOM_API_KEY: pingpongpingpong
````

These values can be accessed in jobs `ENV['NAGIOS_ENDPOINT']`

## Widgets Doc

 * [Rickshawgraph](https://github.com/QubitProducts/dashing-contrib/tree/master/lib/dashing-contrib/assets/widgets/rickshawgraph) made by [jwalton](https://github.com/jwalton)
 * [Sidekiq](https://github.com/QubitProducts/dashing-contrib/tree/master/lib/dashing-contrib/assets/widgets/sidekiq) made by [pallan](https://github.com/pallan)
 * [Pingdom Uptime](https://github.com/QubitProducts/dashing-contrib/tree/master/lib/dashing-contrib/assets/widgets/pingdom_uptime) inspired by [Edools](https://github.com/Edools/dashing-pingdom)
 * [Kue Status](https://github.com/QubitProducts/dashing-contrib/tree/master/lib/dashing-contrib/assets/widgets/kue_status)

## Job Helpers Doc

 TODO:

## How to contribute

There are a couple of ways to contribute. Brining those widgets scattered in github, in multiple format into this repository. They usually falling into the following categories:

#### Widgets

Common widgets should be generic solution to a common requirements. e.g. line graph, better clock with common functionalities. Documentation should be written as a README.md file under widget's own directory, include a preview.png file in the widget folder.

#### Jobs utils

Common Job data processing for graphing purpose.

#### Fix and add test

Test data processing Ruby modules.

