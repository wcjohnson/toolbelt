import createSubscription from './createSubscription'
import defineObservable from './defineObservable'
import subscribeObserverAdapter from './subscribeObserverAdapter'

none = {}

defaultArrayProjection = (x) -> x.slice()
defaultObjectProjection = (x) -> Object.assign({}, x)

# Like Rx's combineLatest, supporting any ES7 compatible observable, and also supports key-value
# maps of observables, rather than just arrays.
export default combineLatest = (observables, projection) ->
	# Basic demographics about the observables
	isArray = Array.isArray(observables)
	if isArray
		count = observables.length
	else
		count = 0
		count++ for k of observables

	# Default projections
	if typeof projection isnt 'function'
		projection = if isArray then defaultArrayProjection else defaultObjectProjection

	subscribe = subscribeObserverAdapter (observer) ->
		# Initial value map
		if isArray
			values = (none for observable in observables)
		else
			values = {}
			(values[k] = none) for k of observables
		# Active = # of observables that have not complete()d
		active = count
		# Inactive = # of observables that have not emitted a value
		inactive = count
		# Store upstream subscriptions
		subscriptions = []

		# Unsubscribe from all upstream objects
		unsubscribeAll = ->
			subscription.unsubscribe?() for subscription in subscriptions
			return

		# Error and close the subscription
		error = (err) ->
			if not values? then return
			values = null
			unsubscribeAll()
			observer.error(err)

		# Emit the combined values on the observer.
		emit = ->
			# Project; propagate errors caused by projector
			try result = projection(values) catch err then error(err); return
			observer.next(result)

		# Complete a channel.
		complete = ->
			if not values? then return
			if (--active is 0)
				values = null
				unsubscribeAll()
				observer.complete()

		# Subscribe to one upstream object
		subscribeOne = (index, observable) ->
			subscriptions.push(observable.subscribe({
				next: (x) ->
					if not values? then return
					if values[index] is none then --inactive # array/map OK
					values[index] = x # array/map OK
					if inactive is 0 then emit()

				complete
				error
			}))

		# Subscribe to all observers
		if isArray
			observables.forEach (observable, index) -> subscribeOne(index, observable)
		else
			subscribeOne(k, v) for k,v of observables

		# Create the subscription object.
		sub = createSubscription(observer, unsubscribeAll)
		observer.start?(sub)
		sub

	# Finish the observable object.
	defineObservable({subscribe})
