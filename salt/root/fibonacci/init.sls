#!jinja|yaml

{% set fibonacci = salt['pillar.get']('fibonacci') %}

# Installs the virtualenv package
virtualenv_deps_installed:
  pkg.installed:
    - pkgs:
      - python-virtualenv
      - python-dev

# Ensures the virualenv directory exists
fibonacci_virtualenv_directory:
  file.directory:
    - name: {{ fibonacci.virtualenv }}
    - makedirs: True

# Virtualenv populated for the app
fibonacci_virtualenv_managed:
  virtualenv.managed:
    - name: {{ fibonacci.virtualenv }}
    - requirements: salt://fibonacci/files/requirements.txt
    - require:
      - pkg: virtualenv_deps_installed
      - file: fibonacci_virtualenv_directory



# Gunicorn set to run
# fibonacci_gunicorn_running:
#     service.running:
#       - name: fibonacci-gunicorn
#       - require:
#           - virtualenv: fibonacci_virtualenv_managed
#       - watch_in:
#           - service: nginx_running
