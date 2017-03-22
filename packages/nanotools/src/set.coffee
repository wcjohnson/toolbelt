# Set a value at a deep location in an object.
export default set = (object, path, val) ->
	index = 0; length = path.length
	while object? and index < (length - 1)
		object = object[path[index++]]
	if object and (index is length - 1)
		object[path[index]] = val
		true
	else
		false
