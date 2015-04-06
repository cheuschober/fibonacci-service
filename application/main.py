#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Entry script for Flask web service."""


# Flask libs
from flask import Flask
from flask import jsonify
from flask import request
from werkzeug.contrib.fixers import ProxyFix

# User libs
import fibonacci

app = Flask(__name__)


@app.route('/')
def default():
    """Default site home page.

    Returns:
        string:  Web content.

    Examples:

    .. code:: console

        $ curl http://domain.name/
        Welcome to the Fibonacci Webservice!
    """
    return 'Welcome to the Fibonacci Webservice!'


@app.route('/api/fibonacci', methods=['GET'])
def fibonacci_api():
    """Controller for the Fibonacci web service.

    Requests made to this service will be returned a JSON object with a
    Fibonacci sequence. This service accepts one required ``GET`` parameter
    for the total number of numbers to be returned.

    Args:
        count (int): The total number of Fibonacci numbers to return. Should
            be a ``GET`` parameter, eg ``?GET=5`. Required.

    Returns:
        string: A JSON-encoded string containing all Fibonacci numbers, eg::

            {"results": [0, 1, 1, 2, 3]}

        In the event that the request cannot be processed, the appropriate
        HTTP status code will be returned with a message in the JSON output,
        eg::

            {"message": "An error message"}

    Examples:

    .. code:: console

        $ curl http://localhost/api/fibonacci?count=5
        {"results": [0, 1, 1, 2, 3]}
    """
    if 'count' not in request.args:
        resp = jsonify(message='Missing required `count` parameter.')
        resp.status_code = 403
        return resp

    try:
        intval = int(request.args.get('count'))
    except:
        resp = jsonify(message='`count` must be an integer.')
        resp.status_code = 403
        return resp

    if intval < 0:
        resp = jsonify(message='"count" may not be negative.')
        resp.status_code = 403
    else:
        resp = jsonify(results=fibonacci.sequence(intval))

    return resp


app.wsgi_app = ProxyFix(app.wsgi_app)


if __name__ == '__main__':
    app.run()
