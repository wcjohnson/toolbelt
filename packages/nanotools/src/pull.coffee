# Remove the first instance of an element from a list.
export default pull = (list, value) ->
	if list? and ((i = list.indexOf(value)) > -1)
		list.splice(i, 1); return true
	else
		return false
