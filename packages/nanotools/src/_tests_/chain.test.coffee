import { expect, assert } from 'chai'
import chain from '../chain'

describe 'chain', ->
	it 'should work right', ->
		empty = []
		func = chain(
			-> empty.push(1)
			-> empty.push(2)
		)
		func()
		expect(empty).to.deep.equal([1,2])
