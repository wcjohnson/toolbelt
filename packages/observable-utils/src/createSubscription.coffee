# Create a Subscription object compliant with the observable spec.

export default createSubscription = (observer, unsubscriber) ->
	subscription = {
		unsubscribe: ->
			if observer then observer = undefined; unsubscriber()
	}

	Object.defineProperty(subscription, 'closed', {
		configurable: true
		enumerable: true
		get: -> not observer?
	})
