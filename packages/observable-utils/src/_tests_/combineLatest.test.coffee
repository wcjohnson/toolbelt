import { expect, assert } from 'chai'
import createSubject from '../createSubject'
import combineLatest from '../combineLatest'
import test from '../test'

describe 'combineLatest', ->
	it 'should work', ->
		obs1 = createSubject()
		obs2 = createSubject()

		array = combineLatest([obs1, obs2])
		map = combineLatest({first: obs1, second: obs2})

		test(array, console.log.bind(console), [
			(x) -> expect(x).to.deep.equal([1,1])
			(x) -> expect(x).to.deep.equal([2,1])
			(x) -> expect(x).to.deep.equal([2,2])
			'complete'
		])

		test(map, console.log.bind(console), [
			(x) -> expect(x).to.deep.equal({first: 1, second: 1})
			(x) -> expect(x).to.deep.equal({first: 2, second: 1})
			(x) -> expect(x).to.deep.equal({first: 2, second: 2})
			'complete'
		])

		obs1.next(1)
		obs2.next(1)
		obs1.next(2)
		obs2.next(2)
		obs1.complete()
		obs2.complete()
