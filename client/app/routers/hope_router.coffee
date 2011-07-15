class HopeRouter extends Backbone.Router
  
  initialize:(opts)->
    @app = opts.app
  
  routes: 
    "/"             : "root"
    "/engines/:id"  : "engine"
    "/sources/:id"  : "source"
    
  root: ->
    console.log("Back to the basics...")
    
  engine: (id)->
    @app.view.selectEngine(id)
    
  source: (id)->
    @app.view.selectSource(id)