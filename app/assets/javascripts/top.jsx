var $ = require('jquery');
var Vue = require('vue');
var BookViewer = require('./bookViewer.jsx');
var BookRentalBox = require('./bookRentalBox.jsx');

$(() => {
  var getBooks = (page, query)=>{
    return $.ajax({
      'type': 'GET',
      'url': '/api/v1/books/index_or_search',
      'dataType': 'json',
      'data': {
        'page': page,
        'query': query,
      }
    });
  }

  if ( $('body').is('.pages') ){
    var mypage =  new Vue({
      'el': $("#mypage").get(0),
      'components':{
        'book-viewer': BookViewer,
        'book-rental-box': BookRentalBox,
      },
      'data': {
        'showModal': false,
        'viewingBookId': 1,
        'loading': false,
        'books': [],
        'page': 1,
        'total': 0,
        'has_next': true,
        'query': {
          'search_key': null,
        },
      },
      'created': function(){
        this.getBooks();
      },
      'methods': {
        'toggleModal':function(){
          this.showModal = !this.showModal;
        },
        'showBook': function(id){
          this.viewingBookId = id;
          this.$broadcast('get-book', id); // 子孫方向にイベントを発信
          this.toggleModal();
        },
        'openRentalBox': function(id){
          this.$broadcast('open-rental-box', id); // 子孫方向にイベントを発信
          this.toggleModal();
        },
        'readMore': function(){
          this.loading = true;
          this.getBooks();
        },
        'search': function(){
          this.books = [];
          this.page = 1;
          this.getBooks();
        },
        'getBooks': function(){
          getBooks(this.page, this.query).done((data)=>{
            this.books = this.books.concat(data.books);
            this.total = data.total;
            this.hasNext(data.left_count);
            this.page += 1;
          }).fail(()=>{
            alert('読み込めませんでした。');
          }).always(()=>{
            this.loading = false;
          })
        },
        'hasNext': function(left_count){
          this.has_next = (left_count > 0) ? true : false;
        }
      },
      'events' : {
        'hide-modal': function () {
          this.showModal = false;
        }
      }
    })

  }
});
