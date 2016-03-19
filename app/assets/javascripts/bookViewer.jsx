var $ = require('jquery');
var Vue = require('vue');

var BookViewer = Vue.extend({
  'data': function(){
    return {
      'book':{},
      'comments':[],
      'showViewer': false,
    }
  },
  'created': function(){},
  'methods' : {
    'toggleModal': function(){
      this.showViewer = false;
      this.$dispatch('hide-modal');
    },
    'showBook': function(id){
      this.showViewer = true;
      this.book = {}; // clear
      this.getBook(id).done((data)=>{
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
  },
  'events':{
    'get-book': function(id){
      this.showBook(id);
    }
  }
});

module.exports = BookViewer;
