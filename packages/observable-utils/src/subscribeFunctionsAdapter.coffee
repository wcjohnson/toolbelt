# Convert a subscription function that takes Functions only, to a subscription function that can take
# either form of subscription as specified by the ES7 standard.
export default subscribeFunctionsAdapter = (subscribe) ->
	(onNextOrObserver, onError, onComplete) ->
		if typeof onNextOrObserver is 'function'
			subscribe(onNextOrObserver, onError, onComplete)
		else
			subscribe(
				onNextOrObserver.next?.bind(onNextOrObserver)
				onNextOrObserver.error?.bind(onNextOrObserver)
				onNextOrObserver.complete?.bind(onNextOrObserver)
			)
