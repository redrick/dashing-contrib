# Switcher widget written by Juha Mustonen / SC5

# Switches (reloads to another address) the dashboards in periodic manner
# <div id="container" data-switcher-interval="10000" data-switcher-dashboards="dashboard1 dashboard2">
#   <%= yield %>
# </div>
#
class DashboardSwitcher
  constructor: () ->
    @dashboardNames = []
    # Collect the dashboard names from attribute, if provided (otherwise skip switching)
    names = $('[data-switcher-dashboards]').first().attr('data-switcher-dashboards') || ''
    if names.length > 1
      # Get names separated with comma or space
      @dashboardNames = (name.trim() for name in names.split(/[ ,]+/).filter(Boolean))

  start: (interval=60000) ->
    interval = parseInt(interval, 10)
    self = @
    @maxPos = @dashboardNames.length - 1

    # Skip switching if no names defined
    if @dashboardNames.length == 0
      return

    # Take the dashboard name from that last part of the path
    pathParts = window.location.pathname.split('/')
    @curName = pathParts[pathParts.length - 1]
    @curPos = @dashboardNames.indexOf(@curName)

    # instantiate switcher controls for countdown and manual switching
    @switcherControls = new SwitcherControls(interval, @dashboardNames, @curName)
    @switcherControls.start() if @switcherControls.present()

    # If not found, default to first
    if @curPos == -1
      @curPos = 0
      @curName = @dashboardNames[@curPos]

    # Start loop
    @handle = setTimeout(() ->
      # Increase the position or reset back to zero
      self.curPos += 1
      if self.curPos > self.maxPos
        self.curPos = 0

      # Switch to new dashboard
      self.curName = self.dashboardNames[self.curPos]
      window.location.pathname = "/#{self.curName}"

    , interval)


# Switches (hides and shows) elements within on list item
# <li switcher-interval="3000">
#   <div widget-1></div>
#   <div widget-2></div>
#   <div widget-3></div>
# </li>
#
# Supports optional switcher interval, defaults to 5sec
class WidgetSwitcher
  constructor: (@elements) ->
    @$elements = $(elements)
    @incrementTime = 1000 # refresh every 1000 milliseconds

  start: (interval=5000) ->
    self = @
    @maxPos = @$elements.length - 1;
    @curPos = 0

    # Show only first at start
    self.$elements.slice(1).hide()

    # Start loop
    @handle = setInterval(()->
      # Hide all at first - then show the current and ensure it uses table-cell display type
      self.$elements.hide()
      $(self.$elements[self.curPos]).show().css('display', 'table-cell')

      # Increase the position or reset back to zero
      self.curPos += 1
      if self.curPos > self.maxPos
        self.curPos = 0

    , parseInt(interval, 10))

  stop: () ->
    clearInterval(@handle)

# Adds a countdown timer to show when next dashboard will appear
# TODO:
#   - show the name of the next dashboard
#   - add controls for manually cycling through dashboards
class SwitcherControls
  constructor: (interval=60000, dashboardNames, currentDashboardName) ->
    @currentTime = parseInt(interval, 10)
    @interval = parseInt(interval, 10)
    @$elements = $('#switcher-controls')
    @currentDashboardName = currentDashboardName
    @dashboardNames = dashboardNames

  present: () ->
    @$elements.length

  start: () ->
    @addElements()
    @$timer = $.timer(@updateTimer, @incrementTime, true)

  addElements: () ->
    @$countdown = $("<span id='countdown'>00:00</span>")
    @$elements.append(@countdown)

  formatTime: (time) ->
    time = time / 10;
    min = parseInt(time / 6000, 10),
    sec = parseInt(time / 100, 10) - (min * 60)
    "#{(if min > 0 then pad(min, 2) else "00")}:#{pad(sec, 2)}"

  pad: -> (number, length) {
    str = "#{number}"
    while str.length < length
      str = "0#{str}"
    str

  resetCountdown: () ->
    # Get time from form
    newTime = @interval
    if newTime > 0
      @currentTime = newTime

    # Stop and reset timer
    @$timer.stop().once()

  updateTimer: () ->
    # Output timer position
    timeString = formatTime(currentTime)
    @$countdown.html(timeString)

    # If timer is complete, trigger alert
    if @currentTime is 0
      @$timer.stop()
      @resetCountdown()
      return

    # Increment timer position
    @currentTime -= @incrementTime
    if (@currentTime < 0) @currentTime = 0

# Dashboard loaded and ready
Dashing.on 'ready', ->
  # If multiple widgets per list item, switch them periodically
  $('.gridster li').each (index, listItem) ->
    $listItem = $(listItem)
    # Take the element(s) right under the li
    $widgets = $listItem.children('div')
    if $widgets.length > 1
      switcher = new WidgetSwitcher $widgets
      switcher.start($listItem.attr('data-switcher-interval') or 5000)

  # If multiple dashboards defined (using data-swticher-dashboards="board1 board2")
  $container = $('#container')
  ditcher = new DashboardSwitcher()
  ditcher.start($container.attr('data-switcher-interval') or 60000)

