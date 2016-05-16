jQuery ->
	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
	payment.setupForm()

payment =
	setupForm: ->
		$('#new_order').submit ->
			$('input[type=submit]').attr('disable',true)
			Stripe.card.createToken($('#new_order'), payment.handleStripeResponse)
			false
	handleStripeRespone: (status, respone) ->
		if status == 200
			$('#new_order').append($('<input type="hidden" name="stripeToken" />').val(response.id))
			$('#new_order')[0].submit()
		else
			$('#stripe_error').text(response.error.message).show()
			$('input[type=submit]').attr('disable',false)