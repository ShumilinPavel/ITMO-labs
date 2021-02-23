const { o3 } = require('goss_proto');

const prototypeNames = [];
let curObj = o3;

while (curObj !== null) {
    prototypeNames.push(curObj.name);
    curObj = Object.getPrototypeOf(curObj);
}

module.exports = prototypeNames;
