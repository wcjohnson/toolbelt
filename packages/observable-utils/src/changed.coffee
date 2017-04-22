# Emits only when the priorObservable emits a value different from its last
# emission.
import memoize from './memoize'
import filter from './filter'
import map from './map'

strictEqual = (a,b) -> a is b

export default changed = (priorObservable, equalityTest = strictEqual) ->
  map(
    filter(
      memoize(priorObservable, 1)
      (memory) -> (memory.length is 1) or (not equalityTest(memory[0], memory[1]))
    )
    (memory) -> memory[0]
  )
