function formatEpisode(ep){
	return "<div class='episode_item' id=" + ep.id +">" + ep.id + " " + ep.text + "</div>";
}


function setSortAtStart(){
	var order = jQuery("[name='s2_episode_order']").val().split(",");
	// this is the order of ids  ["206", "269", "343", "788", "1017", "1080"]
	var search = jQuery("#s2id_friend_episode_ids .select2-choices .select2-search-field");
	var orderedItems = jQuery.map(order, function(value){
		return jQuery("[id='"+value+"']").parent().parent();
	});
	orderedItems.push(search);
console.log(orderedItems);
	jQuery("#s2id_friend_episode_ids .select2-choices").empty().html(orderedItems);
}



function saveResort(){
	var ids = new Array();
	jQuery(".episode_item").each(
		function(i, el){
			var id = jQuery(el).attr("id");
			ids.push(id);
			console.log(ids);
		}
	);
	jQuery("[name='s2_episode_order']").val(ids);
}

jQuery(document).ready(function(){
	jQuery(".select2").select2();

	jQuery("#friend_episode_ids").select2({
	    formatResult: formatEpisode,
	    formatSelection: formatEpisode,
	    escapeMarkup: function(m) { return m; }
	});


	jQuery("#s2id_friend_episode_ids .select2-choices").sortable({
		cursor: "move",
		stop: function(){
			saveResort();
		},
		change: function(){
			saveResort();
		}
	});


	jQuery("#friend_episode_ids").on("change", function(e){
		saveResort();
	});

	setSortAtStart();
});