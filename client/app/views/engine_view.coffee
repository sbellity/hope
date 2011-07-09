class EngineView extends TBone.View
  template: "engines/show"
  className: "engine"
  
  events: 
    "click .newStatement" : "newStatement"
   
  initialize: (opts)->
    super(opts)
    @model.statements.bind("all", @render)
    
  render: =>
    super()
    @model.statements.each((statement)=> 
      new StatementListView(model: statement, parent_el: @$(".statements_list")).render()
    )
    
  newStatement: ->
    nc = new StatementView(model: new Statement())
    nc.model.collection = @model.statements
    window.hope.view.edit_dialog.modelView = nc
    window.hope.view.edit_dialog.open()
  
    
class EngineListView extends TBone.View
  tagName: "li"
  className: "engine"
  template: "engines/list"
  
  events:
    "click"       : "select"

  select: =>
    window.location.hash = @model.url()
  
