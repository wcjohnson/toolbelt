# Creates a BehaviorSubject that subscribes to a prior observable
# only when it is subscribed to.
import createBehaviorSubject from './createBehaviorSubject'

export default toBehaviorSubject = (priorObservable, f) ->
  subscription = undefined
  observable = createBehaviorSubject({
    onObserverStarted: (observer, observers) ->
      if observers.length is 1
        subscription = priorObservable.subscribe({
          next: (val) ->
            observable.next(val)
          error: (e) ->
            subscription?.unsubscribe()
            subscription = undefined
            observable.error(e)
          complete: ->
            subscription?.unsubscribe()
            subscription = undefined
            observable.complete()
        })
      return

    onObserversChanged: (observers) ->
      if observers.length is 0
        subscription?.unsubscribe()
        subscription = undefined
      return
  })

  observable
