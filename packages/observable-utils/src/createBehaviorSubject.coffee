# A minimalistic version of Rx's BehaviorSubject implemented using closures.
import createSubject from './createSubject'

export default createBehaviorSubject = (opts) ->
	nexted = false
	presentValue = undefined

	# Create the subject and replace its next handler with something that caches the value
	# and its subscribe handler with something that pushes the value to each subscriber.
	observable = createSubject(opts)
	subjectNext = observable.next
	subjectSubscribe = observable.subscribe
	observable.next = (x) ->
		nexted = true
		subjectNext.call(this, presentValue = x)
	observable.subscribe = (observer) ->
		# Bugfix: subjectSubscribe can trigger a next as a side effect. In that case, we
		# don't want to trigger another. Mark here...
		nexted = false
		sub = subjectSubscribe.call(this, observer)
		# ...and elide double next if it was called.
		if (not sub.closed) and (not nexted) then observer.next?(presentValue)
		sub

	# Add getter for current value
	observable.getValue = -> presentValue

	observable
