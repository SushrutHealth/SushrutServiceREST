var Prngs = {

  init: function() {
    Prngs.pjax.init();
    Prngs.polyfills.init();
  },

  appName: "prngs",

  opts: {

    spinner: { lines: 10, // The number of lines to draw
               length: 3, // The length of each line
               width: 2, // The line thickness
               radius: 3, // The radius of the inner circle
               color: '#0064CD', // #rgb or #rrggbb
               speed: 1.3, // Rounds per second
               trail: 70, // Afterglow percentage
               shadow: false // Whether to render a shadow
             }
  },

  fitvids: function() {
    $("[data-fitvids]").fitVids();
  },

  pjax: {

    init: function() {

      Prngs.pjax.loader.hide();

      $(".span12.main").live('start.pjax', function() {
        Prngs.pjax.loader.show();
      });

      $(".span12.main").live('end.pjax', function(xhr, options) {
        $("body").attr("class", options.getResponseHeader('X-PJAX-CONTEXT'));
        Prngs.pjax.loader.hide();
      });
    },

    loader: {

      variation: function() {
        var variations = $("#levitator, #cheerloader");
        return variations[Math.floor(Math.random()*variations.length)]
      },

      show: function() {
        $('input[data-autocomplete]').trigger("blur");
        $("#loader_mask").addClass("show").addClass("transition");
        $(Prngs.pjax.loader.variation())
          .css("top", $("body").scrollTop() + (0.35 * $(window).height()))
          .show();
      },

      hide: function() {
        $("#loader_mask").removeClass("transition");
        setTimeout(function() {
          $("#loader_mask").removeClass("show");
        }, 300);
        $(".pjax-loader").hide();
      }
    }
  },

  polyfills: {

    init: function() {
      Prngs.polyfills.inputs();
      Prngs.polyfills.text_overflow();
    },

    inputs: function() {
      $.html5support();
    },

    text_overflow: function() {
      $("[data-ellipsis]").ellipsis();
    }
  }
}

$(function() {
  Prngs.init();
});
