$("[data-episode]").each(function(){
    $.ajax({
        type : 'POST',
      url : '/refresh',
      data: {id: $(this).attr("data-episode")}
    })
});