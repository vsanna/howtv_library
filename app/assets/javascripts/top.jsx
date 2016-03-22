var $ = require('jquery');
var Vue = require('vue');
var BookViewer = require('./bookViewer.jsx');
var BookRentalBox = require('./bookRentalBox.jsx');
var BookComment = require('./bookComment.jsx');
var BookReturnBox = require('./bookReturnBox.jsx');

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

  var returnBook = (id)=>{
    return $.ajax({
      'type': 'POST',
      'url': '/api/v1/books/' + String(id) + '/return',
      'dataType': 'json',
    });
  }

  var sendComment = (id, comment)=>{
    console.log('fdas');
    return $.ajax({
      'type': 'POST',
      'url': '/api/v1/comments',
      'dataType': 'json',
      'data': {
        'book_id': id,
        'comment': comment
      }
    });
  }

  if ( $('body').is('.pages') ){
    var mypage =  new Vue({
      'el': $("#main").get(0),
      'components':{
        'book-viewer': BookViewer,
        'book-rental-box': BookRentalBox,
        'book-comment': BookComment,
        'book-return-box': BookReturnBox,
      },
      'data': {
        'loading': false,
        'showModal': false,
        'showViewer': false,
        'showRentalBox': false,
        'showComment': false,
        'showReturnBox': false,
        'showToastMsg': false,
        'currentBookId': null,
        'book': {},
        'comments':[],
        'books': [],
        'page': 1,
        'total': 0,
        'has_next': true,
        'toastMsg': null,
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

        // action周り
        'getBook': function(id){
          if (this.currentBookId == id){
            this.loading = false;
            return;
          }
          this.book = {}; // clear
          getBook(id).done((data)=>{
            this.currentBookId = data.result.book.id;
            this.book = data.result.book;
            this.comments = data.result.comments;
            this.loading = false;
          }).fail(()=>{
            alert('エラーが起きました。存在しない書籍です。');
          }).always(()=>{
            this.loading = false;
          })
        },
        'borrowBook': function(id){
          if ( this.loading ){ return; }
          this.loading = true;

          borrowBook(id).done((data)=>{
            alert(data.message);
            this.currentBookId = null; // 再読み込み
            this.getBook(id);
            this.hideModal();
          }).fail(()=>{
            alert('エラーが起きました。存在しない書籍です。');
          }).always(()=>{
            this.loading = false;
          })
        },
        'returnBook': function(id){
          if ( this.loading ){ return; }
          this.loading = true;

          returnBook(id).done((data)=>{
            this.hideModal();
            this.openComment(id);
            this.showToaseMessage(data.message);
          }).fail(()=>{
            alert('エラーが起きました。存在しない書籍です。');
          }).always(()=>{
            this.loading = false;
          })
        },
        'sendComment': function(id, comment){
          if ( this.loading ){ return; }
          this.loading = true;
          console.log('asdf');
          sendComment(id, comment).done((data)=>{
            this.hideModal();
            this.showToaseMessage(data.message);
          }).fail(()=>{
            alert('エラーが起きました。存在しない書籍です。');
          }).always(()=>{
            this.loading = false;
          })
        },
        'stockBook': function(id){
        },
        'openViewer': function(id){
          this.loading = true;
          this.showModal = true;
          this.showViewer = true;
          this.getBook(id);
        },
        'openRentalBox': function(id){
          this.loading = true;
          this.showModal = true;
          this.showRentalBox = true;
          this.getBook(id);
        },
        'openReturnBox': function(id){
          this.loading = true;
          this.showModal = true;
          this.showReturnBox = true;
          this.getBook(id);
        },
        'openComment': function(id){
          this.loading = true;
          this.showModal = true;
          this.showComment = true;
          this.getBook(id);
        },

        // 演出
        'hideModal': function(){
          this.loading = false;
          this.showModal = false;
          this.showViewer = false;
          this.showRentalBox = false;
          this.showReturnBox = false;
          this.showComment = false;
        },
        'showToaseMessage': function(msg){
          this.toastMsg = msg;
          this.showToastMsg = true;
          setTimeout(()=>{
            this.showToastMsg = false;
          }, 3000)
        },
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
        },
        'return-book': function(id){
          this.returnBook(id);
        },
        'send-comment': function(id, comment){
          this.sendComment(id,comment);
        }
      }
    })

  }
});
