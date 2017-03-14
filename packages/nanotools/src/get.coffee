# Given an object or array, and an array of indices, get the value obtained by traversing the object
# graph by repeated indexing along the path given by the array of indices.
export default get = (object, path) ->
	index = 0; length = path.length
	while object? and index < length
		object = object[path[index++]]
	if (index is length) then object else undefined
