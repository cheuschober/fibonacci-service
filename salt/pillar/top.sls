#!jinja|yaml
# Note that the custom pillar should always follow other pillars

base:
  '*':
    - fibonacci
    - custom
