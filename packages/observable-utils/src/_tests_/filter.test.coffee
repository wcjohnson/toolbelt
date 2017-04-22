import { expect, assert } from 'chai'
import createBehaviorSubject from '../createBehaviorSubject'
import filter from '../filter'
import test from '../test'

describe 'filter', ->
  it 'should work', ->
    obs1 = createBehaviorSubject()
    obs1.next(0)
    m = filter(obs1, (x) -> x > 0)

    sub = test(m, console.log.bind(console), [
      (x) -> x is 1
      (x) -> x is 2
      'complete'
    ])

    obs1.next(1)
    obs1.next(-1)
    obs1.next(0)
    obs1.next(2)
    obs1.next(-50)
    obs1.complete()
    sub.unsubscribe()
