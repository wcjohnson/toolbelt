import subscribeObserverAdapter from './subscribeObserverAdapter'
import defineObservable from './defineObservable'

export default map = (priorObservable, f) ->
  subscribe = subscribeObserverAdapter((observer) ->
    priorObservable.subscribe({
      start: (sub) -> observer.start?(sub)
      next: (x) -> observer.next?(f(x))
      error: (err) -> observer.error?(err)
      complete: -> observer.complete?()
    })
  )

  defineObservable({subscribe})
