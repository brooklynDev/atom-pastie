AtomPastie = require '../lib/atom-pastie'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomPastie", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('atomPastie')

  describe "when the atom-pastie:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.atom-pastie')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'atom-pastie:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.atom-pastie')).toExist()
        atom.workspaceView.trigger 'atom-pastie:toggle'
        expect(atom.workspaceView.find('.atom-pastie')).not.toExist()
