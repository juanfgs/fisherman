$(document).ready(function(){

    $('.contact').click(function(){
	$.ajax({
	    url: '/contacts/' + $(this).attr('data-id'),
	    success:function(res){
		
		var res = JSON.parse(res);
		console.log(res);
		$('#currentContact [data-contact=name]').text(res.contact.name);
		$('#currentContact [data-contact=description]').text(res.contact.description);
		$('#currentContact [data-contact=status]').text(res.contact.status);
		$('#currentContact [data-contact=url]').text(res.contact.url);
		$('#currentContact [data-contact=created_at]').text(res.contact.created_at);
		$('#commentForm [name=contact_id]').val(res.contact.id);
		$("#commentList .panel-body").empty();
		res.comments.forEach(function(value,idx){
		    $("#commentList .panel-body").append('<div class="media"><div class="media-left"></div><div class="media-body">' +value.comment +'</div></div><hr/>');
		});
	    }
	});

	
	if( !$('#cBox').is(":visible") ){
	    $('#contacts .col-md-12').addClass('col-md-8').removeClass('col-md-12');;
	    $('#cBox').fadeIn();
	}

	
    });
    
});

