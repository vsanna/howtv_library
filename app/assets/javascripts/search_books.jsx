var $ = require('jquery');
var Vue = require('vue');

var BookViewer = Vue.extend({
  'props': ['bookId'], // templateではkebabスタイルでbook-idと記述
  'data': function(){
    return {
      'book':{},
      'comments':[]
    }
  },
  'created': function(){},
  'methods' : {
    'showBook': function(){
      this.book = {}; // clear
      this.getBook(this.bookId).done((data)=>{
        this.book = data.result.book;
        this.comments = data.result.comments;
      }).fail(()=>{
        alert('エラーが起きました。存在しない書籍です。');
      })
    },
    'getBook': function(id){
      return $.ajax({
        'type': 'GET',
        'url': '/api/v1/books/' + String(id),
        'dataType': 'json',
      });
    },
    'toggleModal': function(){
      this.$dispatch('toggle-modal');
    }
  },
  'events':{
    'get-book': function(){
      this.showBook();
    }
  }
});

module.exports = BookViewer;
