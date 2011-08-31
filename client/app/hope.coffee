class HopeWeb
  
  constructor: (el)->
    @version = "0.1.0"
    @view = new HopeView(el: $("##{el}"), app: this)
    window.location.hash = "/" if window.location.hash.length == 0
    console.log("Calling bootstrap on Hope")
    @boostrap()
    
  boostrap: ->
    $.get("/bootstrap", (res)=>
      @engines = new EngineCollection(res.engines)
      @sources = new SourceCollection(res.sources)
      @engines.bind "all", (e, data)=>
        console.log("engines collection event... #{e}", data)
        @view.renderEnginesList()
      @sources.bind "all", (e, data)=>
        console.log("sources collection event... #{e}", data)
        @view.renderSourcesList()    
      @onReady()
    )
    
  onReady: =>
    console.log("Hope ready !")
    $("#loading").hide()
    @view.render()
    $(@view.el).show()
    @router = new HopeRouter(app: this)
    Backbone.history.start()
    
        
  addEngine: (id)->
    return false if @engines.get(id)
    e = new Engine({ name: id })
    @engines.create(e)
    e
    
  addSource: (name, type, opts={})->
    return false if @sources.get(name)
    s = new Source({ name: name, type: type, opts: opts })
    @sources.create(s)
    s

    
Hope.init = (config)->
  new HopeWeb(config)