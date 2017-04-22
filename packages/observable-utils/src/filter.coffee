import subscribeObserverAdapter from './subscribeObserverAdapter'
import defineObservable from './defineObservable'
import transformNext from './transformNext'

export default filter = (priorObservable, f) ->
  subscribe = subscribeObserverAdapter((observer) ->
    priorObservable.subscribe(
      transformNext(observer, (x) -> if f(x) then observer.next(x))
    )
  )

  defineObservable({subscribe})
