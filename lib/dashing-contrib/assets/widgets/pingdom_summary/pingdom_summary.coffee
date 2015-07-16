class Dashing.PingdomSummary extends Dashing.Widget
  @accessor 'up', Dashing.AnimatedValue
  @accessor 'down', Dashing.AnimatedValue
  @accessor 'unconfirmed_down', Dashing.AnimatedValue
  @accessor 'unknown', Dashing.AnimatedValue
  @accessor 'paused', Dashing.AnimatedValue
  @accessor 'arrowClass', ->
    switch @get('status')
      when "ok"       then 'fa fa-smile-o'
      when "critical" then 'fa fa-frown-o'
      else                 'fa fa-meh-o'

  @accessor 'statusClass', ->
    switch @get('status')
      when "ok"       then 'current-status-container status-up'
      when "critical" then 'current-status-container status-down'
      else                 'current-status-container status-unknown'
