#!jinja|yaml

{% set fibonacci = salt['pillar.get']('fibonacci') %}

include:
  - fibonacci

# Virtualenv populated for the app
fibonacci_gunicorn_virtualenv_managed:
  virtualenv.managed:
    - name: {{ fibonacci.virtualenv }}
    - requirements: salt://fibonacci/files/gunicorn.txt
    - require:
      - pkg: virtualenv_deps_installed
      - file: fibonacci_virtualenv_directory

# Gunicorn configuration
fibonacci_gunicorn_config:
  file.managed:
    - name: {{ fibonacci.gunicorn.config.file }}
    - source: salt://fibonacci/files/gunicorn.py
    - template: jinja
    - context:
        gunicorn: {{ fibonacci.gunicorn.config.context | json }}

# Manages the gunicorn upstart file
fibonacci_gunicorn_upstart:
  file.managed:
    - name: /etc/init/{{ fibonacci.gunicorn.service_name }}.conf
    - source: salt://fibonacci/files/gunicorn.conf
    - template: jinja
    - context:
        gunicorn: {{ fibonacci.gunicorn | json }}
        virtualenv: {{ fibonacci.virtualenv }}

# Ensures that the log directory exist
fibonacci_gunicorn_log_dir:
  file.directory:
    - name: {{ fibonacci.gunicorn.log_dir }}
    - user: {{ fibonacci.gunicorn.config.context.user }}
    - group: {{ fibonacci.gunicorn.config.context.group }}
    - dir_mode: 700
    - file_mode: 644

# Ensures that the log directory exist
fibonacci_gunicorn_socket_dir:
  file.directory:
    - name: {{ fibonacci.gunicorn.socket_dir }}
    - user: {{ fibonacci.gunicorn.config.context.user }}
    - group: {{ fibonacci.gunicorn.config.context.group }}
    - dir_mode: 755
    - file_mode: 644

# Gunicorn set to run
fibonacci_gunicorn_running:
    service.running:
      - name: gunicorn-fibonacci
      - require:
          - virtualenv: fibonacci_gunicorn_virtualenv_managed
          - file: fibonacci_gunicorn_socket_dir
          - file: fibonacci_gunicorn_log_dir
          - file: fibonacci_gunicorn_upstart
          - file: fibonacci_gunicorn_config
      - watch_in:
          - service: nginx_running
