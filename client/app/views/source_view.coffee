class SourceView extends TBone.View
  template: "sources/show"
  className: "source"
  
  
    
class SourceListView extends TBone.View
  tagName: "li"
  className: "source"
  template: "sources/list"
  
  events:
    "click"       : "select"

  select: =>
    window.location.hash = @model.url()
  
