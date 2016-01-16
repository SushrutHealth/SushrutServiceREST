$(function() {

  var Flash = {

    init: function() {

      Flash.dom.delay(2500).animate({opacity:0}, function() {
        Flash.callbacks.hide();
      });

      Flash.dom.find('a.close').click(function(e){
        Flash.dom.clearQueue().animate({opacity:0}, function() {
          Flash.callbacks.hide();
        });
        e.preventDefault();
      });
    },

    dom: $(".alert-message.flash"),

    callbacks: {

      hide: function() {
        Flash.dom.slideUp("slow", function() {
          $(this).remove();
        });
      }
    }
  };

  Flash.init();
});
