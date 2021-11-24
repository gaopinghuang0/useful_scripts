
## Traditional Nginx config (Not working with flask `url_for` in subsubdirectory)
Nginx with subfolder rewrite works fine if we do not add further subdirectory, such as 'http://example.com/sub/?param=param'.
However, if we have subsubdirectory, such as 'http://example.com/sub/subsub/param', combining with Flask `url_for`, there is a problem.
The `url_for('static', filename="fig.jpg")` in templates will return `/static/figures/...`, which cannot be correctly rendered without the `/sub/` prefix.

```nginx
http {
  include         /etc/nginx/mime.types;
  default_type    application/octet-stream;
  
  server {
    listen  80;
    
    location /sub {
      rewrite /sub/(.*) /$1 break;
      proxy_pass          http://locahost:8090;
      proxy_redirect      off;
      proxy_set_header    Host $host;
    }
  }
}
```


## Solution
Based on this blog post: https://dlukes.github.io/flask-wsgi-url-prefix.html#mwe  . We can leverage the WSGI-standard's `SCRIPT_NAME`.

First, we can pass the `SCRIPT_NAME=/sub` from command line, which requires a WSGI-server, such as Gunicorn.
```bash
$ SCRIPT_NAME=/sub gunicorn app:app
```
The built-in Flask server will ignore `SCRIPT_NAME` in env var, so it does not work this way.
A workaround is to write below in `server.py`
```python
from werkzeug.middleware.dispatcher import DispatcherMiddleware
from werkzeug.wrappers import Response

app.wsgi_app = DispatcherMiddleware(
    Response('Not Found', status=404),
    {'/sub': app.wsgi_app}   # set the SCRIPT_NAME manually here.
)
```

Next, we should not rewrite the Nginx as above. Instead, pass through it.
```nginx
location /sub/ {
    proxy_pass http://127.0.0.1:8000/sub/;
    # ...                            ^^^^
}
```

Then restart nginx by 
```bash
$ sudo systemctl reload nginx
```

Then it works.


