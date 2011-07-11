var Hope; window.Hope = Hope = {};Hope.Templates = {};
  Hope.Templates['hope'] = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<div id="dialog" style="display:none"></div>\n\n<div id="layout">\n  <div id="header" class="header">\n    <span class="logo">Hope !</span>\n  </div>\n\n  <div id="main" class="main">\n    <div class="side">\n      <h2>Engines</h2>\n      <div id="engines_list" class="side_content"></div>\n      \n      <h2>Sources</h2>\n      <div id="sources_list" class="side_content"></div>\n    </div>\n    <div class="current current_engine"></div>\n  </div>\n</div>\n\n<div id="footer" class="footer">\n  ...\n</div>');
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};


  Hope.Templates['engines/list'] = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push(__sanitize(this.engine.id));
      __out.push('\n');
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};


  Hope.Templates['engines/show'] = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<h1>Engine: ');
      __out.push(__sanitize(this.engine.id));
      __out.push('</h1>\n\n<button class="newStatement">Add Statement</button>\n\n\n<h2>Statements</h2>\n<table>\n  <thead>\n    <tr>\n      <th>Id</th>\n      <th>State</th>\n      <th>Text</th>\n      <th>Listeners</th>\n    </tr>\n  </thead>\n  <tbody class="statements_list"></tbody>\n</table>\n\n');
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};


  Hope.Templates['sources/list'] = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push(__sanitize(this.source.id));
      __out.push('\n');
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};


  Hope.Templates['sources/show'] = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<h1>Source: ');
      __out.push(__sanitize(this.source.name));
      __out.push('</h1>\n');
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};


  Hope.Templates['statements/list'] = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<td>');
      __out.push(__sanitize(this.statement.id));
      __out.push('</td>\n<td>');
      __out.push(__sanitize(this.statement.get('state')));
      __out.push('</td>\n<td>');
      __out.push(__sanitize(this.statement.get('text')));
      __out.push('</td>\n<td>');
      __out.push(__sanitize(_.map(this.statement.listeners.models, function(l) {
        return l.get("name");
      }).join(", ")));
      __out.push('</td>\n<td>\n  <button class=\'statement-start\'>START</button>\n  <button class=\'statement-stop\'>STOP</button>\n  <button class=\'statement-destroy\'>DELETE</button>\n</td>');
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};

