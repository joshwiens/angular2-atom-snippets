Angular2StyleguideView = require './angular2-styleguide-view'
{CompositeDisposable} = require 'atom'

module.exports = Angular2Styleguide =
  angular2StyleguideView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @angular2StyleguideView = new Angular2StyleguideView(state.angular2StyleguideViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @angular2StyleguideView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'angular2-styleguide:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @angular2StyleguideView.destroy()

  serialize: ->
    angular2StyleguideViewState: @angular2StyleguideView.serialize()

  toggle: ->
    console.log 'Angular2Styleguide was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
