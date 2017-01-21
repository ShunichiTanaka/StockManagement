$ ->
    $('#check_all_box').click ->
      if $(this).prop 'checked'
        $('.checked_item').prop 'checked', true
      else
        $('.checked_item').prop 'checked', false
