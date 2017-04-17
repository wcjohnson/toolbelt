import { expect, assert } from 'chai'
import createBehaviorSubject from '../createBehaviorSubject'
import map from '../map'
import toBehaviorSubject from '../toBehaviorSubject'
import test from '../test'

describe 'lazyMap', ->
	it 'should work', ->
		obs1 = createBehaviorSubject()
		obs1.next(0)
		m = map(obs1, (x) -> console.log("mapping", x); x+1)
		lm = toBehaviorSubject(m)

		sub = test(lm, console.log.bind(console, "sub1"), [
			(x) -> x is 1
			(x) -> x is 2
			'complete'
		])

		sub2 = test(lm, console.log.bind(console, "sub2"), [
			(x) -> x is 1
			(x) -> x is 2
			'complete'
		])

		obs1.next(1)
		obs1.complete()
		sub.unsubscribe()
		sub2.unsubscribe()
