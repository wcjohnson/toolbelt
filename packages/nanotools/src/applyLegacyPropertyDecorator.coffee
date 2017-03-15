# Stub to emulate decorator behavior without decorator syntax.
export default applyLegacyPropertyDecorator = (proto, key, decorator) ->
	descriptor = Object.getOwnPropertyDescriptor(proto, key)

	if (not descriptor) or (not descriptor.configurable)
		throw new Error("applyLegacyDecorator: Prototype missing #{key} or it is not configurable")

	nextDescriptor = decorator(proto, key, descriptor) or descriptor

	Object.defineProperty(proto, key, nextDescriptor)
