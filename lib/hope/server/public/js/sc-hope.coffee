Hope = SC.Application.create
  rootElement: $('#hope')
  store: SC.Store.create().from('Hope.FixturesDataSource')
  name: "Hope ! v 12",
  bootstrap: ()->
    $('#loading').hide()
    $('#hope').show()
  # bootstrap: ()->
  #   $.get '/bootstrap', (res)->
  #     console.log "Bootstrap data: ", res
  #     Hope.enginesController.initContent(res.engines)
  #     Hope.sourcesController.initContent(res.sources)
  #     $('#loading').hide()
  #     $('#hope').show()    

  createEngine: (engineId)->
    Hope.enginesController.createItem(id: engineId)

  createSource: (sourceId, sourceType, sourceOpt)->
    Hope.sourcesController.createItem(name: sourceId, type: sourceType, opts: sourceOpts)


Hope.FixturesDataSource = SC.FixturesDataSource.extend
  simulateRemoteResponse: YES
  latency: 250
  
Hope.BaseRecord = SC.Record.extend
  primaryKey      : "id"
  name            : SC.Record.attr String

Hope.Engine     = Hope.BaseRecord.extend
  statements      : SC.Record.toMany 'Hope.Statement', { inverse: 'engine' }
  url: (()->
    ['/engines', @get('id')].join('/')
  ).property('id').cacheable(),

Hope.Statement  = Hope.BaseRecord.extend
  engine          : SC.Record.toOne   "Hope.Engine", { inverse: 'statements' }
  listeners       : SC.Record.toMany  "Hope.Listener", { inverse: "statement" }
  text            : SC.Record.attr String
  updated_at      : SC.Record.attr String
  state           : SC.Record.attr String
  is_pattern      : SC.Record.attr Boolean
  event_type      : SC.Record.attr String
  is_destroyed    : SC.Record.attr Boolean

Hope.Listener   = Hope.BaseRecord.extend
  statement       : SC.Record.toOne "Hope.Statement", { inverse: 'listeners' }
  
  
Hope.Source     = SC.Object.extend()

Hope.ContentController = SC.ArrayProxy.extend

  recordType: SC.Object

  initContent: (items)->
    c = items.map (c)=> @recordType.create(c)
    console.log "Init controller #{@url} with ", c
    @init(c)

  createItem: (d)->
    $.post @url, d, (res)=>
      @pushObject(@recordType.create(res))

  findById:(itemId)->
    @findProperty('id', itemId)

  destroyItem: (itemId)->
    item = @findById itemId
    return false unless item
    $.ajax
      type:'delete',
      url: [@url, item.id].join('/')
      success: =>
        @removeObject(item)


Hope.enginesController = Hope.ContentController.create
  url: '/engines'
  recordType: Hope.Engine
  content: []


Hope.sourcesController = Hope.ContentController.create
  url: '/sources'
  recordType: Hope.Source
  content: []


$ -> Hope.bootstrap()
  




# Fixtures...
Hope.Engine.FIXTURES = [{
  id: 1
  name: 'engine1'
  statements: [1,2]
},{
  name: 'engine2'
  statements: [3,4]
}]
  
Hope.Statement.FIXTURES = [{
  id: 1,
  name: 'all_strings',
  text: 'select * from java.lang.String'
  state: 'STARTED'
},{
  id: 2,
  name: 'all_tweets',
  text: 'select * from Tweet'
  state: 'STARTED'
},{
  id: 3,
  name: 'all_strings',
  text: 'select * from java.lang.String'
  state: 'STOPPED'
},{
  id: 4,
  name: 'all_users',
  text: 'select * from TwittertUser'
  state: 'STOPPPED'
}]

Hope.Listener.FIXTURES = []