=================
fibonacci-service
=================

A Fibonacci web service.

This project establishes a web service that returns a Fibonacci sequence as a
JSON return.

Technologies
============

This project utilizes components of the following major technologies:

-   NginX (HTTP Proxy/Cache)

-   Gunicorn (Python Web Application Server)

-   Flask (Python Microframework)

-   Sphinx/Docutils (Documentation Generator)

-   Vagrant (Host Virtualization / Provisioning)

-   Salt (Orchestration / Configuration)

Documentation
=============

Documentation is provided in the ``docs/`` folder and may be built as a Sphinx
project. You are encouraged to peruse the Installation and
Developer Quickstart documents or build the docs in your preferred output
format.

Turnkey
=======

If you have already installed `Vagrant`_, you may configure and start the
service with:

.. code:: console

    $ vagrant up

Issued from the location where you downloaded the project. The service will be
available on port ``8080`` of your host operating system, eg::

    http://localhost:8080/fibonacci/api

Documentation is also available at::

    http://localhost:8080/docs/

.. _`Vagrant`: https://www.vagrantup.com/
