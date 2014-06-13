Sidekiq Widget
===============

Sidekiq widget and documentation is intially developed by [pallan](https://github.com/pallan)

## Preview

Simple [Dashing](http://shopify.github.com/dashing) widget to display the
current stats for [Sidekiq](http://sidekiq.org/).

![](https://gist.githubusercontent.com/pallan/57f778cace40fd56fb4d/raw/sidekiq_preview.png)

## Dependencies

Sidekiq version 3.0 or greater is required. Add to dashing's gemfile:

```
gem 'sidekiq', '~>3.0'
```

and run `bundle install`.

## Usage

To use this widget, copy `sidekiq.html`, `sidekiq.coffee`, and
`sidekiq.scss` into the `/widgets/sidekiq` directory. Put the
`sidekiq.rb` file in your `/jobs` folder. Copy `sidekiq_log.png` into
the `/assets/images` directory.

Add the widget HTML to your dashboard
```
    <li data-row="2" data-col="4" data-sizex="2" data-sizey="2">
      <div data-id="sidekiq" data-view="Sidekiq" data-title="Sidekiq" style=""></div>
    </li>
```

## Settings

In `/jobs/sidekiq.rb` you need to configure the connection to your Redis
server that backs Sidekiq.
