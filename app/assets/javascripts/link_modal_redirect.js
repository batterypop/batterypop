$(document).ready(function(){

	$('a[href]').not('a[href*="batterypop.com"], a[href="#"], a[href^="/"], a[href="https://plus.google.com/111613426507812683994"]').each(function(){
	    var url = $(this).attr('href');
		// alert(url);
		$(this).attr("data-toggle", "modal");
		$(this).attr("data-target", "#modalLinkJump");
		$(this).attr("data-url", url);
		$(this).click(function() {
		  $('#btnYes').attr('data-url', url);
		  $('#modalLinkJump').find('.modal-body').html("<h2>You're about leave us to visit another website: <br /><small>" + url + ".</small></h2><p>Are you sure you want to leave batteryPOP? (You can always come back!)</p>");
		  $(this).preventDefault();
		});
		// $(this).preventDefault();
	});

	$('#btnYes').click(function(){
		// window.location.href = $(this).attr("data-url");
		var url = $(this).attr("data-url");
		window.open($(this).attr("data-url"), '_new');
	});

});