# Utility for use with decorators and defineProperty. Makes a getter that computes a value, then
# redefines the property as a static property with the final value.
export default createMemoizingGetter = (target, key, defaultValue, getOnce) ->
	# Prevent reentrancy when redefininig the property.
	reentrancyLock = false

	# Generate the one-time getter which will replace itself when it runs.
	->
		# Don't replace the property if we are iterating the prototype, or if there is an own
		# property alraedy present on the object.
		if reentrancyLock or (this is target.prototype) or (this.hasOwnProperty(key))
			return defaultValue

		# Get the value from the one-time getter and replace it on the object.
		finalValue = getOnce.call(this)
		reentrancyLock = true
		Object.defineProperty(this, key, {
			value: finalValue
			configurable: true
			writable: true
		})
		reentrancyLock = false
		finalValue
