# Climb the prototype chain, calling a function on each entry, until reaching Object or null.
export default iteratePrototypeChain = (obj, func) ->
	proto = Object.getPrototypeOf(obj)
	while (proto isnt null) and (proto.constructor isnt Object)
		func(proto, obj)
		proto = Object.getPrototypeOf(proto)
	return
