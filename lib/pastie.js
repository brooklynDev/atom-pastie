var request = require('request');
var path = require('path');

function sendToPastie(text, fileName, callback) {
    var language = getLanguage(getExtension(fileName));
    request.post({
            url: 'http://pastie.org/pastes',
            followRedirect: false,
            form: {
                'utf8': '&#x2713;',
                'paste[parser_id]': language,
                'paste[body]': text,
                'paste[restricted]': 0,
                'paste[authorization]': 'burger'
            }
        },
        function(e, r, b) {
            callback(r.headers.location);
        })
}


function getLanguage(extension) {
    var languages = {
        "js": 10,
        "coffee": 40,
        "actionscript": 2,
        "sh": 13,
        "c": 7,
        "cpp": 7,
        "go": 21,
        "erb": 12,
        "html": 11,
        "htm": 11,
        "xml": 11,
        "java": 9,
        "m": 1,
        "php" :15,
        "txt": 6,
        "py": 16,
        "rb": 3,
        "sql": 14,
        "yaml": 19,
        "cs": 20
    };
    return languages[extension] || 6; //default to plain text
}

function getExtension(filename) {
    var ext = path.extname(filename || '').split('.');
    return ext[ext.length - 1];
}

module.exports.sendToPastie = sendToPastie;
