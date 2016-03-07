Angular2Styleguide = require '../lib/angular2-styleguide'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Angular2Styleguide", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('angular2-styleguide')

  describe "when the angular2-styleguide:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.angular2-styleguide')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'angular2-styleguide:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.angular2-styleguide')).toExist()

        angular2StyleguideElement = workspaceElement.querySelector('.angular2-styleguide')
        expect(angular2StyleguideElement).toExist()

        angular2StyleguidePanel = atom.workspace.panelForItem(angular2StyleguideElement)
        expect(angular2StyleguidePanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'angular2-styleguide:toggle'
        expect(angular2StyleguidePanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.angular2-styleguide')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'angular2-styleguide:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        angular2StyleguideElement = workspaceElement.querySelector('.angular2-styleguide')
        expect(angular2StyleguideElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'angular2-styleguide:toggle'
        expect(angular2StyleguideElement).not.toBeVisible()
