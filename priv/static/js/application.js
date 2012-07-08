var web_socket;

$(document).ready(function() {
  web_socket = prepareSocket("ws://192.168.1.12:8080/websocket");
  fieldFactory($('#game_field'), 40); 
});

function fieldFactory(parent_div, size) {
  for (var i = 0; i < size; i++) {
    row = $('<div />', { id:'row_' + i.toString(), class: 'row'});
    row.appendTo(parent_div);
    for (var j = 0; j < size; j++) {
      cell = $('<div />', { 
        id: 'cell_' + i.toString() + '_' + j.toString(), 
        class:'cell column_' + j.toString(),xcoord: i,ycoord:j
      });
   
      cell.appendTo(row);
  
      img = $('<div />', { class: 'image-unknown' });
  
      img.bind('click', function() {
        hitBlock($(this).parent().attr('xcoord'), $(this).parent().attr('ycoord'));
        sendCommandToSocket("clicked on:" + $(this).parent().attr('xcoord') + ',' + $(this).parent().attr('ycoord') + '.');
      });

      img.appendTo(cell);
    }
  }
}

function sendCommandToSocket(command) {
  if (web_socket) {
    web_socket.send(command);
  }
}

function showStatus(text) {
  $("#socket_output").html(text);
}

function prepareSocket(address) {
  if ("WebSocket" in window) {
    var ws = new WebSocket(address);
    
    ws.onopen = function() {
      showStatus("websocket connected!");
    };

    ws.onmessage = function(evt) {
      var receivedMsg = evt.data;
      msg = $.parseJSON(receivedMsg);
      hitBlock(msg.x, msg.y);
      showStatus("got message:" + msg);
    };

    ws.onclose = function() {
      showStatus("websocket closed");
    };

    return ws;
  }
}

function hitBlock(x, y) {
  var cell = $("#cell_" + x + "_" + y).children();
  if (cell.hasClass("image-empty")) {
    cell.removeClass("image-empty");
    cell.addClass("image-unknown");
  } else if (cell.hasClass("image-unknown")) {
    cell.removeClass("image-unknown");
    cell.addClass("image-empty");
  }
}