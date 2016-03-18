var $ = require('jquery');
var Vue = require('vue');

$(() => {
  if ( $('body').is('.pages') ){
    var mypage =  new Vue({
      'el': $("#mypage").get(0),
      'data': {
        'showModal': false,
        'book':{},
        'comments':[]
      },
      'created': function(){
        console.log('vue is initialized...');
      },
      'methods': {
        'showBook': function(id){
          console.log('shoooooow', this.showModal);
          console.log(this);
          this.showModal = true;
          this.getBook(id).done((data)=>{
            console.log(data);
            this.book = data.result.book;
            this.comments = data.result.comments;
          }).fail((data)=>{
            alert('エラーが起きました。存在しない書籍です。');
          })
        },
        'getBook': function(id){
          console.log('/api/v1/books/' + String(id));
          return $.ajax({
            'type': 'GET',
            'url': '/api/v1/books/' + String(id),
            'dataType': 'json',
          });
        }
      },
    })

  }
});
