'use strict';

initSelect2 = (inputs, extra = {}) ->
  inputs.each ->
    item = $(this)
    # reading from data allows <input data-select2='{"tags": ['some']}'> to be passed to select2
    options = $.extend(allowClear: true, extra, item.data('select2'))
    # because select2 reads from input.data to check if it is select2 already
    item.data('select2', null)

    if item.hasClass('ajax') # only add ajax functionality if this class is present
      options.ajax =
        url: item.data('source')
        dataType: 'json'
        data: (term, page) ->
          q: term
          page: page
          per: 50
        processResults: (data, page) ->
          results: data.resources
          more: true # adding the more: option enables infinite scrolling (select2 will load more content if available)
        initSelection: (element, callback) ->
          callback({id: item.data('init_id'), text: item.data('init_text')})

      options.dropdownCssClass = "bigdrop"

    item.select2(options)

$(document).on 'has_many_add:after', '.has_many_container', (e, fieldset) ->
  initSelect2(fieldset.find('.select2-input'), width: 'style')

$(document).ready ->
  initSelect2($(".select2-input"), {placeholder: '', width: 'style'})
  return
