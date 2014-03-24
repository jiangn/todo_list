# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@login = () ->
  $.ajax $('#login_form').attr('action'),
    type: 'POST'
    data: $('#login_form').serialize()
    success: (data) ->
      window.location.href = data.url
    error: (xhr) ->
      alert xhr.responseJSON.message

@logout = (user_id) ->
  $.ajax '/users/' + user_id,
    type: 'DELETE'
    success: (data) ->
      window.location.href = data.url
    error: (xhr) ->
      alert xhr.responseJSON.message