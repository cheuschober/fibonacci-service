#!/usr/bin/env python
# -*- charset: utf-8 -*-
#
# Do not modify this file.
# This file is managed by {{ source }}
"""Gunicorn configuration file."""

{% for key, val in gunicorn.iteritems() %}
{{ key }} = '{{ val }}'
{%- endfor -%}
