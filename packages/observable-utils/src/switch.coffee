# Switch operator

import defineObservable from './defineObservable'
import subscribeObserverAdapter from './subscribeObserverAdapter'
import createSubscription from './createSubscription'

export default _switch = (priorObservable, opts) ->
	subscribe = subscribeObserverAdapter((observer) ->
		innerSubscription = null
		isStopped = false
		hasCompleted = false

		unsubscribeInner = ->
			if innerSubscription
				innerSubscription.unsubscribe()
				innerSubscription = null

		error = (err) ->
			isStopped = true
			unsubscribeInner()
			observer.error?(err)

		outerSubscription = priorObservable.subscribe({
			next: (innerObservable) ->
				unsubscribeInner()
				innerSubscription = innerObservable.subscribe({
					next: (value) ->
						if not isStopped then observer.next?(value)

					error: error

					complete: ->
						unsubscribeInner()
						if hasCompleted
							isStopped = true
							observer.complete?()
				})
				return

			error: error

			complete: ->
				hasCompleted = true
				if not innerSubscription
					isStopped = true
					observer.complete?()
		})

		createSubscription(observer, ->
			unsubscribeInner()
			outerSubscription.unsubscribe()
		)
	)

	defineObservable({subscribe})
