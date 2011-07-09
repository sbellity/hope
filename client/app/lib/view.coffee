TBone ?= {}
class TBone.View extends Backbone.View
  tagName: 'div'
  
  initialize: (opts)->
    _.bindAll(this, "render")
    @parent_el = opts.parent_el
    @model.bind("change", @render)
  
  formButtons: -> {}
  
  renderForm: ->
    if _.isFunction(@form_template)
      @form_template(model: @model, app: App)
    else if @form
      fieldsets = []
      if _.isFunction(@form)
        fieldsets = fieldsets.concat @form.apply(this)
      else
        fieldsets = fieldsets.concat @form
      out = []
      _(fieldsets).each (fs)=>
        [name,fields] = fs
        out.push "<fieldset><legend>#{name}</legend>"
        _.map(fields, (i) =>
          [k, v] = i
          out.push FormHelpers[v[0]].call(this, [k, @model.get(k), _.rest(v)...]...)
        )
        out.push "</fieldset>"
      out.join("\n")
        
    else
      "Not available yet !"
  
  select: ->
    console.log("#{@model} Selected !")
    
  edit: ->
    window.hope.view.edit_dialog.modelView = this
    window.hope.view.edit_dialog.open()

  render: (tpl_name)->
    template = Hope.Templates[tpl_name] if tpl_name
    template ?= Hope.Templates["#{@className.pluralize()}/#{@template}"] || Hope.Templates[@template] if @template
    template ?= Hope.Templates["#{@className.pluralize()}/show"] || _.template("Missing template for #{@className}(#{@model.id})")

    el_id = "#{[@className, (@template || "show").replace("/", "-")].join("-")}-#{@model.cid}"
    
    $(@parent_el).append($(@el)) if @parent_el && $("##{el_id}").length == 0
      
    $(@el).attr("id", el_id)
    $(@el).addClass(@className)
    view_data = {}
    view_data[@className] = @model

    $(@el).html(template(view_data))
    this

  show: ->
    $(@el).show()
    
  hide: ->
    $(@el).hide()