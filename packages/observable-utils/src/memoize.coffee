import subscribeObserverAdapter from './subscribeObserverAdapter'
import defineObservable from './defineObservable'
import transformNext from './transformNext'

export default memoize = (priorObservable, n = 1) ->
  subscribe = subscribeObserverAdapter((observer) ->
    memory = []
    priorObservable.subscribe(
      transformNext(observer, (x) ->
        memory.unshift(x)
        observer.next(memory)
        if memory.length > n then memory.pop()
      )
    )
  )

  defineObservable({subscribe})
