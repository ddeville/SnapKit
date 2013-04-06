# RemoteSnap

Web snapping. In the Cloud.

## Heroku

Create an app:
```
	heroku apps:create remotesnap
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
