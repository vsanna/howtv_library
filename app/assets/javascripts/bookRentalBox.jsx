var $ = require('jquery');
var Vue = require('vue');

var BookRentalBox = Vue.extend({
  'data': function(){
    return {
      'book':{},
      'showRentalBox': false,
    }
  },
  'created': function(){},
  'methods' : {
    'toggleModal': function(){
      this.showRentalBox = false;
      this.$dispatch('hide-modal');
    },
    'openRentalBox': function(id){
      console.log('opeeeeeeeen')
      this.showRentalBox = true;
      this.book = {}; // clear
      this.getBook(id).done((data)=>{
        this.book = data.result.book;
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
    'open-rental-box': function(id){
      this.openRentalBox(id);
    }
  }
});

module.exports = BookRentalBox;
