class ListenerCollection extends Backbone.Collection
  model: Listener

  initialize: (objs, opts)->
    @statement = opts.statement
  
  url: ->
    [@statement.url(), "listeners"].join("/")