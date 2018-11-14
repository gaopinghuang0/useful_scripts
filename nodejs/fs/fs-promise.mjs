/*
Load json file(s) by Promise

Author: Gaoping Huang
Version: 0.1
Since: 11/14/2018
*/

import fs from 'fs'
import util from 'util'

const fsWritePromise = util.promisify(fs.writeFile)
const fsReadPromise = util.promisify(fs.readFile)

export const readFileData = (filename) => {
  return fsReadPromise(filename)
    .then(data => {
      return JSON.parse(data)  // parse Buffer to JS object
    })
    .catch(err => {
      console.log(err)
    })
}

export const saveFileData = (filename, data) => {
  return fsWritePromise(filename, data)
    .then(() => {
      // ok
    })
    .catch(err => {
      console.log(err)
    })
}