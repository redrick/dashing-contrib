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
    #if (@get('status') == "ok") then 'fa fa-smile-o' else if (@get('status') == "warning") then 'fa fa-meh-o' else 'fa fa-frown-o'

  @accessor 'siteState', ->
    console.log("siteState called")
    console.log(item)
    if (@get('status') == "ok") then 'fa fa-smile-o' else if (@get('status') == "warning") then 'fa fa-meh-o' else 'fa fa-frown-o'

  @accessor 'statusClass', ->
    switch @get('status')
      when "ok"       then 'current-status-container status-up'
      when "critical" then 'current-status-container status-down'
      else                 'current-status-container status-unknown'
      
#    if (@get('status') == "ok") then 'current-status-container status-up' else if (@get('status') == "warning") then 'current-status-container status-meh' else 'current-status-container status-down'
