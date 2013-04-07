/*
	-url 'http://google.com'
	-viewport-width 768
	-user-agent 'Safari/537.17'
*/

var system = require('system');

var url, viewportWidth, viewportHeight, userAgent

system.args.forEach(function (arg, idx, args) {
	if (arg === '-url') url = args[idx + 1];
	if (arg === '-viewport-width') viewportWidth = args[idx + 1];
	if (arg === '-user-agent') userAgent = args[idx + 1];
})

if (!url) {
	system.stderr.write("Usage: websnap.js -url 'http://google.com' [-viewport-width 768] [-user-agent 'Safari/537.17']");
	phantom.exit(1);
}

viewportWidth = viewportWidth || 1280;
userAgent = userAgent || 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17';

var page = require('webpage').create();
page.viewportSize = {width: viewportWidth, height: 1024};
page.settings.userAgent = userAgent;

page.onError = phantom.onError = function() {
	system.stderr.write("There was an unknown error while capturing the page");
	phantom.exit(1);
};

page.open(url, function (status) {
	if (status !== 'success') {
		phantom.exit(1);
	}
	
	window.setTimeout(snap, 60);
});

function snap() {
	page.evaluate(function() {
	    document.body.bgColor = 'white';
	});
	
	var title = page.evaluate(function() {
		return document.title;
	});
	
	var imageData = page.renderBase64('PNG');
	
	var result = {
		title: title,
		imageData: imageData,
	};
	
	system.stdout.write(JSON.stringify(result));
	phantom.exit(0);
}
