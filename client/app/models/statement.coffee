class Statement extends Backbone.Model
  
  initialize: ->
    @listeners = new ListenerCollection((@get("listeners") || []), statement: this)
  
  
  stop: (callback)->
    $.post [@url(), "stop"].join("/"), (res)=> 
      @set(res)
      callback(res) if callback

    
  start: (callback)->
    $.post [@url(), "start"].join("/"), (res)=> 
      @set(res)
      callback(res) if callback
  
  addListener: (name)->
    l = new Listener(name: name)
    @listeners.create(l)
    l

