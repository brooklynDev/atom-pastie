AtomPastieView = require './atom-pastie-view'

module.exports =
  atomPastieView: null

  activate: (state) ->
    @atomPastieView = new AtomPastieView(state.atomPastieViewState)

  deactivate: ->
    @atomPastieView.destroy()

  serialize: ->
    atomPastieViewState: @atomPastieView.serialize()
