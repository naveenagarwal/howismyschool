$.fn.collapseCustom = function(options) {
	var defaults = {
		closed : false
	}
	settings = $.extend({}, defaults, options);

	return this.each(function() {
		var obj = $(this);
		obj.find("legend").addClass('collapsible').click(function() {
			if (obj.hasClass('collapsed')){
				obj.removeClass('collapsed').addClass('collapsible');
				obj.find("legend").addClass('collapsible').removeClass('collapsed');
				obj.children().filter("p,img,table,ul,div,span,h1,h2,h3,h4,h5,form").show('slow');
			}else{
				obj.removeClass('collapsible').addClass('collapsed').find("legend").addClass('collapsed');
				obj.children().filter("p,img,table,ul,div,span,h1,h2,h3,h4,h5,form").hide('slow');
			}
	
		});
		if (settings.closed) {
			obj.addClass('collapsed').removeClass('startClosed').find("legend").addClass('collapsed');
			obj.children().filter("p,img,table,ul,div,span,h1,h2,h3,h4,h5").css('display', 'none');
		}
	});
};
