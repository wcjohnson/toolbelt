# Check if a value is primitive.
export default isPrimitive = (v) ->
	t = typeof(v)
	if (t is 'string') or (t is 'number') or (t is 'boolean') then true else false
