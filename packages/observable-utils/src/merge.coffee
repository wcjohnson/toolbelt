import subscribeObserverAdapter from './subscribeObserverAdapter'
import defineObservableSymbol from './defineObservableSymbol'
import createSubscription from './createSubscription'

# Merge multiple observables into one observable.
export default merge = (observables, observableConstructor) ->
  count = observables.length

  subscribe = subscribeObserverAdapter (observer) ->
    active = count
    subscriptions = []

    unsubscribeAll = ->
      subscription.unsubscribe?() for subscription in subscriptions
      return

    error = (err) ->
      if active is 0 then return
      active = 0 # Close on error.
      unsubscribeAll()
      observer.error(err)

    complete = ->
      if active is 0 then return
      if (--active is 0)
        unsubscribeAll()
        observer.complete()

    next = (x) ->
      if active isnt 0 then observer.next(x)

    subscribeOne = (observable) ->
      subscriptions.push(observable.subscribe({ next, complete, error }))

    observables.forEach(subscribeOne)

    if observableConstructor
      # We only need to return a cleanup method if we have an Observable
      # library on hand.
      return unsubscribeAll
    else
      # Otherwise we need to make an actual subscription.
      sub = createSubscription(observer, unsubscribeAll)
      observer.start?(sub)
      sub

  if observableConstructor
    new observableConstructor(subscribe)
  else
    defineObservableSymbol({subscribe})
