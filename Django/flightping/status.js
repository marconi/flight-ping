if (phantom.args.length === 0) {
    console.log("You need to pass origin, destination, flight date and flight number.");
    phantom.exit();
}

var page = new WebPage(),
    fs = require("fs"),
    url = "http://203.177.104.80/ftrackcp/ftrack.aspx",
    jqueryUrl = "http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js",
    steps = 0,
    origin = phantom.args[0],
    destination = phantom.args[1],
    flightSchedule = phantom.args[2],
    flightNumber = phantom.args[3];

page.onConsoleMessage = function (msg, line, source) {
    console.log('console> ' + msg + ' @ line: ' + line);
};

function evalArgFormatter(func, args) {
    var funcStr = func.toString();
    for (key in args) {
        funcStr = funcStr.replace(key, args[key]);
    }
    return funcStr;
}

page.onLoadFinished = function(status) {
    steps += 1;
    if (status === 'success') {
        switch (steps) {
            case 1: // set origin and destination
                var evalArg = evalArgFormatter(function() {
                    var origin = "__ORIGIN__";
                    var destination = "__DESTINATION__";
                    $("select[name=ddorigin]").val(origin);
                    $("select[name=ddDestination]").val(destination).trigger("change");
                }, {__ORIGIN__: origin, __DESTINATION__: destination});

                console.log("Setting origin and destination...");
                // initial jquery inject
                page.includeJs(jqueryUrl, function() {
                    // since onLoadFinished is only triggered on
                    // succeeding page loads, we execute step one here.
                    page.evaluate(evalArg);
                });
                break;
            case 2:  // set flight date
                var evalArg = evalArgFormatter(function() {
                    var flightSchedule = "__FLIGHTSCHEDULE__";
                    $("select[name=DdFlightdate]").val(flightSchedule).trigger("change");
                }, {__FLIGHTSCHEDULE__: flightSchedule});

                console.log("Setting flight schedule...");
                page.includeJs(jqueryUrl, function() {
                    page.evaluate(evalArg);
                });
                break;
            case 3:  // set flight number and submit form
                var evalArg = evalArgFormatter(function() {
                    var flightNumber = "__FLIGHTNUMBER__";
                    $("select[name=DdFlightno]").val(flightNumber);
                    $("#imdbtnShow").trigger("click");
                }, {__FLIGHTNUMBER__: flightNumber});

                console.log("Setting flight number...");
                page.includeJs(jqueryUrl, function() {
                    page.evaluate(evalArg);
                });
                break;
            default:  // save the search result
                page.includeJs(jqueryUrl, function() {
                    var data = page.evaluate(function() {
                        var targetTable = $("table")[2];
                        var targetRow = $(targetTable).find("tr")[2];
                        var targetCols = $(targetRow).find("td");
                        return JSON.stringify({
                           flightNo: $(targetCols[0]).text().trim(),
                           origin: $(targetCols[1]).text().trim(),
                           destination: $(targetCols[2]).text().trim(),
                           std: $(targetCols[3]).text().trim(),
                           sta: $(targetCols[5]).text().trim(),
                           status: $(targetCols[7]).text().trim(),
                        });
                    });
                    console.log(data);
                    phantom.exit();
                });
                break;
        }
    }
    else if (status !== 'success') {
        console.log("Loading failed at " + steps);
    }
};

page.open(url);
