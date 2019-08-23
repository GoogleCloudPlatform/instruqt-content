// Copyright 2019 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

const fs = require('fs')
const csv = require('csvtojson')
const Mustache = require("mustache")

const trackPath = process.env.TRACK

const csvFilePath = trackPath + 'track-translations.csv'
const templateFilePath = trackPath + 'track.yml.template'

const template = fs.readFileSync(templateFilePath, 'utf8')
Mustache.parse(template)

csv()
.fromFile(csvFilePath)
.then(jsonObj => {
  for(let language of getLanguages(jsonObj)) {
    const view = createView(language, jsonObj)
    const rendered = Mustache.render(template, view)
    fs.writeFileSync(`${trackPath}track_${language}.yml`, rendered)
  }
  console.log('Done creating track.yml files')
})

// Get Language Codes from the header row
function getLanguages(i) {
  let l = Object.keys(i[0])
  l.splice(l.indexOf('key'), 1) // Remove the Key column
  return l
}

// Create a Mustache view for an individual language
function createView(language, all) {
  const view = {'language-code': language}
  for(let row of all) {
    view[row.key] = `"${row[language].replace(/"/g, '\\"')}"`
  }
  return view
}