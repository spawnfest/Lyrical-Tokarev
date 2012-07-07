$(document).ready(function() {
  fieldFactory($('#game_field'), 10);
});

function fieldFactory(parent_div, size){
for (var i = 0; i < size; i++){
row = $('<div />', {id:'row_'+i.toString(), class: 'row'});
row.appendTo(parent_div);
 for (var j = 0; j < size; j++) {
    $('<div />', { id: 'cell_' + i.toString() + '_' + j.toString(), 
  class:'cell column_' + j.toString()
  }).appendTo(row);
}
}
 
}