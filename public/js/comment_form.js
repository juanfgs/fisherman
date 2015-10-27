$(document).ready(function(){
    


    
    $('.contact').click(function(){
	$.ajax({
	    url: '/contacts/' + $(this).attr('data-id'),
	    success:function(res){
		var res = JSON.parse(res);
		window.location.hash = 'contact-' + res.id;
		$('#currentContact [data-contact=name]').text(res.name);
		$('#currentContact [data-contact=description]').text(res.description);
		$('#currentContact [data-contact=status] select').val(res.status);
		$('#currentContact [data-contact=url]').text(res.url);
		$('#currentContact [data-contact=id]').val(res.id);		
		$('#currentContact [data-contact=created_by]').text(res.user.name);		
		$('#currentContact [data-contact=created_at]').text(moment(res.created_at).format('MMMM Do YYYY, hh:mm:ss'));
		$('#commentForm [name=contact_id]').val(res.id);
		$("#commentList .panel-body .list").empty();
		res.comments.forEach(function(value,idx){
		    $("#commentList .panel-body .list").append('<div class="media"><div class="media-left">'+value.user.name+'</div><div class="media-body">' +value.comment +'</div></div><hr/>');
		});


	    }
	});

	
	if( !$('#cBox').is(":visible") ){
	    $('#contacts .col-md-12').addClass('col-md-8').removeClass('col-md-12');;
	    $('#cBox').fadeIn();
	}

    });

    $(document).on('click', '#toggle-full-width', function(){
	if($("#cList").is(":visible")){
	    $("#cBox").removeClass("col-md-4");
	    $(this).removeClass("glyphicon-fullscreen");
	    $(this).addClass("glyphicon-arrow-right");
	    $("#cBox").addClass("col-md-12");
	    $("#cList").hide();
	} else {
	    $("#cBox").addClass("col-md-4");
	    $(this).addClass("glyphicon-fullscreen");
	    $(this).removeClass("glyphicon-arrow-right");	    
	    $("#cBox").removeClass("col-md-12");
	    $("#cList").show();
	}
    });		
    
    $("[data-contact=status]").change(function(){
	$.ajax({
	    url: '/contacts/' + $('[data-contact=id]').val() + '/edit',
	    method: 'POST',
	    data: {status: $("[name=status]").val() }
	});
    });
    
    var hash = window.location.hash;
    $(hash).trigger("click");

});

