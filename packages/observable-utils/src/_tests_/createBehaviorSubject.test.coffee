import { expect, assert } from 'chai'
import createBehaviorSubject from '../createBehaviorSubject'
import test from '../test'

describe 'createBehaviorSubject', ->
	it 'should work', ->
		subj = createBehaviorSubject()

		subj.next(1)

		test(subj, console.log.bind(console), [
			(x) -> x is 1
			(x) -> x is 2
			(x) -> x is 3
			'complete'
			'failure'
		])

		subj.next(2); subj.next(3); subj.complete()
