export default makeDeferred = (promiseConstructor) ->
  resolver = undefined
  rejecter = undefined
  promise = new promiseConstructor( (resolve, reject) ->
    resolver = resolve
    rejecter = reject
  )

  { promise, resolve: resolver, reject: rejecter }
