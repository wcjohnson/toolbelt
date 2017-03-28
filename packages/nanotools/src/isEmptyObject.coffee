export default isEmptyObject = (obj) ->
  for k of obj
    if obj.hasOwnProperty(k) then return false
  true
