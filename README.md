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

