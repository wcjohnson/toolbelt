import $$observable from 'symbol-observable'

returnThis = -> @

# Define Symbol.observable on an object (whose value must be a getter function) and return it.
export default defineObservableSymbol = (obj, observableGetter) ->
	if typeof observableGetter isnt 'function' then observableGetter = returnThis
	
	Object.defineProperty(obj, $$observable, { value: observableGetter, writable: true, configurable: true, enumerable: true })
