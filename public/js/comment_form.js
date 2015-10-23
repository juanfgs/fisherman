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
		$('#currentContact [data-contact=created_by]').text(res.user.name);		
		$('#currentContact [data-contact=created_at]').text(res.created_at);
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
    
    var hash = window.location.hash;
    $(hash).trigger("click");
    
});

