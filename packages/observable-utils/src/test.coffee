# Test an Observable against an array describing expected behaviors.
export default test = (observable, always, expectations) ->
	currentIndex = 0

	subscr = observable.subscribe({
		start: ->
			always?('start')
			currentIndex = 0

		next: (x) ->
			always?('next', x)
			if not expectations[currentIndex++]?(x)
				throw new Error("Expectation[#{currentIndex-1}] failed.")

		complete: ->
			always?('complete')
			if not (expectations[currentIndex] is 'complete')
				throw new Error("Unexpected completion at #{currentIndex}")

		error: (err) ->
			always?('error', err)
			if not (expectations[currentIndex] is 'error')
				throw new Error("Unexpected error at #{currentIndex}")
	})

	nextSubscr = {
		unsubscribe: ->
			if currentIndex < expectations.length then throw new Error("Leftover expectations")
			subscr.unsubscribe()
	}
