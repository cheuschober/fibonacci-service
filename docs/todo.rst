To-Do
=====

The following describes notable feature improvements for the future.

NginX Proxy Cache Fixes
-----------------------

For an, as-yet undetermined reason, the NGinX proxy cache is registering a
`MISS`` for the Flask JSON content.

Sequence Caching
----------------

Using a backend like `redis`_, the Fibonacci sequence could be saved in a list,
This has an issue with creating race conditions since it is a long-running
process. In theory, as a new max-size for the list is asked the calculation
could resume at the end of the last run until it hits the new max-size. Lesser
requests could pull slices, or ranges. This is fairly efficient in redis since
either operation is slicing data from either the left or the right.

The ``fibonacci`` module is already prepared for the resume-calculation scenario
but additional work should be considered to avoid long-locks or race conditions
updating the same keys.

Asynchronous Execution
----------------------

Combined with `redis`_, long-running calculations could use a celery backend
to spawn the Fibonacci sequencing process. This would be an ideal way to
approach the race condition problem as well by allowing a single write-queue
but multiple read queues and allowing celery to do the switching.

Results Streaming
-----------------

A websocket-compatible backend should be implemented to stream the results as
they are generated. This is the reason the Fibonacci sequencer was written as a
generator. Unfortunately, this would preclude the use of the flask JSON libs
which cannot use generators. This particular dataset is simple-enough to
hand-craft a serializer if one is so-needed but it raises other issues of
client support for web sockets, (usually consumed by javascript entities).

Results Pagination
------------------

Perhaps even more useful than a websocket implementation would be a paginated
implementation that uses the ``fibonacci.xsequence()`` generator and manual
iteration to paginate and send the paginated results.

Optional GZip Compression
-------------------------

GZip compression should be added to the states as an optional (pillar) component
of the NginX configuration.

Logrotate
---------

Logrotate needs to be added to the managed formulas.

NTP
---

NTP needs to be added to the managed formulas.

Log Management
--------------

A log management tool such as logstash needs to be added to the managed
formulas.

Monitoring Tool
---------------

A monitoring tool such as zabbix should be added to the managed formulas.

Gunicorn Worker Status
----------------------

Gunicorn should be updated to report its worker statuses (consumable by
monitoring tools).

Test Runner
-----------

All tests should be combined and executable via a single runner.

Clustering
----------

Currently, this application may be clustered without complication but any
scenario involving caches or asynchronous execution may call for adaptations
to the formula that encourage clustering. This could include both backend
modifications (eg, redis) as well as intelligent switching which, for the
purpose of this turnkey, suggests adding HAProxy into the mix.

.. _`redis`: http://redis.io/
