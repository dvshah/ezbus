$(document).ready(function(){
    $("#form").submit(function(){
    	var i = 0;
    	var todo=[];
        $('#form input:text, textarea').each(function() {
            //window.alert($(this).val());
            todo[i] = $(this).val();
            i++;
        });
        var check = {};
        check = {username: todo[0], password: todo[1]};
        $.ajax({
	        type: 'POST',
	        url: '/',
	        data: todo,
	        //window.alert(data.username);
	        success: function(data){
	          //do something with the data via front-end framework
	          location.reload();
	        }
      	});

        return false;
    });
});