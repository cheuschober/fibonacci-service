#!jinja|yaml

{% set sitefile = 'fibonacci' %}
{% set approot = '/vagrant' %}
{% set gunicorn_logdir = '/var/log/gunicorn' %}
{% set gunicorn_socketdir = '/var/run/gunicorn' %}
{% set wsgi = 'unix:' ~ gunicorn_socketdir ~ '/fibonacci.sock' %}

nginx:
  disabled:
    - default
  enabled:
    - {{ sitefile }}

fibonacci:
  docs_root: {{ approot }}/docs
  nginx:
    sitefile: {{ sitefile }}
    enable_cache: True
    context:
      proxy_cache_path: /var/cache/nginx/fibonacci
      proxy_cache_zone: fibonacci
      proxy_cache_key_size: 10m
      proxy_cache_max_size: 1000m
      proxy_cache_inactive: 60m
      proxy_cache_key: '$scheme$proxy_host$request_uri'
      wsgi:
        cluster: fibonacci
        servers:
          - {{ wsgi }}
      server_name: _
      port: 80
      access_log: /var/log/nginx/access.log
      error_log: /var/log/nginx/error.log
      root: {{ approot }}/application/web
      docs_root: {{ approot }}/docs/_build/html
      static_cache_duration: 1y
  virtualenv: {{ approot }}/virtualenv
  gunicorn:
    app: 'main:app'
    chdir: {{ approot }}/application
    service_name: gunicorn-fibonacci
    log_dir: {{ gunicorn_logdir }}
    socket_dir: {{ gunicorn_socketdir }}
    config:
      file: {{ approot }}/config/gunicorn.py
      context:
        user: www-data
        group: www-data
        bind: {{ wsgi }}
        umask: '0177'
        worker_class: gevent
        accesslog: {{ gunicorn_logdir }}/fibonacci-access.log
        errorlog: {{ gunicorn_logdir }}/fibonacci-error.log
        pidfile: {{ gunicorn_socketdir }}/fibonacci.pid
