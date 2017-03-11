import { expect, assert } from 'chai'
import createSubject from '../createSubject'
import test from '../test'

describe 'createSubject', ->
	it 'should work', ->
		subj = createSubject()

		test(subj, console.log.bind(console), [
			(x) -> x is 1
			(x) -> x is 2
			(x) -> x is 3
			'complete'
			'failure'
		])

		subj.next(1); subj.next(2); subj.next(3); subj.complete()
