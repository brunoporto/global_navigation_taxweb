//= require_self
(function() {
  this.GlobalNavigation = function() {
    this.container = null;
    this.closeButton = null;
    this.openButton = null;
    this.floatMenuButtons = null;
    this.init = function() {
      // build elements
      this.container = document.getElementById("global-navigation");
      this.closeButton = document.getElementById(
        "navigation-resize-button-close"
      );
      this.openButton = document.getElementById(
        "navigation-resize-button-open"
      );
      this.floatMenuButtons = document.querySelectorAll(
        ".navigation-dropdown .navigation-item-link"
      );
      // attach events
      var that = this;
      if (this.closeButton) {
        this.closeButton.addEventListener("click", function(ev) {
          that.close(ev);
        });
      }
      if (this.openButton) {
        this.openButton.addEventListener("click", function(ev) {
          that.open(ev);
        });
      }
      if (this.floatMenuButtons) {
        for (const floatMenuButton of this.floatMenuButtons) {
          floatMenuButton.addEventListener("click", function(ev) {
            that.openFloatMenu(ev);
          });
        }
      }
    };

    this.toggle = function(_ev) {
      if (this.container) {
        var element = this.container;
        toggleClass(element, "closed");
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
      var navigationElement = element.querySelector(
        ".content-navigation-wrapper"
      );
      navigationElement.style.width = "20px";
      window.setTimeout(function() {
        navigationElement.style.width = null;
      }, 300);
      if (arr.indexOf("closed") == -1) {
        element.className += " " + "closed";
      }
    };

    this.openFloatMenu = function(ev) {
      ev.preventDefault();
      var element = getClosest(ev.target, ".navigation-dropdown");
      posDropDown(element);
      toggleClass(element, "dropdown-show");
    };

    function toggleClass(elem, klass) {
      if (elem.classList) {
        elem.classList.toggle(klass);
      } else {
        // For IE9
        var classes = elem.className.split(" ");
        var i = classes.indexOf(klass);
        if (i >= 0) classes.splice(i, 1);
        else classes.push(klass);
        elem.className = classes.join(" ");
      }
    }

    function posDropDown(elem) {
      var dropdownContainer = elem.getElementsByClassName(
        "navigation-dropdown-container"
      )[0];
      var y =
        elem.offsetTop - dropdownContainer.offsetHeight + elem.offsetHeight;
      if (y <= 0) {
        y = elem.offsetTop;
      }
      dropdownContainer.style.transform = "translate3d(60px, " + y + "px, 0px)";
    }

    function getClosest(elem, selector) {
      for (; elem && elem !== document; elem = elem.parentNode) {
        if (elem.matches(selector)) return elem;
      }
      return null;
    }
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
