class HopeController extends Backbone.Controller
  
  initialize:(opts)->
    @app = opts.app
  
  routes: 
    "/"           : "root"
    "/engines/:id" : "engine"
    
  root: ->
    console.log("Back to the basics...")
    
  engine: (id)->
    @app.view.selectEngine(id)
    