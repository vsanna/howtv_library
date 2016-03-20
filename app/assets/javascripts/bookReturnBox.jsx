var $ = require('jquery');
var Vue = require('vue');

var BookReturnBox = Vue.extend({
  'props':['book', 'showReturnBox'],
  'created': function(){},
  'methods' : {
    'toggleModal': function(){
      this.$dispatch('hide-modal');
    },
    'returnBook': function(){
      this.$dispatch('return-book', this.book.id);
    },
  },
});

module.exports = BookReturnBox;
