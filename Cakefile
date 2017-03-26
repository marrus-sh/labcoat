fs     = require 'fs'
{exec} = require 'child_process'

files = [
  'README'
  'Columns/README'
  'Columns/parts/Column'
  'Columns/parts/GoLink'
  'Columns/parts/Heading'
  'Columns/parts/Status'
  'Columns/productions/Empty'
  'Columns/productions/Go'
  'Columns/productions/NotFound'
  'Columns/productions/Timeline'
  'Modules/README'
  'Modules/parts/Module'
  'Modules/productions/Account'
  'Modules/productions/Composer'
  'Modules/productions/Post'
  'Modules/productions/Start'
  'Shared/README'
  'Shared/parts/Action'
  'Shared/parts/Button'
  'Shared/parts/Icon'
  'Shared/parts/IDCard'
  'Shared/parts/Textbox'
  'Shared/parts/Toggle'
  'Shared/productions/InstanceQuery'
  'Shared/productions/Frontend'
  'UI/README'
  'UI/parts/Header'
  'UI/parts/Title'
  'UI/productions/UI'
  'Locales/README'
  'Locales/en'
  'INSTALLING'
]

task 'build', 'Build single application file from source files', ->
  contents = new Array remaining = files.length
  for file, index in files then do (file, index) ->
    fs.readFile "src/#{file}.litcoffee", "utf8", (err, fileContents) ->
      throw err if err
      contents[index] = fileContents
      process() if --remaining is 0
  process = ->
    fs.writeFile "dist/labcoat.litcoffee", contents.join('\n\n'), 'utf8', (err) ->
      throw err if err
      exec "coffee --compile dist/labcoat.litcoffee", (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
        exec "uglifyjs dist/labcoat.js --comments all --compress --output dist/labcoat.min.js", (err, stdout, stderr) ->
          throw err if err
          console.log stdout + stderr
          exec "sass --no-cache --sourcemap=none styling/index.scss dist/labcoat.css", (err, stdout, stderr) ->
            throw err if err
            console.log stdout + stderr
            console.log "Done."
