var web_socket;
$(document).ready(function() {
  web_socket = prepareSocket("ws://192.168.1.12:8080/websocket");
  fieldFactory($('#game_field'), 10); 
});

function fieldFactory(parent_div, size){
for (var i = 0; i < size; i++){
row = $('<div />', {id:'row_'+i.toString(), class: 'row'});
row.appendTo(parent_div);
 for (var j = 0; j < size; j++) {
    cell = $('<div />', { id: 'cell_' + i.toString() + '_' + j.toString(), 
  class:'cell column_' + j.toString(),xcoord: i,ycoord:j
  });
  cell.appendTo(row);
  
  img = $('<div />',{class: 'image-unknown'
					  });
  img.bind('click', function(){
					  $(this).clearStyle;
					  $(this).attr('class', 'image-empty');
					  sendCommandToSocket("clicked on:"+$(this).parent().attr('xcoord')+','+$(this).parent().attr('ycoord')+'.');
					  });
  img.appendTo(cell);
}
}

}

function sendCommandToSocket(command){
if (web_socket){
  web_socket.send(command);
  }
}

function showStatus(text){
		$("#socket_output").html(text);

}
function prepareSocket(address){
  if ("WebSocket" in window){
	  var ws = new WebSocket(address);
	  ws.onopen = function(){
		showStatus("websocket connected!");
	  };
	  ws.onmessage= function(evt){
		 var receivedMsg = evt.data;
		showStatus("got message:"+receivedMsg);
		};
	  ws.onclose = function(){
	   showStatus("websocket closed");
	  };
	  return ws;
  }
}