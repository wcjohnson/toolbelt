# A minimalistic version of BehaviorSubject implemented using closures.

import createSubject from './createSubject'
import chain from 'micro-utils/lib/chain'

export default createBehaviorSubject = (opts) ->
	presentValue = null

	# Create the subject and replace its next handler with something that caches the value
	# and its subscribe handler with something that pushes the value to each subscriber.
	observable = createSubject()
	subjectNext = observable.next
	subjectSubscribe = observable.subscribe
	observable.next = (x) -> subjectNext(presentValue = x)
	observable.subscribe = (x) ->
		sub = subjectSubscribe(x)
		if not sub.closed then x.next?(presentValue)
		sub

	# Add getter for current value
	observable.getValue = -> presentValue

	observable
