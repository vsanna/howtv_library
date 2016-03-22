var $ = require('jquery');
var Vue = require('vue');

var BookComment = Vue.extend({
  'props':['book', 'showComment'],
  'data': function(){
    return {
      'tags':[],
      'comment': null
    }
  },
  'created': function(){},
  'methods' : {
    'toggleModal': function(){
      this.$dispatch('hide-modal');
    },
    'send': function(){
      this.$dispatch('send-comment', this.book.id, this.comment);
      this.comment = null;
    },
  },
});

module.exports = BookComment;
