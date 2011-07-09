class EditDialogView extends DialogView
    
  render: =>
    return $(@el).html("No model provided !") unless @modelView && @modelView.model
    @isNew = @modelView.model.isNew()
    if @modelView
      $(@el).dialog("option", "title", @modelView.model.id)
      $(@el).html("<div class='form_errors'></div><div class='form_container'>#{@modelView.renderForm()}</div>")
    this
  
  buttons: =>
    _.extend({
      "Save"    : @saveChanges,
      "Cancel"  : @close
    }, @modelView.formButtons())
  
    
  open: =>
    $(@el).dialog("option", "buttons", @buttons())
    super()
  
  onSuccess: =>
    @close()
    
  onError: (i, resp)=>
    errorMessage = JSON.parse(resp.responseText)
    $(".form_errors").html("Error: #{errorMessage['error']}")
    $(".form_errors").show()
    $(@el).dialog('widget').find('button').button('enable')        
    
  saveChanges: =>
    $(@el).dialog('widget').find('button').button('disable')
    properties = {}
    for input in @el.find('input,textarea,select')
      properties[input.name] = $(input).val()
    if @isNew
      @modelView.model.collection.create(properties, { success: @onSuccess, error: @onError})
    else
      @modelView.model.save(properties, { success: @onSuccess, error: @onError})
    false