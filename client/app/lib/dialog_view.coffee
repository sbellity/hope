class DialogView extends Backbone.View
  
  initialize: ->
    console.log("Calling init on DialogView with el: ", @el)
    $(@el).dialog({ autoOpen: false, minWidth: 1000 })
    
  render: ->
    this
  
  buttons: =>
    _.extend({
      "Save"    : @saveChanges,
      "Cancel"  : @close
    }, @modelView.formButtons())
  
  open: =>
    @render()
    $(@el).dialog("open")
  
  close: =>
    $(@el).dialog('close')


