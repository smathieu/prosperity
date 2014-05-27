$ ->
  $('.destroy-action').click (e) ->
    e.preventDefault()
    $target = $(e.target)
    $hidden = $target.siblings('input[type="hidden"]')
    $hidden.val('1')
    el = $target.parents(".deletable-nested-attribute")
    el.hide()
