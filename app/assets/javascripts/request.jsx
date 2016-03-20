var $ = require('jquery');
var Vue = require('vue');

$(() => {

  if ( $('body').is('.pages') ){
    var sendRequest = (type, body)=>{
      return $.ajax({
        'type': 'POST',
        'url': '/api/v1/request/',
        'dataType': 'json',
        'data':{
          'query': {
            'type': type,
            'body': body,
          }
        }
      });
    }

    var request =  new Vue({
      'el': $("#request").get(0),
      'data': {
        'showRequest': false,
        'query': {
          'type': 1,
          'body': null,
        },
      },
      'created': function(){
      },
      'methods': {
        'toggleRequest': function(){
          this.showRequest = !this.showRequest;
        },
        'sendRequest': function(){
          sendRequest(this.query.type, this.query.body).done((data)=>{
            alert(data.message);
            this.toggleRequest();
            this.clearQuery();
          }).fail(()=>{
            alert('正しく送信できませんでした...slackでもご意見お待ちしております!')
          })
        },
        'clearQuery': function(){
          this.query = {
            'type': 1,
            'body': null,
          }
        }
      },
    })

  }
});
