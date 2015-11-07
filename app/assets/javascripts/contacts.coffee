$ ->
  $('form').on 'click', '.js-remove-field', (e) ->
    e.preventDefault()
    $(e.currentTarget).parents('.field-with-btn').remove()

  $('.js-add-field').click (e) ->
    e.preventDefault()
    new_field = $(e.currentTarget).parents('.field').find('.js-new-field').clone()
    $(e.currentTarget).before new_field.html()
