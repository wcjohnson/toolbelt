import nodeurl from 'url'

# Perform URL surgery.
export default editUrl = (origURL, extraPath, newQueryParams) ->
	if (typeof origURL isnt 'string') then return null
	x = nodeurl.parse(origURL, true)
	delete x.search
	if extraPath then x.pathname += extraPath
	if newQueryParams then Object.assign(x.query, newQueryParams)
	nodeurl.format(x)
