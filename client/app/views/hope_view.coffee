class HopeView extends Backbone.View

  template: Hope.Templates['hope']
  
  events:
    "click .logo" : "home"
  
  
  initialize: (opts)->
    @app = opts.app
  
  home: ->
    window.location.hash = "/" 
    console.log("Going back home...")
  
  render: =>
    $(@el).html(@template(@model))
    console.log("App", @app.engines)
    @renderEnginesList()
    @renderSourcesList()
    @edit_dialog = new EditDialogView({ el: $('#dialog'), app: @ })
    

  selectEngine: (id)=>
    return unless e = @app.engines.get(id)
    @$(".side .selected").removeClass("selected")
    @current_view = new EngineView(model: e, el: @$(".current"))
    @current_view.el = @$(".current")
    @current_view.render()
    $("#engine-engines-list-#{e.cid}").addClass("selected")

  selectSource: (id)=>
    return unless s = @app.sources.get(id)
    @$(".side .selected").removeClass("selected")
    @current_view = new SourceView(model: s, el: @$(".current"))
    @current_view.el = @$(".current")
    @current_view.render()
    $("#source-sources-list-#{s.cid}").addClass("selected")

  
  renderEnginesList: =>
    @$("#engines_list").html('')
    @app.engines.each((engine)=> (new EngineListView(model: engine, parent_el: @$("#engines_list"))).render())

  renderSourcesList: =>
    @$("#sources_list").html('')
    @app.sources.each((source)=> (new SourceListView(model: source, parent_el: @$("#sources_list"))).render())
