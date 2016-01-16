$.widget( "custom.catcomplete", $.ui.autocomplete, {

  _response: function( content ) {
    this._trigger( "complete" );
		if ( !this.options.disabled && content && content.length ) {
			content = this._normalize( content );
			this._suggest( content );
			this._trigger( "open" );
		} else {
			this.close();
		}
		this.pending--;
		if ( !this.pending ) {
			this.element.removeClass( "ui-autocomplete-loading" );
		}
	},

  _renderMenu: function( ul, items ) {
    var self = this,
        currentCategory = "",
        catCount = 0;
    $.each( items, function( index, item ) {
      if (item.hasOwnProperty('category')) {
        if ( item.category != currentCategory ) {
          if (catCount === 0) {
            ul.append( "<li class='ui-autocomplete-category first'>" + item.category + "</li>" );
          } else {
            ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
          }
          currentCategory = item.category;
          catCount += 1;
        }
      }
      self._renderItem( ul, item );
    });
  },

  _renderItem: function( ul, item) {
    if (item.hasOwnProperty('link')) {
      return $( "<li class='ui-autocomplete-link'></li>" )
        .data( "item.autocomplete", item )
        .html( item.link )
        .appendTo( ul );
    } else if (item.hasOwnProperty('nothing')) {
      return $( "<li class='ui-autocomplete-nothing'></li>" )
        .data( "item.autocomplete", item )
        .html( item.nothing )
        .appendTo( ul );
    } else if (item.hasOwnProperty('url')) {
      return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( $( "<a href='" + item.url + "'></a>" ).text( item.label ) )
        .appendTo( ul );
    } else {
      return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( $( "<a></a>" ).text( item.label ) )
        .appendTo( ul );
    }
  }
});

$(document).ready(function(){
  (function() {
    var $input = $('input[data-autocomplete]'),
        $primarySearch = $("#primary_search");

    $input.catcomplete({
      source: $input.attr('data-autocomplete'),
      create: function() {
        $input.focus();
      },
      search: function() {
        $primarySearch.find(".loading").spin(Prngs.opts.spinner);
      },
      complete: function() {
        $primarySearch.find(".loading").spin(false);
      },
      select: function(event, ui) {
        if (ui.item.hasOwnProperty('link')) {
          $input.parents("form").submit();
        }
      },
      html: true,
      minLength: 2
    });
  })();
});
