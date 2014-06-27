class Dashing.DashingState extends Dashing.Widget

  onData: (data) ->
    items = []
    for key, item of data.detailed_status
      items = items.concat(item)

    @items = items


