$(document).ready(function(){
    $("#searchBox").keypress(function(){

	if($(this).val().length >= 3 || $(this).val().length <= 0){
	    $.ajax({
		url: '/contacts/search/' + $(this).val(),
		success: function(res){
		    res = JSON.parse(res);
		    $("#cList .table tbody").empty();
		    if(Array.isArray(res)){
			console.log(res);
			res.forEach(function(val,idx,el){
			    var line = " \
<tr data-id=\""+ val.id +"\"> \
<td>"+ val.name  +"</td> \
<td><a href=\""+ val.url +"\" target=\"_blank\">"+val.url+"</a></td> \
<td><span class=\"badge\">"+ val.status +"</span></td> \
<td><a href=\"/contacts/"+val.id+"/delete\" class=\"btn-danger delete btn-sm\"><span class=\"glyphicon glyphicon-remove\" id=\"toggle-full-width\"></span> Delete </a></td> \
</tr> \
";
			    var target = $(line).appendTo("#cList .table tbody");
			});
		    }
			$("#cList .table tbody").on("click","tr", commentBox );
		}
	
	    });
	} 
	
    });
});

function commentBox(){
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


}
