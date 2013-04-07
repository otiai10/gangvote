$(function(){///////////
  $("a.delete-player").on('click',function(e){
    if(confirm('この選手を削除しますか？')){
      // follow href bevavior
    }else{
      e.preventDefault();
    }
  });
});/////////////////////
