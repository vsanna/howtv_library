var $ = require('jquery');
var Vue = require('vue');

var BookViewer = Vue.extend({
  'props':['book', 'comments', 'showViewer'],
  'created': function(){},
  'methods' : {
    'toggleModal': function(){
      this.$dispatch('hide-modal');
    },
    'openComment': function(){
      this.$dispatch('open-comment', this.book.id);
    },
    'stock': function(){
    },
    'borrow': function(){
      this.$dispatch('borrow-book', this.book.id);
    },
  },
});

module.exports = BookViewer;
