var fs = require('fs');

for (var i = 0; i < 10e2; i++) {
    fs.statSync('.');
}

