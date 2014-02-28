{$$, View} = require 'atom'
pastie = require('./pastie.js')

module.exports =
class AtomPastieView extends View
  @content: ->
    editor = atom.workspace.activePaneItem
    @div class: 'atom-pastie overlay from-top', =>
      @div editor.getSelection().getText(), class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "atom-pastie:pastie", => @pastie()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  createView: ->
    $$ ->
      @div tabindex: -1, class: 'overlay from-top', =>
        @span class: 'loading loading-spinner-small inline-block'
        @span "Creating Pastie..."


  pastie: ->
    editor = atom.workspace.activePaneItem
    selection = editor.getSelection()
    if !selection.getText()
      return
    view = @createView()
    atom.workspaceView.append(view)
    pastie.sendToPastie selection.getText(),atom.workspace.activePaneItem.getTitle(), (link) ->
      view.append $$ ->
        atom.workspaceView.one 'core:cancel', -> view.remove()
        view.empty().focus().on 'focusout', -> view.remove()
        atom.clipboard.write(link)
        @div class: 'text-success', 'Pastie created and copied to clipboard. Link: ' + link
