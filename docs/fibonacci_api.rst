Fibonacci API
=============

The API provided by this web service returns JSON data with a sequence of
Fibonacci numbers.

It has one required ``GET`` parameter ``count`` which must be a positive
integer. A proper request resembles the following:

    http://<my.domain.name>/api/fibonacci?count=1000

A successful returned data object has the following construction:

    {"results": [0, 1, 1, 2, 3...]}

Requests are cached by NginX in the default configuration so subsequent calls
for the same sequence size should be cached on response. Check the
``X-Proxy-Cache`` header for cache status.

HTTP Status Codes
-----------------

The following error status codes are most likely to be encountered.

HTTP 200/OK
^^^^^^^^^^^

This code means the query was successful and the JSON data returned should
contain a ``results`` key in which the requested Fibonacci numbers may be
found.

HTTP 403/Forbidden
^^^^^^^^^^^^^^^^^^

This code is encountered if you passed an illegal parameter such as a
negative number or a non-integer string or if you neglected to include the
``count`` parameter at all.

The returned JSON object will contain a key named ``message`` in which more
details may be available.

HTTP 500/Internal Server Error
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This code would be encountered in any instance where the server failed to
complete the request in any expected fashion.
