# A minimalistic version of Rx's BehaviorSubject implemented using closures.
import createSubject from './createSubject'

export default createBehaviorSubject = (opts) ->
	nexted = false
	presentValue = undefined
	if 'initialValue' of opts then presentValue = opts.initialValue

	# Create the subject observable
	observable = createSubject(opts)

	# Replace its `next` with something that caches the value
	subjectNext = observable.next
	if typeof(opts?.onlyWhen) is 'function'
		onlyWhen = opts.onlyWhen
		# Only call when `onlyWhen` returns true
		observable.next = (x) ->
			nexted = true
			if onlyWhen(x, presentValue) then subjectNext.call(this, presentValue = x)
	else
		observable.next = (x) ->
			nexted = true
			subjectNext.call(this, presentValue = x)

	# Replace its `subscribe` with something that pushes the value to each subscriber.
	subjectSubscribe = observable.subscribe
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
