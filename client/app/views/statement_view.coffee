class StatementView extends TBone.View
  className: "statement"
  events: 
    'click .edit' : 'edit'
    'click .statement-stop' : 'stop'
    'click .statement-start' : 'start'
    'click .statement-destroy' : 'destroy'
    
  form: ->
    [[
      "Statement",
      [ 
        ["statement_id",  ["text_field", "Name"]],
        ["epl",           ["text_area", "Epl"]]
      ]
    ]]
    
  stop: ->
    @model.stop() if confirm("Sure ?")

  start: ->
    @model.start() if confirm("Sure ?")

  destroy: ->
    @model.destroy() if confirm("Sure ?")


class StatementListView extends StatementView
  tagName: "tr"
  template: "statements/list"
  
  