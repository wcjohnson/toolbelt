import { expect, assert } from 'chai'
import createBehaviorSubject from '../createBehaviorSubject'
import map from '../map'
import test from '../test'

describe 'map', ->
	it 'should work', ->
		obs1 = createBehaviorSubject()
		obs1.next(0)
		m = map(obs1, (x) -> x+1)

		sub = test(m, console.log.bind(console), [
			(x) -> x is 1
			(x) -> x is 2
			'complete'
		])

		obs1.next(1)
		obs1.complete()
		sub.unsubscribe()
