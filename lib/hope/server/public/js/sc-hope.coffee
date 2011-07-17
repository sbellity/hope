Hope = SC.Application.create
  rootElement: $('#hope')
  name: "Hope ! v 12",
  bootstrap: ()->
    $.get '/bootstrap', (res)->
      Hope.enginesController.initContent(res.engines)
      Hope.sourcesController.initContent(res.sources)
      $('#loading').hide()
      $('#hope').show()    


Hope.DataSource = SC.DataSource.extend()

Hope.Engine     = SC.Record.extend()
Hope.Statement  = SC.Record.extend()
Hope.Source     = SC.Record.extend()

Hope.ContentController = SC.ArrayProxy.extend
  recordType: SC.Record
  createItem: (d)->
    @pushObject(this.recordType.create(d))

  initContent: (items)->
    @set "content", []
    items.forEach (e)=>
      @pushObject(@recordType.create(e))


Hope.enginesController = Hope.ContentController.create
  recordType: Hope.Engine
  content: []


Hope.sourcesController = Hope.ContentController.create
  recordType: Hope.Source
  content: []


$(()-> 
  setInterval("Hope.bootstrap()", 1000)
)