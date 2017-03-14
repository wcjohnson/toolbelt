# From facebook's invariant.js

# Copyright 2013-2015, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree. An additional grant
# of patent rights can be found in the PATENTS file in the same directory.
#

export default invariant = (condition, format, a, b, c, d, e, f) ->
	if process.env.NODE_ENV isnt 'production'
		if format is undefined
			throw new Error('invariant requires an error message argument')

	if not condition
		if format is undefined
			error = new Error('Minified exception occurred; use the non-minified dev environment for the full error message and additional helpful warnings.')
		else
			args = [a,b,c,d,e,f]
			argIndex = 0
			error = new Error( format.replace(/%s/g, -> args[argIndex++]) )
			error.name = 'Invariant Violation'
		error.framesToPop = 1
		throw error
