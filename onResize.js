(function() {
  var allResizeCbs, callResizeCbs, observer, resizeHandler, resizeRunning;

  resizeRunning = false;

  allResizeCbs = [];

  resizeHandler = function() {
    if (!resizeRunning) {
      resizeRunning = true;
      if (window.requestAnimationFrame) {
        return window.requestAnimationFrame(callResizeCbs);
      } else {
        return setTimeout(callResizeCbs, 66);
      }
    }
  };

  callResizeCbs = function(e) {
    var cb, i, len;
    for (i = 0, len = allResizeCbs.length; i < len; i++) {
      cb = allResizeCbs[i];
      cb(e);
    }
    return resizeRunning = false;
  };

  window.addEventListener("resize", resizeHandler);

  observer = new MutationObserver(resizeHandler);

  observer.observe(document.body, {
    attributes: true,
    childList: true,
    characterData: true,
    subtree: true
  });

  module.exports = {
    acceptStatement: true,
    disposable: null,
    oldheight: null,
    oldwidth: null,
    bind: function() {
      this.oldheight = this.el.offsetHeight;
      return this.oldwidth = this.el.offsetWidth;
    },
    update: function(fn) {
      var cbwrapper;
      if (typeof this.disposable === "function") {
        this.disposable();
      }
      cbwrapper = (function(_this) {
        return function(e) {
          if (_this.oldheight !== _this.el.offsetHeight || _this.oldwidth !== _this.el.offsetWidth) {
            if ((_this.oldheight !== 0 && _this.oldwidth !== 0) || (_this.el.offsetHeight !== 0 && _this.el.offsetWidth !== 0)) {
              fn(e);
            }
            _this.oldheight = _this.el.offsetHeight;
            return _this.oldwidth = _this.el.offsetWidth;
          }
        };
      })(this);
      allResizeCbs.push(cbwrapper);
      return this.disposable = function() {
        var index;
        index = allResizeCbs.indexOf(cbwrapper);
        if (index > -1) {
          return allResizeCbs.splice(index, 1);
        }
      };
    },
    unbind: function() {
      return typeof this.disposable === "function" ? this.disposable() : void 0;
    }
  };

}).call(this);
