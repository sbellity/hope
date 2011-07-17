var Hope;
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
Hope = SC.Application.create({
  rootElement: $('#hope'),
  name: "Hope ! v 12",
  bootstrap: function() {
    return $.get('/bootstrap', function(res) {
      Hope.enginesController.initContent(res.engines);
      Hope.sourcesController.initContent(res.sources);
      $('#loading').hide();
      return $('#hope').show();
    });
  }
});
Hope.DataSource = SC.DataSource.extend();
Hope.Engine = SC.Record.extend();
Hope.Statement = SC.Record.extend();
Hope.Source = SC.Record.extend();
Hope.ContentController = SC.ArrayProxy.extend({
  recordType: SC.Record,
  createItem: function(d) {
    return this.pushObject(this.recordType.create(d));
  },
  initContent: function(items) {
    this.set("content", []);
    return items.forEach(__bind(function(e) {
      return this.pushObject(this.recordType.create(e));
    }, this));
  }
});
Hope.enginesController = Hope.ContentController.create({
  recordType: Hope.Engine,
  content: []
});
Hope.sourcesController = Hope.ContentController.create({
  recordType: Hope.Source,
  content: []
});
$(function() {
  return setInterval("Hope.bootstrap()", 1000);
});