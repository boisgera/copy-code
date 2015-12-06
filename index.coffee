
$ = require "jquery"
_ = require "font-awesome"
Clipboard = require "clipboard"

# TODO: remove jquery dependency and install on require
#       instead provide a function that accepts a target
#       (as a HTML Element or JQuery Object ?).

String::startsWith ?= (string) -> this[...string.length] is string

prompts = ["$ ", "> ", ">>> ", "... "]

filter = (text) ->
  lines = text.split "\n"
  newLines = []
  for line in lines
    newLine = undefined
    for prompt in prompts
      if line.startsWith prompt
        newLine = line[prompt.length..] + "\n"
        break
    newLine ?= line + "\n"
    newLines.push newLine
  "".concat(newLines...)

main = ->
  # TODO: check that font awesome is not installed yet ?
  fontAwesomeCss = "node_modules/font-awesome/css/font-awesome.css"
  $("<link rel='stylesheet' href='#{fontAwesomeCss}'").appendTo("head")

  clipboards = []
  codeBlocks = $("pre").filter -> 
    $(this).children().prop("tagName") is "CODE"
  #codeBlocks.css cursor: "copy"

  for codeBlock in codeBlocks
    console.log "***", codeBlock.text()

  targets.each ->
    text = $(this).text()
    #console.log "text:", text, filter(text)
    target = this
    do (text) -> 
      clipboards.push new Clipboard target, 
        text: ->
          filter(text)

$(main)

