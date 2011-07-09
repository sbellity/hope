class HopeWeb
  
  constructor: (el)->
    @version = "0.0.1"
    @view = new HopeView(el: $("##{el}"), app: this)
    window.location.hash = "/" if window.location.hash.length == 0
    console.log("Calling bootstrap on Hope")
    @boostrap()
    
  boostrap: ->
    @engines = new EngineCollection
    @sources = new SourceCollection
    @engines.bind "all", (e, data)=>
      console.log("engines collection event... #{e}", data)
      @view.renderEnginesList()
    @sources.bind "all", (e, data)=>
      console.log("sources collection event... #{e}", data)
      @view.renderSourcesList()
    @engines.fetch(success: @onReady)
    @sources.fetch()
    
  onReady: =>
    console.log("Hope ready !")
    $("#loading").hide()
    @view.render()
    $(@view.el).show()
    @controller = new HopeController(app: this)
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