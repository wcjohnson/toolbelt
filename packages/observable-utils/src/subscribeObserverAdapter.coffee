# Convert a subscription function that takes Observers only, to a subscription function that can take
# either form of subscription as specified by the ES7 standard.
export default subscribeObserverAdapter = (subscribe) ->
	(onNextOrObserver, onError, onComplete) ->
		if typeof onNextOrObserver is 'function'
			subscribe({next: onNextOrObserver, error: onError, complete: onComplete})
		else
			subscribe(onNextOrObserver)
