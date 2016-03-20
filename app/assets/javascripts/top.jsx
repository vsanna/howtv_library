var $ = require('jquery');
var Vue = require('vue');
var BookViewer = require('./bookViewer.jsx');
var BookRentalBox = require('./bookRentalBox.jsx');
var BookComment = require('./bookComment.jsx');

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
  var getBook = (id)=>{
    return $.ajax({
      'type': 'GET',
      'url': '/api/v1/books/' + String(id),
      'dataType': 'json',
    });
  }

  var borrowBook = (id)=>{
    return $.ajax({
      'type': 'POST',
      'url': '/api/v1/books/' + String(id) + '/borrow',
      'dataType': 'json',
    });
  }

  if ( $('body').is('.pages') ){
    var mypage =  new Vue({
      'el': $("#mypage").get(0),
      'components':{
        'book-viewer': BookViewer,
        'book-rental-box': BookRentalBox,
        'book-comment': BookComment,
      },
      'data': {
        'showModal': false,
        'showViewer': false,
        'showRentalBox': false,
        'showComment': false,
        'currentBookId': null,
        'loading': false,
        'book': {},
        'comments':[],
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
        // 検索周り
        'readMore': function(){
          this.loading = true;
          this.getBooks();
        },
        'search': function(){
          this.books = [];
          this.page = 1;
          this.getBooks();
        },
        'hasNext': function(left_count){
          this.has_next = (left_count > 0) ? true : false;
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

        // modalまわり
        'getBook': function(id){
          if (this.currentBookId == id){ return; }
          this.book = {}; // clear
          getBook(id).done((data)=>{
            this.currentBookId = data.result.book.id;
            this.book = data.result.book;
            this.comments = data.result.comments;
          }).fail(()=>{
            alert('エラーが起きました。存在しない書籍です。');
          })
        },
        'borrowBook': function(id){
          borrowBook(id).done((data)=>{
            alert(data.message);
            this.currentBookId = null; // 再読み込み
            this.getBook(id);
            this.hideModal();
          }).fail(()=>{
            alert('エラーが起きました。存在しない書籍です。');
          })
        },
        'openViewer': function(id){
          this.showModal = true;
          this.showViewer = true;
          this.getBook(id);
        },
        'openRentalBox': function(id){
          this.showModal = true;
          this.showRentalBox = true;
          this.getBook(id);
        },
        'openComment': function(id){
          this.showModal = true;
          this.showComment = true;
          this.getBook(id);
        },
        'stockBook': function(id){
        },
        'hideModal': function(){
          this.showModal = false;
          this.showViewer = false;
          this.showRentalBox = false;
          this.showComment = false;
        }
      },
      'events' : {
        'hide-modal': function () {
          this.hideModal();
        },
        'get-book': function(id){
          this.getBook(id);
        },
        'open-comment': function(id){
          this.hideModal();
          this.openComment(id);
        },
        'borrow-book': function(id){
          this.borrowBook(id);
        }
      }
    })

  }
});
