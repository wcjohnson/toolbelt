# A version of Redux's combineReducers that doesn't complain about state shape.
export default combineReducers = (reducers, didDropKeys) ->
	finalReducers = {}
	for k, v of reducers
		if typeof(v) isnt 'function'
			throw new Error("Reducer for key `#{k}` must be a function.")
		else
			finalReducers[k] = v

	(state = {}, action) ->
		hasChanged = false
		nextState = {}
		for key, reducer of finalReducers
			previousStateForKey = state[key]
			nextStateForKey = reducer(previousStateForKey, action)
			if typeof(nextStateForKey) is 'undefined'
				throw new Error("Reducer for key `#{key}` returned an undefined state.")
			nextState[key] = nextStateForKey
			hasChanged = hasChanged || ( nextStateForKey isnt previousStateForKey )

		# Detect deletion of components from the reducer map
		if (not hasChanged) and didDropKeys
			for key of state
				if not (key of finalReducers) then hasChanged = true; break

		if hasChanged then nextState else state
