FormHelpers = (()-> 
  labelled_tag = (name, label, markup)->
    "<p><label for=\"#{name}\">#{label || name}</label>#{markup}</p>"
    
  input_tag = (type, name, value, label, opts)->
    labelled_tag name, label, "<input type='#{type || "text"}' name='#{name}' value='#{value || ""}' />"
   
  {
    # Input type = text...
    text_field: (name, value, label, opts)->
      input_tag "text", name, value, label, opts
    
    # Input type = password...
    password_field: (name, value, label, opts)->
      input_tag "password", name, value, label, opts
    
    # TextArea
    text_area: (name, value, label, opts)->
      labelled_tag name, label, "<textarea name=\"#{name}\">#{value || ""}</textarea>"
      
    # Select input...
    select: (name, value, values, label, html_opts)->
      html_opts ?= ""
      values = values() if _.isFunction(values)
      option_values = _.compact(_(values).map((ov)-> ov.id || ov)) if values
      option_values ?= []
      option = (val)->
        attrs = []
        if _.isArray(val)
          [d,v] = val
        else if _.isString(val) || _.isNumber(val)
          v = d = val
        else if val.id
          v = d = val.id
        if v && value
          if (_.isArray(value) && _.include(value, v.toString())) || v.toString() == value.toString()
            attrs.push("selected='selected'")
        "<option value=\"#{v}\" #{attrs.join(" ")}>#{d}</option>"
      labelled_tag name, label, "<select name=\"#{name}\" #{html_opts}>#{_.map(option_values, (v)-> option(v)).join("")}</select>"
  }  
)();
