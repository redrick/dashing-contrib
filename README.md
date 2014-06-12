# dashing-contrib

This projects is an extension to Shopify's Dashing. It aims to solve a couple of problems:

 * Extend the Dashing's widgets functionality in a healthy pattern
 * Embrace sharing, reusing, testing common jobs data manipulation functionality
 * A common way to load external configuration via dotenv
 * Central place keeping track of extension updates, commits and contributions from multiple sources
 
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

## How to contribute

There are a couple of ways to contribute. Brining those widgets scattered in github, in multiple format into this repository. They usually falling into the following two categories:

### Widgets

Common widgets should be generic solution to a common requirements. e.g. line graph,better clock with common functionalities. Documentation should be written as a readme file under widget's own directory.

### Jobs utils

Common Job data processing for graphing purpose.


## Components/Widgets made by contributors

 * [jwalton](https://gist.github.com/jwalton)