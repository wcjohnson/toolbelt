# observable-utils

A collection of lightweight, bundle-friendly, cherry-pickable utilities for manipulating ES7/TC39 `Observable`s, `Observer`s, and `Subscription`s. All `Observable`s produced meet the spec and all functions that take an `Observable` will take any `Observable` that meets the spec.

## combineLatest

```coffeescript
combineLatest: (arrayOrMapOfObservables, projectionFunction) -> observableArrayOrMap
```

Like rxjs's `combineLatest`, but supports either arrays or `Object`s as first parameters. If given an object, will create an observable object combining the latest values of the input object's keys.

## createSubject

## createBehaviorSubject

## createSubscription

## defineObservableSymbol

## emptySubscription

## subscribeFunctionsAdapter

## subscribeObserverAdapter

## test

Helper to assist in writing unit tests for `Observable`s.
