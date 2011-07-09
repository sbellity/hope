class StatementCollection extends Backbone.Collection
  model: Statement

  initialize: (objs, opts)->
    @engine = opts.engine
  
  url: ->
    ["engines", @engine.id, "statements"].join("/")