$ ->
  $('form').on 'click', '.js-remove-field', (e) ->
    e.preventDefault()
    $(e.currentTarget).parents('.field-with-btn').remove()

  $('.js-add-field').click (e) ->
    e.preventDefault()
    new_field = $(e.currentTarget).parents('.field').find('.js-new-field').clone()
    new_field.find('input').prop('required', true)
    $(e.currentTarget).before new_field.html()
