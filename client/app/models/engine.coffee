class Engine extends Backbone.Model
  
  initialize: ->
    @statements = new StatementCollection((@get("statements") || []), engine: this)
    
  addStatement: (epl, id)->
    @statements.create statement_id: id, epl: epl
    
  stop: ()->
    $.post [@url(), "stop"].join("/"), (res)=>
      @statements.fetch()

  start: ()->
    $.post [@url(), "start"].join("/"), (res)=>
      @statements.fetch()

  subscribe: (srcName)->
    $.post [@url(), "subscribe", srcName].join("/"), (res)=>
      @set(res)

  unsubscribe: (srcName)->
    $.post [@url(), "unsubscribe", srcName].join("/"), (res)=>
      @set(res)
  