var Hope;
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
Hope = SC.Application.create({
  rootElement: $('#hope'),
  store: SC.Store.create().from('Hope.FixturesDataSource'),
  name: "Hope ! v 12",
  bootstrap: function() {
    $('#loading').hide();
    return $('#hope').show();
  },
  createEngine: function(engineId) {
    return Hope.enginesController.createItem({
      id: engineId
    });
  },
  createSource: function(sourceId, sourceType, sourceOpt) {
    return Hope.sourcesController.createItem({
      name: sourceId,
      type: sourceType,
      opts: sourceOpts
    });
  }
});
Hope.FixturesDataSource = SC.FixturesDataSource.extend({
  simulateRemoteResponse: YES,
  latency: 250
});
Hope.BaseRecord = SC.Record.extend({
  primaryKey: "id",
  name: SC.Record.attr(String)
});
Hope.Engine = Hope.BaseRecord.extend({
  statements: SC.Record.toMany('Hope.Statement')
}, {
  inverse: 'engine'
}, {
  url: (function() {
    return ['/engines', this.get('id')].join('/');
  }).property('id').cacheable()
});
Hope.Statement = Hope.BaseRecord.extend({
  engine: SC.Record.toOne("Hope.Engine")
}, {
  inverse: 'statements'
}, {
  listeners: SC.Record.toMany("Hope.Listener")
}, {
  inverse: "statement"
}, {
  text: SC.Record.attr(String),
  updated_at: SC.Record.attr(String),
  state: SC.Record.attr(String),
  is_pattern: SC.Record.attr(Boolean),
  event_type: SC.Record.attr(String),
  is_destroyed: SC.Record.attr(Boolean)
});
Hope.Listener = Hope.BaseRecord.extend({
  statement: SC.Record.toOne("Hope.Statement")
}, {
  inverse: 'listeners'
});
Hope.Source = SC.Object.extend();
Hope.ContentController = SC.ArrayProxy.extend({
  recordType: SC.Object,
  initContent: function(items) {
    var c;
    c = items.map(__bind(function(c) {
      return this.recordType.create(c);
    }, this));
    console.log("Init controller " + this.url + " with ", c);
    return this.init(c);
  },
  createItem: function(d) {
    return $.post(this.url, d, __bind(function(res) {
      return this.pushObject(this.recordType.create(res));
    }, this));
  },
  findById: function(itemId) {
    return this.findProperty('id', itemId);
  },
  destroyItem: function(itemId) {
    var item;
    item = this.findById(itemId);
    if (!item) {
      return false;
    }
    return $.ajax({
      type: 'delete',
      url: [this.url, item.id].join('/'),
      success: __bind(function() {
        return this.removeObject(item);
      }, this)
    });
  }
});
Hope.enginesController = Hope.ContentController.create({
  url: '/engines',
  recordType: Hope.Engine,
  content: []
});
Hope.sourcesController = Hope.ContentController.create({
  url: '/sources',
  recordType: Hope.Source,
  content: []
});
$(function() {
  return Hope.bootstrap();
});
Hope.Engine.FIXTURES = [
  {
    id: 1,
    name: 'engine1',
    statements: [1, 2]
  }, {
    name: 'engine2',
    statements: [3, 4]
  }
];
Hope.Statement.FIXTURES = [
  {
    id: 1,
    name: 'all_strings',
    text: 'select * from java.lang.String',
    state: 'STARTED'
  }, {
    id: 2,
    name: 'all_tweets',
    text: 'select * from Tweet',
    state: 'STARTED'
  }, {
    id: 3,
    name: 'all_strings',
    text: 'select * from java.lang.String',
    state: 'STOPPED'
  }, {
    id: 4,
    name: 'all_users',
    text: 'select * from TwittertUser',
    state: 'STOPPPED'
  }
];
Hope.Listener.FIXTURES = [];