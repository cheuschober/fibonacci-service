#!jinja|yaml

{% set fibonacci = salt['pillar.get']('fibonacci') %}

include:
  - fibonacci

fibonacci_docs_installed:
  pip.installed:
  - bin_env: {{ fibonacci.virtualenv }}
  - requirements: salt://fibonacci/files/docs.txt
  - require:
    - virtualenv: fibonacci_virtualenv_managed

fibonacci_docs_generated:
  cmd.run:
    - name: 'source {{ fibonacci.virtualenv }}/bin/activate && make html'
    - cwd: {{ fibonacci.docs_root }}
    - unless: 'test -d "{{ fibonacci.docs_root }}/_build/html"'
    - require:
      - pip: fibonacci_docs_installed
