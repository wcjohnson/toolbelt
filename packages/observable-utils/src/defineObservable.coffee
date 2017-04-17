import { getObservableConstructor } from './observableConstructor'
import defineObservableSymbol from './defineObservableSymbol'

export default defineObservable = (opts) ->
  constr = getObservableConstructor()
  if constr
    originalSubscriber = opts.subscribe
    subscriber = (observer) ->
      subscription = originalSubscriber(observer)
      -> subscription.unsubscribe()

    observable = new constr(subscriber)
    for own k,v of opts when k isnt 'subscribe'
      observable[k] = v
    observable
  else
    defineObservableSymbol(opts)
