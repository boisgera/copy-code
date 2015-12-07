
$ = require "jquery"
Clipboard = require "clipboard"

# TODO: remove jquery dependency and install on require
#       instead provide a function that accepts a target
#       (as a HTML Element or JQuery Object ?).

# TODO: minimally intrusive: remove font awesome icon, react on pre over that
#       is NOT a code hover.

# TODO: implement a "flash" -- visual hint when the code is copied: the font
#       turns black, the background orange for a moment.

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
  $("<link rel='stylesheet' href='#{fontAwesomeCss}'>").appendTo("head")

  clipboards = []
  codeBlocks = $("pre").filter -> 
    $(this).children().prop("tagName") is "CODE"
  #codeBlocks.css cursor: "copy"

  # Quick and dirty test (prevent propagation)
  $("code").on "click", -> 
    console.log "trapped"
    false

  # Quick and dirty test
  $("pre").css cursor: "copy"
  $("code").css cursor: "text"

  for codeBlock in codeBlocks
#    $(codeBlock).css position: "relative"
#    button = $("<button style='display:none'><i class='fa fa-clipboard'></i></button>")
#    button.css position: "absolute", right: "0px", top: "0px"
#    button.css padding: "0.5px"
    text = filter($(codeBlock).text())
#    $(codeBlock).prepend button
#    do (button) ->
      # TODO: smoother transition ?
#      $(codeBlock).mouseenter(-> button.css display: "inline")
#      $(codeBlock).mouseleave(-> button.css display: "none")
    do (text) ->
      clipboard = new Clipboard codeBlock, #button[0],
        text: ->
          console.log "clicked"
          text
      clipboards.push clipboard

    # make sure that the button is visible only when the codeBlock is hovered.
    # style the button ? (flat)
    # add a visual effect on success (fast transition to white ?).

$(main)

