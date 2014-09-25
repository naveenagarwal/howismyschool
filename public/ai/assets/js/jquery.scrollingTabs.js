/**
*	This plugin will extend the JQuery ui tabs function so that it adds
*	the ability to allow for scrolling on the tabs.
*
*   @Author			William Gaines <sgscot87@gmail.com>
*   @Copyright		2013-2014
*   @Version		1.0
*	@Namespace		ui
*	@Plugin Name	tabs
*
*/

(function ($) {

    // References to base methods
    var base = {
        _create: $.ui.tabs.prototype._create,
        refresh: $.ui.tabs.prototype.refresh,
        _toggle: $.ui.tabs.prototype._toggle
    };
	
	// Make some varibles to be used
	var settings = {
		scrolling: false,
		bar_width: 0
	};
	
    // Extend the 'tabs' widget
    $.extend(true, $.ui.tabs.prototype, {

        // Default values for options
        options: {
            scrollable: false,
            scrollSpeed: 40,
			scrollToActive: true,
			easing: 'linear',
			duration: 250,
			leftButton: $('<button id="left_button" href="#"  class="ui-tabs-left-button"><span class="ui-icon ui-icon-triangle-1-w" style="display:inline-block;"></span></button>'),
			rightButton: $('<button id="right_button" href="#" class="ui-tabs-right-button"><span class="ui-icon ui-icon-triangle-1-e" style="display:inline-block;"></span></button>'),
			sorting: false
        },

        // Constructor (overrides base)
        _create: function () {
			
			// Setup some helpers
			var that = this,
				name = this.name;
			
			// Call the base create function
            base._create.apply(that, arguments);
			
			// Check to see if the scrollable varible has been set to true
			if(that.options.scrollable) {
				
				// Make the tabs, buttons and background container. This will hold the tabs container, the leftand right buttons, and the background to the title bar.
				// The background will be remove from the ul tag a little later in this script. We are going to put this div into the main tabs div
				var bar_container = $('<div id="bar_container" class="ui-tabs-bar-container ui-widget-header ui-corner-all"></div>').prependTo(that.element);
				
				// Make the tabs container. This will only hold the ul tag for the tabs. We are going to add this div to the bar_container div
				this.header = $('<div id="tabs_container" class="ui-tabs-tabs-container"></div>').prependTo(bar_container);
				
				// Get a hold on the ul tag and reomve the corners and the background classes and move the tag into the header div
				var nav = that.element.find(".ui-tabs-nav:first").removeClass("ui-widget-header ui-corner-all").appendTo(that.header);
				
				// Make the left and the right buttons and add them in the the bar_container div
				var left_button  = that.options.leftButton.prependTo(bar_container);
				var right_button = that.options.rightButton.prependTo(bar_container);
				
				// Turn the "A" tag into a button and create the mouse down functionality. We are also going to disable the button sinc this is on the startup.
				left_button.button().bind('mousedown.' + name, function(event) {
							  
					// Stop Default behavior of the "A" tag
					event.preventDefault();
					
					// Set the scrolling setting to true
					settings.scrolling = true;
					
					// Start scrolling the tabs. The second param is true telling us we are scrolling left
					that.move_bar($("#tabs_container"), true, that);
					
				// We are releasing the mouse button so lets do own release actions here
				}).mouseup(function(){
					
					// Set the scrolling setting to false to stop the scrolling
					settings.scrolling = false;
					
				}).attr("disabled", "disabled").addClass("ui-state-disabled");
				
				// Turn the "A" tag into a button and create the mouse down functionality 
				right_button.button().bind('mousedown.' + name, function(event) {
							  
					// Stop Default behavior of the "A" tag
					event.preventDefault();
					
					// Set the scrolling setting to true
					settings.scrolling = true;
					
					// Start scrolling the tabs. The second param is false telling us we are scrolling right
					that.move_bar($("#tabs_container"), false, that);
					
				// We are releasing the mouse button so lets do own release actions here
				}).mouseup(function(){
					
					// Set the scrolling setting to false to stop the scrolling
					settings.scrolling = false;
					
				});
				
				// Setup the ul bars width
				that.element.find(".ui-tabs-nav:first").width(that._get_bar_width());
				
				// Setup the window on resize function
				$(window).resize(function() {
					
					// Run a refresh
					that.refresh();
					
				});
				
			}
			
        },
		
		refresh: function () {
			
			// Setup some helpers
			var that = this,
				name = this.name;
			
			// Call the base create function
            base.refresh.apply(that, arguments);
			
			// Setup the ul bars width
			that.element.find(".ui-tabs-nav:first").width(that._get_bar_width());
			
			// Get a hold on the ul tag and reomve the corners and the background classes
			var nav = that.element.find(".ui-tabs-nav:first").removeClass("ui-widget-header ui-corner-all");
			
			// Disable the buttons
			that._disable_buttons($("#tabs_container"));
			
		},
		
		_toggle: function() {
			
			// Setup some helpers
			var that = this,
				name = this.name;
			
			// Call the base create function
            base._toggle.apply(that, arguments);
			
			// Check to see if we are sorting 
			if(that.options.sorting) {
				
				// We are sorting and have dropped the tab into its new positon so set
				// sorting to false
				that.options.sorting = false;
				
				// Set the scroll to active to false since it gose kinda crazy 
				that.options.scrollToActive = false;
				
			}
			
			// Check to see if we need to extend the LI on click functions
			if(that.options.scrollToActive) {
				
				// Setup some varibles to help us out 
				var position = 0,
					width,
					found = false
					element = $("#tabs_container");
				
				// Loop through the UL LI tags
				this.element.find(".ui-tabs-nav:first li").each(function() {
					
					// Make sure we haven't found anything yet
					if(!found) {
						
						// Check to see if the LI has the active class
						if($(this).hasClass("ui-tabs-active")) {
							
							// Set the found flag to true
							found = true;
							
							// Get the width of the tab
							width = $(this).outerWidth(true);
							
						}
							
						// Add the outWidth of the LI to the position varible
						position += $(this).outerWidth(true);
					
					}
					
				});
				// OK ... This statement figures out what side the tab is hiding under so we know how to pop it out 
				if((position > (element.scrollLeft() + element.width()))) {
					
					// We are at the right side so remove the tabs container width
					position = position - element.width();
					
				} else {
					
					// Weare on the left side so remove the width of the tab
					position = position - width;
					
				}
				//that._disable_buttons(element);
				// Start the scrolling
              
				element.animate({ scrollLeft : position }, {queue: true, easing: that.options.easing, duration: that.options.duration, complete: function(){
						
						// Disable the buttons
						that._disable_buttons(element);
																																																									  					}
				
				});
				
			}
			
		},
	
		// This function will be used to scroll the the tabs.
		move_bar: function(element, left, that) {
			
			// Check to see if we are going to scroll left
			if(left) {
				
				// Check to see if the scroll left is greater than 0
				if(element.scrollLeft() > 0) {
				
					// Start the scrolling
					element.animate({ scrollLeft : "-=" + that.options.scrollSpeed }, {queue: true, easing: that.options.easing, duration: that.options.duration, complete: function(){
						
						// Check to see if we are currenly scrolling
						if(settings.scrolling) {
							
							// We are still scrolling so call the function again
							that.move_bar(element, left, that);
							
						}
						
						// Disable the buttons
						that._disable_buttons(element);
						
					}});
				
				} else {
					
					// Disable the buttons
					that._disable_buttons(element);
					
				}
				
			} else {
				
				// Check to see if the Scroll if at the max
				if((element.width() - 1 + element.scrollLeft()) < element[0].scrollWidth) {
				
					// Start the scrolling
					element.animate({ scrollLeft : "+=" + that.options.scrollSpeed }, {queue: true, easing: that.options.easing, duration: that.options.duration, complete: function(){
						
						// Check to see if we are currenly scrolling
						if(settings.scrolling) {
							
							// We are still scrolling so call the function again
							that.move_bar(element, left, that);
							
						}
						
						// Disable the buttons
						that._disable_buttons(element);
						
					}});
				
				} else {
					
					// Disable the buttons
					that._disable_buttons(element);
					
				}
			
			}
			
		},
		
		// This function will diable the arrows buttons if needed
		_disable_buttons: function(element) {
			
			// Remove the disabled states
			$("#left_button").removeAttr("disabled").removeClass("ui-state-disabled");
			$("#right_button").removeAttr("disabled").removeClass("ui-state-disabled");
			
			// Check to see if we are at the begining of the scrolling element
			if(element.scrollLeft() == 0) {
				
				// Set to the max scroll
				element.scrollLeft(0);
				
				// Disable the left button
				$("#left_button").attr("disabled", "disabled").addClass("ui-state-disabled");
					
			} 
			
			// Check to see if we are at the end of the scrolling element
			if((element.width() - 1 + element.scrollLeft()) >= element[0].scrollWidth) {
				
				// Set to the max scroll
				element.scrollLeft(element[0].scrollWidth);
				
				// Disable the right button
				$("#right_button").attr("disabled", "disabled").addClass("ui-state-disabled");
				
			}
			
			// Check to see if there is even an ability to scroll
			if(element.width() == element[0].scrollWidth) {
				
				// Disable the left and right button
				$("#left_button").attr("disabled", "disabled").addClass("ui-state-disabled");
				$("#right_button").attr("disabled", "disabled").addClass("ui-state-disabled");
				
			}
			
		},
		
		// This function will set the ULs width
		_get_bar_width: function() {
			
			// Rest the bar width
			settings.bar_width = 0;
			
			// Loop through the UL LI tags
			this.element.find(".ui-tabs-nav:first li").each(function() {
				
				// Add the outWidth of the LI to the bar_width varible
				settings.bar_width += $(this).outerWidth(true) + 16;
				
			});
			
			// This line fixes any wrpping issue that are caused by the first two tabs
			settings.bar_width = (settings.bar_width < $('#tabs_container').width() - 5) ? $('#tabs_container').width() - 5 : settings.bar_width;
			
			// Return the width
			return settings.bar_width;
			
		}
		
    });

})(jQuery);


// For the sortable aspects of this script we needed to add to the scrollParent function and
// add the ability to make the parent from a overflow hidden object
$.fn.extend({
			
	scrollParent: function() {
		var scrollParent;
		if (($.ui.ie && (/(static|relative)/).test(this.css('position'))) || (/absolute/).test(this.css('position'))) {
			scrollParent = this.parents().filter(function() {
				return (/(relative|absolute|fixed)/).test($.css(this,'position')) && (/(auto|scroll|hidden)/).test($.css(this,'overflow')+$.css(this,'overflow-y')+$.css(this,'overflow-x'));
			}).eq(0);
		} else {
			scrollParent = this.parents().filter(function() {
				return (/(auto|scroll|hidden)/).test($.css(this,'overflow')+$.css(this,'overflow-y')+$.css(this,'overflow-x'));
			}).eq(0);
		}

		return (/fixed/).test(this.css('position')) || !scrollParent.length ? $(document) : scrollParent;
	}
	
});