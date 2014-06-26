class Dashing.DashingState extends Dashing.Widget
  @accessor 'items', ->
    items = []
    for key, item of @detailed_status
      items = items.concat(item)

    return items




