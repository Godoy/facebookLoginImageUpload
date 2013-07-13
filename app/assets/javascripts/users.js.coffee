# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('.select-image').click (e) ->
		e.preventDefault
		
		$('.select-image').removeClass "selected"
		$(this).addClass "selected"
		
		$('#user_mask_id').val $(this).attr "data-id"

	
	$('.select-image[data-id='+$('#user_mask_id').val()+']').addClass "selected"