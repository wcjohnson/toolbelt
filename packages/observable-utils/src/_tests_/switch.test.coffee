import { expect, assert } from 'chai'
import createSubject from '../createSubject'
import createBehaviorSubject from '../createBehaviorSubject'
import oswitch from '../switch'
import test from '../test'

describe 'switch', ->
	it 'should work', ->
		subj1 = createSubject()
		subj2 = createSubject()
		subj3 = createSubject()
		outer = createSubject()

		switched = oswitch(outer)

		test(switched, console.log.bind(console), [
			(x) -> x is 1
			(x) -> x is 2
			(x) -> x is 3
			'complete'
			'failure'
		])

		outer.next(subj1)
		subj1.next(1)
		outer.next(subj2)
		subj2.next(2)
		outer.next(subj3)
		outer.complete()
		subj3.next(3)
		subj3.complete()

	it 'should work with BehaviorSubject', ->
		subj1 = createBehaviorSubject()
		subj1.next(1)
		subj2 = createBehaviorSubject()
		subj2.next(2)
		subj3 = createBehaviorSubject()
		subj3.next(3)
		outer = createSubject()

		switched = oswitch(outer)

		test(switched, console.log.bind(console), [
			(x) -> x is 1
			(x) -> x is 2
			(x) -> x is 3
			'complete'
			'failure'
		])

		outer.next(subj1)
		outer.next(subj2)
		outer.next(subj3)

	it 'should manage subscriptions properly', ->
		subj1 = createSubject({
			onObserversChanged: (obs, added, removed) ->
				console.log("subj1 observers", obs, "added", added, "removed", removed)
		})
		subj2 = createSubject({
			onObserversChanged: (obs, added, removed) ->
				console.log("subj2 observers", obs, "added", added, "removed", removed)
		})
		outer = createSubject()
		switched = oswitch(outer)

		sub = switched.subscribe(->)
		outer.next(subj1)
		outer.next(subj2)
		sub.unsubscribe()
