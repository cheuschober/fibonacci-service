#!jinja|yaml

{% set nginx = salt['pillar.get']('nginx') %}

# Installs NginX package
nginx_installed:
  pkg.installed:
    - pkgs:
      - nginx

# Ensures the NginX service is running
nginx_running:
  service.running:
    - name: nginx
    - enable: True
    - require:
      - pkg: nginx_installed

# Disables any listed sites
{% for site in nginx.disabled %}
nginx_site_disabled_{{ site }}:
  file.absent:
    - name: /etc/nginx/sites-enabled/{{ site }}
    - require:
      - pkg: nginx_installed
    - watch_in:
      - service: nginx_running
{% endfor %}

# Enables any listed sites
{% for site in nginx.enabled %}
nginx_site_enabled_{{ site }}:
  file.symlink:
    - name: /etc/nginx/sites-enabled/{{ site }}
    - target: /etc/nginx/sites-available/{{ site }}
    - require:
      - pkg: nginx_installed
    - watch_in:
      - service: nginx_running
{% endfor %}
