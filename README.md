# SnapKit

Web snapping. In the Cloud.

The app is a simple Sinatra app with a /snap endpoints that uses a phantomjs script to obtain a capture of a webpage given a URL and a viewport width.

Run the app locally with Foreman. Just do
```
foreman start
```
and the app will be available on localhost:5000.

## Heroku

Create an app:
```
	heroku apps:create snapkit
```

Setup the buildpack:
```
	heroku config:add BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git
```

Ensure that Heroku can find the phantom.js binary:
```
	heroku config:add PATH="/usr/local/bin:/usr/bin:/bin:/app/vendor/phantomjs/bin"
	heroku config:add LD_LIBRARY_PATH="/usr/local/lib:/usr/lib:/lib:/app/vendor/phantomjs/lib"
```
