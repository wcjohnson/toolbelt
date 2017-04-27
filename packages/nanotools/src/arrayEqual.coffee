export default arrayEqual = (a, b) ->
	if a is b then return true
	if (not a?) or (not b?) or (not Array.isArray(a)) or (not Array.isArray(b)) then return false
	if a.length isnt b.length then return false
	for i in [0...a.length]
		if a[i] isnt b[i] then return false
	true
