import $$observable from 'symbol-observable'

# Get Symbol.observable on an object (whose value must be a getter function) and return the result of evaluating the getter.
export default getObservableFrom = (obj) ->
	if obj
		getter = obj[$$observable] or obj['@@observable']
		getter?.call(obj)
	else
		null
