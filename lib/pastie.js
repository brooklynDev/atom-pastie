var request = require('request');

function sendToPastie(text,callback){
  request.post({
    url: 'http://pastie.org/pastes',
    followRedirect: false,
    form:{
      'utf8':'&#x2713;',
      'paste[parser_id]':'1',
      'paste[body]': text,
      'paste[restricted]': 0,
      'paste[authorization]': 'burger'
  }
}, function(e,r,b){
  callback(r.headers.location);
})
}

module.exports.sendToPastie = sendToPastie;
