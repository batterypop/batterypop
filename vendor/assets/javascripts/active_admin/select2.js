// function formatSelect(state){
// 	console.log(state);
// 	return "<div style='width: 100%;'>" + state.text + "</div>";
// }

// jQuery(document).ready(function(){
// 	// jQuery(".select2").select2({
// 	//     formatResult: formatSelect,
// 	//     formatSelection: formatSelect,
// 	//     escapeMarkup: function(m) { return m; }
// 	// });
	
// 	// jQuery("#s2_episode_hidden").select2({tags:["red", "green", "blue", "orange", "white", "black", "purple", "cyan", "teal"]});
	
// 	jQuery(".select2").select2();
// 	jQuery("#s2_episode_hidden").select2("container").find("ul.select2-choices").sortable({
// 	    containment: 'parent',
// 	    start: function() { $("#s2_episode_hidden").select2("onSortStart"); },
// 	    update: function() { $("#s2_episode_hidden").select2("onSortEnd"); }
// 	});
	
// });



// (function($){
//     $.fn.extend({
//         select2_sortable: function(){ 
//             var select = $(this); console.log(select);
//            select.select2();
//             // var ul = $(select).prev('.select2-container').first('ul');
//             // alert(ul);
//             // ul.sortable();
//         }
//     });

//     $('#friend_episode_ids').select2_sortable();
// }(jQuery));


// jQuery(document).ready(function(){
// 	jQuery(".select2").select2();
// 	// jQuery(".select2-search-choice").sortable({
// 	jQuery(".select2-choices").sortable({
// 		// containment: 'parent',
// 		cursor: "move",
// 		forcePlaceholderSize: true
//   //       items       : 'li:not(.select2-search-field)',
//   //       tolerance   : 'pointer',
//         // stop: function() {
//         //     refresh(select,ul);
//         // }
// 	});
// 	// jQuery("#friend_episode_ids").prev('.select2-container').first('ul.select2-choices').sortable();

// });

function saveSort(){
	alert("wee savesort called");
	$.ajax({
		url:"/admin/friends/sort",
		type: 'post',
		data: "JUST A TEST",
		success:function(result){
			alert("saved");
		}
	});
}

jQuery(document).ready(function(){
	jQuery(".select2").select2();
	jQuery(".select2-choices").sortable({
		cursor: "move",
		stop: function(){
			// alert("stop");
		},
		change: function(){
			// alert('change');
		}

	});

	jQuery("#friend_episodes_input .select2").on("change", function(e){
		// alert(console.log(e));
		saveSort(e);
	})

});