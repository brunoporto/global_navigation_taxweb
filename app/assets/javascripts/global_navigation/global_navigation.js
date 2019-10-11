//= require_self
(function() {
  this.GlobalNavigation = function() {
    this.container = null;
    this.closeButton = null;
    this.openButton = null;
    this.init = function() {
      // build elements
      this.container = document.getElementById("global-navigation");
      this.closeButton = document.getElementById(
        "navigation-resize-button-close"
      );
      this.openButton = document.getElementById(
        "navigation-resize-button-open"
      );
      // attach events
      var that = this;
      this.closeButton.addEventListener("click", function(ev) {
        that.close(ev);
      });
      this.openButton.addEventListener("click", function(ev) {
        that.open(ev);
      });
    };

    this.toggle = function(_ev) {
      if (this.container) {
        var element = this.container;
        if (element.classList) {
          element.classList.toggle("closed");
        } else {
          // For IE9
          var classes = element.className.split(" ");
          var i = classes.indexOf("closed");
          if (i >= 0) classes.splice(i, 1);
          else classes.push("closed");
          element.className = classes.join(" ");
        }
      }
    };

    this.open = function(_ev) {
      if (this.container) {
        var element = this.container;
        element.className = element.className.replace(/\bclosed\b/g, "");
      }
    };

    this.close = function(_ev) {
      var element = this.container;
      var arr = element.className.split(" ");
      if (arr.indexOf("closed") == -1) {
        element.className += " " + "closed";
      }
    };
  };
})();

function globalNavigationInit() {
  var globalNavigation = new GlobalNavigation();
  globalNavigation.init();
}

if (window.attachEvent) {
  window.attachEvent("onload", globalNavigationInit);
} else {
  if (window.onload) {
    var curronload = window.onload;
    var newonload = function(evt) {
      curronload(evt);
      globalNavigationInit(evt);
    };
    window.onload = newonload;
  } else {
    window.onload = globalNavigationInit;
  }
}
