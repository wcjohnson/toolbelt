# A minimalistic version of rxjs's Subject, conforming to the ES Observables spec and implemented using
# closures.
#
# Supports an optional onObserversChanged(observers, observerAdded, observerRemoved) method, to be
# called when the observer list changes.
import pull from 'nanotools/lib/pull'
import emptySubscription from './emptySubscription'
import defineObservable from './defineObservable'
import subscribeObserverAdapter from './subscribeObserverAdapter'
import createSubscription from './createSubscription'

export default createSubject = (opts) ->
	onObserversChanged = opts?.onObserversChanged
	onObserverStarted = opts?.onObserverStarted

	observers = []
	hasError = false
	thrownError = null
	isStopped = false

	next = (x) ->
		if (not isStopped)
			observer.next?(x) for observer in observers.slice()
		return

	error = (x) ->
		if not isStopped
			hasError = true; thrownError = x; isStopped = true
			observer.error?(x) for observer in observers.slice()
		return

	complete = ->
		if not isStopped
			isStopped = true
			observer.complete?() for observer in observers.slice()
		return

	subscribe = subscribeObserverAdapter (observer) ->
		if hasError
			observer.start?(emptySubscription)
			observer.error?(thrownError)
			return emptySubscription
		else if isStopped
			observer.start?(emptySubscription)
			observer.complete?()
			return emptySubscription
		else
			observers.push(observer)
			onObserversChanged?(observers, observer, null)
			# Subscription object
			sub = createSubscription(observer, ->
				if pull(observers, observer) then onObserversChanged?(observers, null, observer)
				return
			)
			observer.start?(sub)
			# start may have removed the observer.
			if observer in observers then onObserverStarted?(observer, observers)
			sub

	defineObservable({ next, error, complete, subscribe })
