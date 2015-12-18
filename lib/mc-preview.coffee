McPreviewView = require './mc-preview-view'
{CompositeDisposable} = require 'atom'

module.exports = McPreview =
  mcPreviewView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @mcPreviewView = new McPreviewView(state.mcPreviewViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @mcPreviewView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'mc-preview:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @mcPreviewView.destroy()

  serialize: ->
    mcPreviewViewState: @mcPreviewView.serialize()

  toggle: ->
    console.log 'McPreview was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