(function() {
  var DialogView, EditDialogView, Engine, EngineCollection, EngineListView, EngineView, FormHelpers, HopeController, HopeView, HopeWeb, Listener, ListenerCollection, Source, SourceCollection, SourceListView, SourceView, Statement, StatementCollection, StatementListView, StatementView;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __slice = Array.prototype.slice;
  HopeWeb = (function() {
    function HopeWeb(el) {
      this.onReady = __bind(this.onReady, this);      this.version = "0.0.1";
      this.view = new HopeView({
        el: $("#" + el),
        app: this
      });
      if (window.location.hash.length === 0) {
        window.location.hash = "/";
      }
      console.log("Calling bootstrap on Hope");
      this.boostrap();
    }
    HopeWeb.prototype.boostrap = function() {
      this.engines = new EngineCollection;
      this.sources = new SourceCollection;
      this.engines.bind("all", __bind(function(e, data) {
        console.log("engines collection event... " + e, data);
        return this.view.renderEnginesList();
      }, this));
      this.sources.bind("all", __bind(function(e, data) {
        console.log("sources collection event... " + e, data);
        return this.view.renderSourcesList();
      }, this));
      this.engines.fetch({
        success: this.onReady
      });
      return this.sources.fetch();
    };
    HopeWeb.prototype.onReady = function() {
      console.log("Hope ready !");
      $("#loading").hide();
      this.view.render();
      $(this.view.el).show();
      this.controller = new HopeController({
        app: this
      });
      return Backbone.history.start();
    };
    HopeWeb.prototype.addEngine = function(id) {
      var e;
      if (this.engines.get(id)) {
        return false;
      }
      e = new Engine({
        name: id
      });
      this.engines.create(e);
      return e;
    };
    HopeWeb.prototype.addSource = function(name, type, opts) {
      var s;
      if (opts == null) {
        opts = {};
      }
      if (this.sources.get(name)) {
        return false;
      }
      s = new Source({
        name: name,
        type: type,
        opts: opts
      });
      this.sources.create(s);
      return s;
    };
    return HopeWeb;
  })();
  Hope.init = function(config) {
    return new HopeWeb(config);
  };
  DialogView = (function() {
    __extends(DialogView, Backbone.View);
    function DialogView() {
      this.close = __bind(this.close, this);
      this.open = __bind(this.open, this);
      this.buttons = __bind(this.buttons, this);
      DialogView.__super__.constructor.apply(this, arguments);
    }
    DialogView.prototype.initialize = function() {
      console.log("Calling init on DialogView with el: ", this.el);
      return $(this.el).dialog({
        autoOpen: false,
        minWidth: 1000
      });
    };
    DialogView.prototype.render = function() {
      return this;
    };
    DialogView.prototype.buttons = function() {
      return _.extend({
        "Save": this.saveChanges,
        "Cancel": this.close
      }, this.modelView.formButtons());
    };
    DialogView.prototype.open = function() {
      this.render();
      return $(this.el).dialog("open");
    };
    DialogView.prototype.close = function() {
      return $(this.el).dialog('close');
    };
    return DialogView;
  })();
  EditDialogView = (function() {
    __extends(EditDialogView, DialogView);
    function EditDialogView() {
      this.saveChanges = __bind(this.saveChanges, this);
      this.onError = __bind(this.onError, this);
      this.onSuccess = __bind(this.onSuccess, this);
      this.open = __bind(this.open, this);
      this.buttons = __bind(this.buttons, this);
      this.render = __bind(this.render, this);
      EditDialogView.__super__.constructor.apply(this, arguments);
    }
    EditDialogView.prototype.render = function() {
      if (!(this.modelView && this.modelView.model)) {
        return $(this.el).html("No model provided !");
      }
      this.isNew = this.modelView.model.isNew();
      if (this.modelView) {
        $(this.el).dialog("option", "title", this.modelView.model.id);
        $(this.el).html("<div class='form_errors'></div><div class='form_container'>" + (this.modelView.renderForm()) + "</div>");
      }
      return this;
    };
    EditDialogView.prototype.buttons = function() {
      return _.extend({
        "Save": this.saveChanges,
        "Cancel": this.close
      }, this.modelView.formButtons());
    };
    EditDialogView.prototype.open = function() {
      $(this.el).dialog("option", "buttons", this.buttons());
      return EditDialogView.__super__.open.call(this);
    };
    EditDialogView.prototype.onSuccess = function() {
      return this.close();
    };
    EditDialogView.prototype.onError = function(i, resp) {
      var errorMessage;
      errorMessage = JSON.parse(resp.responseText);
      $(".form_errors").html("Error: " + errorMessage['error']);
      $(".form_errors").show();
      return $(this.el).dialog('widget').find('button').button('enable');
    };
    EditDialogView.prototype.saveChanges = function() {
      var input, properties, _i, _len, _ref;
      $(this.el).dialog('widget').find('button').button('disable');
      properties = {};
      _ref = this.el.find('input,textarea,select');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        input = _ref[_i];
        properties[input.name] = $(input).val();
      }
      if (this.isNew) {
        this.modelView.model.collection.create(properties, {
          success: this.onSuccess,
          error: this.onError
        });
      } else {
        this.modelView.model.save(properties, {
          success: this.onSuccess,
          error: this.onError
        });
      }
      return false;
    };
    return EditDialogView;
  })();
  FormHelpers = (function() {
    var input_tag, labelled_tag;
    labelled_tag = function(name, label, markup) {
      return "<p><label for=\"" + name + "\">" + (label || name) + "</label>" + markup + "</p>";
    };
    input_tag = function(type, name, value, label, opts) {
      return labelled_tag(name, label, "<input type='" + (type || "text") + "' name='" + name + "' value='" + (value || "") + "' />");
    };
    return {
      text_field: function(name, value, label, opts) {
        return input_tag("text", name, value, label, opts);
      },
      password_field: function(name, value, label, opts) {
        return input_tag("password", name, value, label, opts);
      },
      text_area: function(name, value, label, opts) {
        return labelled_tag(name, label, "<textarea name=\"" + name + "\">" + (value || "") + "</textarea>");
      },
      select: function(name, value, values, label, html_opts) {
        var option, option_values;
                if (html_opts != null) {
          html_opts;
        } else {
          html_opts = "";
        };
        if (_.isFunction(values)) {
          values = values();
        }
        if (values) {
          option_values = _.compact(_(values).map(function(ov) {
            return ov.id || ov;
          }));
        }
                if (option_values != null) {
          option_values;
        } else {
          option_values = [];
        };
        option = function(val) {
          var attrs, d, v;
          attrs = [];
          if (_.isArray(val)) {
            d = val[0], v = val[1];
          } else if (_.isString(val) || _.isNumber(val)) {
            v = d = val;
          } else if (val.id) {
            v = d = val.id;
          }
          if (v && value) {
            if ((_.isArray(value) && _.include(value, v.toString())) || v.toString() === value.toString()) {
              attrs.push("selected='selected'");
            }
          }
          return "<option value=\"" + v + "\" " + (attrs.join(" ")) + ">" + d + "</option>";
        };
        return labelled_tag(name, label, "<select name=\"" + name + "\" " + html_opts + ">" + (_.map(option_values, function(v) {
          return option(v);
        }).join("")) + "</select>");
      }
    };
  })();
    if (typeof TBone !== "undefined" && TBone !== null) {
    TBone;
  } else {
    TBone = {};
  };
  TBone.View = (function() {
    __extends(View, Backbone.View);
    function View() {
      View.__super__.constructor.apply(this, arguments);
    }
    View.prototype.tagName = 'div';
    View.prototype.initialize = function(opts) {
      _.bindAll(this, "render");
      this.parent_el = opts.parent_el;
      return this.model.bind("change", this.render);
    };
    View.prototype.formButtons = function() {
      return {};
    };
    View.prototype.renderForm = function() {
      var fieldsets, out;
      if (_.isFunction(this.form_template)) {
        return this.form_template({
          model: this.model,
          app: App
        });
      } else if (this.form) {
        fieldsets = [];
        if (_.isFunction(this.form)) {
          fieldsets = fieldsets.concat(this.form.apply(this));
        } else {
          fieldsets = fieldsets.concat(this.form);
        }
        out = [];
        _(fieldsets).each(__bind(function(fs) {
          var fields, name;
          name = fs[0], fields = fs[1];
          out.push("<fieldset><legend>" + name + "</legend>");
          _.map(fields, __bind(function(i) {
            var k, v, _ref;
            k = i[0], v = i[1];
            return out.push((_ref = FormHelpers[v[0]]).call.apply(_ref, [this].concat(__slice.call([k, this.model.get(k)].concat(__slice.call(_.rest(v)))))));
          }, this));
          return out.push("</fieldset>");
        }, this));
        return out.join("\n");
      } else {
        return "Not available yet !";
      }
    };
    View.prototype.select = function() {
      return console.log("" + this.model + " Selected !");
    };
    View.prototype.edit = function() {
      window.hope.view.edit_dialog.modelView = this;
      return window.hope.view.edit_dialog.open();
    };
    View.prototype.render = function(tpl_name) {
      var el_id, template, view_data;
      if (tpl_name) {
        template = Hope.Templates[tpl_name];
      }
      if (this.template) {
                if (template != null) {
          template;
        } else {
          template = Hope.Templates["" + (this.className.pluralize()) + "/" + this.template] || Hope.Templates[this.template];
        };
      }
            if (template != null) {
        template;
      } else {
        template = Hope.Templates["" + (this.className.pluralize()) + "/show"] || _.template("Missing template for " + this.className + "(" + this.model.id + ")");
      };
      el_id = "" + ([this.className, (this.template || "show").replace("/", "-")].join("-")) + "-" + this.model.cid;
      if (this.parent_el && $("#" + el_id).length === 0) {
        $(this.parent_el).append($(this.el));
      }
      $(this.el).attr("id", el_id);
      $(this.el).addClass(this.className);
      view_data = {};
      view_data[this.className] = this.model;
      $(this.el).html(template(view_data));
      return this;
    };
    View.prototype.show = function() {
      return $(this.el).show();
    };
    View.prototype.hide = function() {
      return $(this.el).hide();
    };
    return View;
  })();
  Engine = (function() {
    __extends(Engine, Backbone.Model);
    function Engine() {
      Engine.__super__.constructor.apply(this, arguments);
    }
    Engine.prototype.initialize = function() {
      return this.statements = new StatementCollection(this.get("statements") || [], {
        engine: this
      });
    };
    Engine.prototype.addStatement = function(epl, id) {
      return this.statements.create({
        statement_id: id,
        epl: epl
      });
    };
    Engine.prototype.stop = function() {
      return $.post([this.url(), "stop"].join("/"), __bind(function(res) {
        return this.statements.fetch();
      }, this));
    };
    Engine.prototype.start = function() {
      return $.post([this.url(), "start"].join("/"), __bind(function(res) {
        return this.statements.fetch();
      }, this));
    };
    Engine.prototype.subscribe = function(srcName) {
      return $.post([this.url(), "subscribe", srcName].join("/"), __bind(function(res) {
        return this.set(res);
      }, this));
    };
    Engine.prototype.unsubscribe = function(srcName) {
      return $.post([this.url(), "unsubscribe", srcName].join("/"), __bind(function(res) {
        return this.set(res);
      }, this));
    };
    return Engine;
  })();
  Listener = (function() {
    __extends(Listener, Backbone.Model);
    function Listener() {
      Listener.__super__.constructor.apply(this, arguments);
    }
    return Listener;
  })();
  Source = (function() {
    __extends(Source, Backbone.Model);
    function Source() {
      Source.__super__.constructor.apply(this, arguments);
    }
    return Source;
  })();
  Statement = (function() {
    __extends(Statement, Backbone.Model);
    function Statement() {
      Statement.__super__.constructor.apply(this, arguments);
    }
    Statement.prototype.initialize = function() {
      return this.listeners = new ListenerCollection(this.get("listeners") || [], {
        statement: this
      });
    };
    Statement.prototype.stop = function(callback) {
      return $.post([this.url(), "stop"].join("/"), __bind(function(res) {
        this.set(res);
        if (callback) {
          return callback(res);
        }
      }, this));
    };
    Statement.prototype.start = function(callback) {
      return $.post([this.url(), "start"].join("/"), __bind(function(res) {
        this.set(res);
        if (callback) {
          return callback(res);
        }
      }, this));
    };
    Statement.prototype.addListener = function(name) {
      var l;
      l = new Listener({
        name: name
      });
      this.listeners.create(l);
      return l;
    };
    return Statement;
  })();
  EngineCollection = (function() {
    __extends(EngineCollection, Backbone.Collection);
    function EngineCollection() {
      EngineCollection.__super__.constructor.apply(this, arguments);
    }
    EngineCollection.prototype.model = Engine;
    EngineCollection.prototype.url = "/engines";
    return EngineCollection;
  })();
  ListenerCollection = (function() {
    __extends(ListenerCollection, Backbone.Collection);
    function ListenerCollection() {
      ListenerCollection.__super__.constructor.apply(this, arguments);
    }
    ListenerCollection.prototype.model = Listener;
    ListenerCollection.prototype.initialize = function(objs, opts) {
      return this.statement = opts.statement;
    };
    ListenerCollection.prototype.url = function() {
      return [this.statement.url(), "listeners"].join("/");
    };
    return ListenerCollection;
  })();
  SourceCollection = (function() {
    __extends(SourceCollection, Backbone.Collection);
    function SourceCollection() {
      SourceCollection.__super__.constructor.apply(this, arguments);
    }
    SourceCollection.prototype.model = Source;
    SourceCollection.prototype.url = "/sources";
    return SourceCollection;
  })();
  StatementCollection = (function() {
    __extends(StatementCollection, Backbone.Collection);
    function StatementCollection() {
      StatementCollection.__super__.constructor.apply(this, arguments);
    }
    StatementCollection.prototype.model = Statement;
    StatementCollection.prototype.initialize = function(objs, opts) {
      return this.engine = opts.engine;
    };
    StatementCollection.prototype.url = function() {
      return ["engines", this.engine.id, "statements"].join("/");
    };
    return StatementCollection;
  })();
  HopeController = (function() {
    __extends(HopeController, Backbone.Controller);
    function HopeController() {
      HopeController.__super__.constructor.apply(this, arguments);
    }
    HopeController.prototype.initialize = function(opts) {
      return this.app = opts.app;
    };
    HopeController.prototype.routes = {
      "/": "root",
      "/engines/:id": "engine"
    };
    HopeController.prototype.root = function() {
      return console.log("Back to the basics...");
    };
    HopeController.prototype.engine = function(id) {
      return this.app.view.selectEngine(id);
    };
    return HopeController;
  })();
  EngineView = (function() {
    __extends(EngineView, TBone.View);
    function EngineView() {
      this.render = __bind(this.render, this);
      EngineView.__super__.constructor.apply(this, arguments);
    }
    EngineView.prototype.template = "engines/show";
    EngineView.prototype.className = "engine";
    EngineView.prototype.events = {
      "click .newStatement": "newStatement"
    };
    EngineView.prototype.initialize = function(opts) {
      EngineView.__super__.initialize.call(this, opts);
      return this.model.statements.bind("all", this.render);
    };
    EngineView.prototype.render = function() {
      EngineView.__super__.render.call(this);
      return this.model.statements.each(__bind(function(statement) {
        return new StatementListView({
          model: statement,
          parent_el: this.$(".statements_list")
        }).render();
      }, this));
    };
    EngineView.prototype.newStatement = function() {
      var nc;
      nc = new StatementView({
        model: new Statement()
      });
      nc.model.collection = this.model.statements;
      window.hope.view.edit_dialog.modelView = nc;
      return window.hope.view.edit_dialog.open();
    };
    return EngineView;
  })();
  EngineListView = (function() {
    __extends(EngineListView, TBone.View);
    function EngineListView() {
      this.select = __bind(this.select, this);
      EngineListView.__super__.constructor.apply(this, arguments);
    }
    EngineListView.prototype.tagName = "li";
    EngineListView.prototype.className = "engine";
    EngineListView.prototype.template = "engines/list";
    EngineListView.prototype.events = {
      "click": "select"
    };
    EngineListView.prototype.select = function() {
      return window.location.hash = this.model.url();
    };
    return EngineListView;
  })();
  HopeView = (function() {
    __extends(HopeView, Backbone.View);
    function HopeView() {
      this.renderSourcesList = __bind(this.renderSourcesList, this);
      this.renderEnginesList = __bind(this.renderEnginesList, this);
      this.selectEngine = __bind(this.selectEngine, this);
      this.render = __bind(this.render, this);
      HopeView.__super__.constructor.apply(this, arguments);
    }
    HopeView.prototype.template = Hope.Templates['hope'];
    HopeView.prototype.events = {
      "click .logo": "home"
    };
    HopeView.prototype.initialize = function(opts) {
      return this.app = opts.app;
    };
    HopeView.prototype.home = function() {
      window.location.hash = "/";
      return console.log("Going back home...");
    };
    HopeView.prototype.render = function() {
      $(this.el).html(this.template(this.model));
      console.log("App", this.app.engines);
      this.renderEnginesList();
      this.renderSourcesList();
      return this.edit_dialog = new EditDialogView({
        el: $('#dialog'),
        app: this
      });
    };
    HopeView.prototype.selectEngine = function(id) {
      var e;
      this.$(".side .selected").removeClass("selected");
      if (!(e = this.app.engines.get(id))) {
        return;
      }
      this.current_view = new EngineView({
        model: e,
        el: this.$(".current")
      });
      this.current_view.el = this.$(".current");
      this.current_view.render();
      return $("#engine-engines-list-" + e.cid).addClass("selected");
    };
    HopeView.prototype.renderEnginesList = function() {
      this.$("#engines_list").html('');
      return this.app.engines.each(__bind(function(engine) {
        return (new EngineListView({
          model: engine,
          parent_el: this.$("#engines_list")
        })).render();
      }, this));
    };
    HopeView.prototype.renderSourcesList = function() {
      this.$("#sources_list").html('');
      return this.app.sources.each(__bind(function(source) {
        return (new SourceListView({
          model: source,
          parent_el: this.$("#sources_list")
        })).render();
      }, this));
    };
    return HopeView;
  })();
  SourceView = (function() {
    __extends(SourceView, TBone.View);
    function SourceView() {
      SourceView.__super__.constructor.apply(this, arguments);
    }
    SourceView.prototype.template = "sources/show";
    SourceView.prototype.className = "source";
    return SourceView;
  })();
  SourceListView = (function() {
    __extends(SourceListView, TBone.View);
    function SourceListView() {
      this.select = __bind(this.select, this);
      SourceListView.__super__.constructor.apply(this, arguments);
    }
    SourceListView.prototype.tagName = "li";
    SourceListView.prototype.className = "source";
    SourceListView.prototype.template = "sources/list";
    SourceListView.prototype.events = {
      "click": "select"
    };
    SourceListView.prototype.select = function() {
      return window.location.hash = this.model.url();
    };
    return SourceListView;
  })();
  StatementView = (function() {
    __extends(StatementView, TBone.View);
    function StatementView() {
      StatementView.__super__.constructor.apply(this, arguments);
    }
    StatementView.prototype.className = "statement";
    StatementView.prototype.events = {
      'click .edit': 'edit',
      'click .statement-stop': 'stop',
      'click .statement-start': 'start',
      'click .statement-destroy': 'destroy'
    };
    StatementView.prototype.form = function() {
      return [["Statement", [["statement_id", ["text_field", "Name"]], ["epl", ["text_area", "Epl"]]]]];
    };
    StatementView.prototype.stop = function() {
      if (confirm("Sure ?")) {
        return this.model.stop();
      }
    };
    StatementView.prototype.start = function() {
      if (confirm("Sure ?")) {
        return this.model.start();
      }
    };
    StatementView.prototype.destroy = function() {
      if (confirm("Sure ?")) {
        return this.model.destroy();
      }
    };
    return StatementView;
  })();
  StatementListView = (function() {
    __extends(StatementListView, StatementView);
    function StatementListView() {
      StatementListView.__super__.constructor.apply(this, arguments);
    }
    StatementListView.prototype.tagName = "tr";
    StatementListView.prototype.template = "statements/list";
    return StatementListView;
  })();
}).call(this);
