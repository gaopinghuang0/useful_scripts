
// node @8.12.0
// ES6 module is experimental
// should be named as '*.mjs' and execute like below:
// node --experimental-modules fs-promise-test.mjs

import { readFileData } from './fs-promise'

readFileData('./a.json')
.then(data => {
  console.log(data)
})