# Return a function that executes f, then g.
export default chain = (f, g) ->
	if typeof f isnt 'function'
		g
	else if typeof g isnt 'function'
		f
	else
		-> f.apply(@, arguments); g.apply(@, arguments)
