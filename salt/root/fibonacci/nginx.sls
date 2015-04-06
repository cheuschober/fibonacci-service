#!jinja|yaml

{% set nginx = salt['pillar.get']('fibonacci:nginx') %}

include:
  - nginx

# Ensures the cache directory exists
{% if nginx.enable_cache %}
fibonacci_nginx_cache:
  file.directory:
    - name: {{ nginx.context.proxy_cache_path }}
    - makedirs: True
    - user: www-data
    - group: www-data
    - require_in:
      - file: fibonacci_nginx_conf
{% endif %}

# Manages the nginx site config file
fibonacci_nginx_conf:
  file.managed:
    - name: /etc/nginx/sites-available/{{ nginx.sitefile }}
    - source: salt://fibonacci/files/nginx.conf
    - makedirs: True
    - template: jinja
    - context:
        nginx: {{ nginx.context | json }}
        cache: {{ nginx.enable_cache | json }}
    - require:
      - pkg: nginx_installed
    - require_in:
      - file: nginx_site_enabled_{{ nginx.sitefile }}
    - watch_in:
      - service: nginx_running
