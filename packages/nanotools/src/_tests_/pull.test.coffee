import { expect, assert } from 'chai'
import pull from '../pull'

describe 'pull', ->
	it 'should return true and remove', ->
		list = [1, 'two', 3]
		assert(pull(list, 'two'))
		expect(list).to.deep.equal([1,3])

	it 'should return false and preserve', ->
		list = [1, 'two', 3]
		assert(not pull(list, 'four'))
		expect(list).to.deep.equal([1, 'two', 3])
