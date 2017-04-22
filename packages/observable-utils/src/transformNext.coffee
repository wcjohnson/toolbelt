# Replace the `next` method on an observer, preserving other methods intact.
export default transformNext = (observer, nextNext) ->
  nextObserver = {}
  if observer.start then nextObserver.start = (sub) -> observer.start(sub)
  if observer.error then nextObserver.error = (err) -> observer.error(err)
  if observer.complete then nextObserver.complete = -> observer.complete()
  if observer.next then nextObserver.next = nextNext

  nextObserver
