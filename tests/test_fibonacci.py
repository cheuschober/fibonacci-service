#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Test cases for the Fibonacci api."""

# System libs
import os
import unittest
import sys
from flask import json

# Adds the application dir to the path
sys.path.append(os.path.join(os.path.dirname(__file__), '../application'))

# User libs
import main


class FibonacciTestCase(unittest.TestCase):
    """Provides unit test cases for the Fibonacci API."""

    def setUp(self):
        """
        Setup method for the Fibonacci API.

        Attributes:
            app (Flask): The main Flask application.
        """
        self.app = main.app.test_client()

    def test_fibonacci_api(self):
        """Tests the function of the Fibonacci API."""
        response = self.app.get('/api/fibonacci?count=5')
        data = json.loads(response.data)
        assert response.status_code == 200
        assert data[u'results'] == [0, 1, 1, 2, 3]

    def test_fibonacci_negative(self):
        """Tests that the API does not accept negative numbers.

        Returned data should still be JSON but returns the appropriate HTTP
        status code.
        """
        response = self.app.get('/api/fibonacci?count=-1')
        assert response.status_code == 403
        try:
            data = json.loads(response.data)
        except:
            data = {}
        assert u'message' in data

    def test_fibonacci_missing_param(self):
        """Tests that the API enforces the required parameters.

        Returned data should still be JSON but returns the appropriate HTTP
        status code.
        """
        response = self.app.get('/api/fibonacci')
        assert response.status_code == 403
        try:
            data = json.loads(response.data)
        except:
            data = {}
        assert u'message' in data

    def test_fibonacci_negative_nonint(self):
        """Tests that the API does not accept non-int convertible numbers.

        Returned data should still be JSON but returns the appropriate HTTP
        status code.
        """
        response = self.app.get('/api/fibonacci?count=apple')
        assert response.status_code == 403
        try:
            data = json.loads(response.data)
        except:
            data = {}
        assert u'message' in data


if __name__ == '__main__':
    unittest.main()
