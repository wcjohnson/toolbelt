# Reducers of the kind used by Redux are not permitted to return undefined. This is the
# identity function, except it promotes undefined to null.
export default identityReducer = (x) -> if x is undefined then null else x
