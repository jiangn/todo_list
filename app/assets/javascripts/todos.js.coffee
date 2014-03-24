# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@add_todo = () ->
  $.ajax $('a.add_todo').attr('url'),
    type: 'POST'
    data: {'description' : $('input#description').val(), 'is_complete' : $('input#is_complete').is(':checked')}
    success: (data) ->
      $('input#description').val('')
    error: (xhr) ->
      alert(xhr.responseJSON.message)

@mark_complete = (url) ->
  $.ajax url,
    type: 'PUT'

@initTable = () ->
  $('table.todo_table').tableDnD(
      onDragClass: 'dragRow',
      onDrop: (table, row) ->
        rows = $(table).find('tr:not(.nodrag)')
        data = []
        for i in [0 .. rows.length]
          data.push($(rows[i]).attr('data_id'))
        $.ajax $(table).attr('change_order_url'),
          type: 'PUT'
          data: {'todo_order' : data}
  )


$ ->
  initTable()
