exports.handler = function(event, context, callback) {

    var name = event["name"];

    var message = 'Hello ' + name + "!";

    callback(null, message);
};

