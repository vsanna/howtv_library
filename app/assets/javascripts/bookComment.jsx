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
      console.log('送信');
    },
  },
});

module.exports = BookComment;
