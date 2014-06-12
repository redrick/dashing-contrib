# dashing-contrib

This projects is an extension to Shopify's Dashing. It aims to solve a couple of problems
 * Extend the Dashing's widgets functionality in a healthy pattern.
 * Embrace sharing, reusing, testing common jobs data manipulation functionality
 * Make it easier to work with History.yml in file and memory
 * A common way to load external configuration via dotenv
 
## Installation
Add this line to your Dashing's dashboard Gemfile:

    gem 'dashing-contrib', '~> 0.0.2'

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

## Included Widgets

 * [Rickshawgraph](https://gist.github.com/jwalton/7916168) made by [jwalton](https://gist.github.com/jwalton)

## Included Job helpers

 TODO:

## Components/Widgets made by contributors

 * [jwalton](https://gist.github.com/jwalton)