import { expect, assert } from 'chai'
import createBehaviorSubject from '../createBehaviorSubject'
import memoize from '../memoize'
import test from '../test'

describe 'memoize', ->
  it 'should work', ->
    obs1 = createBehaviorSubject()
    obs1.next(0)
    m = memoize(obs1)

    sub = test(m, console.log.bind(console), [
      (x) -> assert.deepEqual(x, [0]); true
      (x) -> assert.deepEqual(x, [1, 0]); true
      (x) -> assert.deepEqual(x, [2, 1]); true
      'complete'
    ])

    obs1.next(1)
    obs1.next(2)
    obs1.complete()
    sub.unsubscribe()
