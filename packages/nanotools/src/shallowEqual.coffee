export default shallowEqual = (objA, objB) ->
  if objA is objB then return true

  if (typeof objA isnt 'object') or (objA is null) or (typeof objB isnt 'object') or (objB is null)
    return false

  keysA = Object.keys(objA)
  keysB = Object.keys(objB)

  if keysA.length isnt keysB.length then return false

  bHasOwnProperty = Object.prototype.hasOwnProperty.bind(objB)
  for key in keysA
    if (not bHasOwnProperty(key)) or (objA[key] isnt objB[key]) then return false

  true
