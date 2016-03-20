var $ = require('jquery');
var Vue = require('vue');

var BookRentalBox = Vue.extend({
  'props':['book', 'showRentalBox'],
  'created': function(){},
  'methods' : {
    'toggleModal': function(){
      this.$dispatch('hide-modal');
    },
    'borrowBook': function(){
      this.$dispatch('borrow-book', this.book.id);
    },
  },
});

module.exports = BookRentalBox;
