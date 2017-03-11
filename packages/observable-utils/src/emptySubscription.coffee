# A Subscription object from the ES7 Observables spec, representing no subscription at all.

export default emptySubscription = Object.defineProperty(
	{unsubscribe: ->}
	'closed'
	{
		configurable: true
		enumerable: true
		get: -> true
	}
)
