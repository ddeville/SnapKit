/*
	-url 'http://google.com'
	-viewport-width 768
	-useragent 'Safari/537.17'
*/
var system = require('system');

var url, viewportWidth, viewportHeight, userAgent

system.args.forEach(function (arg, idx, args) {
	if (arg === '-url' && idx < args.length) {
		url = args[idx + 1];
	}
	if (arg === '-viewport-width' && idx < args.length) {
		viewportWidth = args[idx + 1];
	}
	if (arg === '-useragent' && idx < args.length) {
		userAgent = args[idx + 1];
	}
})

if (!url) {
	console.log("Usage: websnap.js -url 'http://google.com' [-viewport-width 768] [-userAgent 'Safari/537.17']");
	phantom.exit(1);
}

viewportWidth = viewportWidth || 1280;
userAgent = userAgent || 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17';

var page = require('webpage').create();

page.viewportSize = {width: viewportWidth, height: 1024};
page.settings.userAgent = userAgent;

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
	
	console.log(JSON.stringify(result));
	phantom.exit(0);
}

page.onError = phantom.onError = function() {
	phantom.exit(1);
};

page.open(url, function (status) {
	if (status !== 'success') {
		phantom.exit(1);
	}
	
	window.setTimeout(snap, 60);
});
