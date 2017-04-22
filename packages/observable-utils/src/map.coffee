import subscribeObserverAdapter from './subscribeObserverAdapter'
import defineObservable from './defineObservable'
import transformNext from './transformNext'

export default map = (priorObservable, f) ->
  subscribe = subscribeObserverAdapter((observer) ->
    priorObservable.subscribe(
      transformNext(observer, (x) -> observer.next(f(x)))
    )
  )

  defineObservable({subscribe})
