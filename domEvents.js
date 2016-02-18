(function() {
  var createEvent;

  createEvent = function(event, params) {
    var ce;
    ce = window.CustomEvent;
    if (ce == null) {
      ce = function(event, opt) {
        var evt;
        opt = opt || {
          bubbles: false,
          cancelable: false,
          detail: void 0
        };
        evt = document.createEvent('CustomEvent');
        evt.initCustomEvent(event, opt.bubbles, opt.cancelable, opt.detail);
        return evt;
      };
      ce.prototype = window.Event.prototype;
    }
    return new ce(event, params);
  };

  module.exports = {
    priority: 600,
    bind: function() {
      return this.el.dispatchEvent(createEvent("enter"));
    },
    unbind: function() {
      return this.el.dispatchEvent(createEvent("leave"));
    }
  };

}).call(this);
