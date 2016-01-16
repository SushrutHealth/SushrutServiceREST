$(function () {

  var Popover = {

    init: function() {

      if (Popover.triggers.length) {

        Popover.triggers
          .popover({
            offset: 10,
            html: true,
            content: function() {
              return $(this).next(".popover-content").clone();
            }
          })
          .click(function(e) {
            e.preventDefault();

            var $this = $(this);

            if ($this.hasClass("triggered")) {
              Popover.hide($this);
            } else {
              Popover.show($this);
            }
          })
          .unbind('mouseenter mouseleave');

        $(document).delegate(".popover", "click", function(e) {
          if ($(e.target).hasClass(".popover")) {
            return false;
          }
        });
      }
    },

    triggers: $("a[rel=popover]"),

    show: function(trigger) {

      trigger.addClass("triggered");

      $(".popover, .triggered").bind("clickoutside", function(e){
        if ($(e.target).parents(".popover").length === 0) {
          trigger.popover('hide').removeClass("triggered");
        }
      });
      trigger.popover('show');
    },

    hide: function(trigger) {
      trigger.popover('hide').removeClass("triggered");
    }
  };

  Popover.init();
});