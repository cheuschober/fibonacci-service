Testing
=======

Basic unit testing has been implemented for the Flask api and helper modules.

Helper Module Testing
---------------------

Helper module testing has integrated doctests. To run the tests, simply call
the module on the cli, eg:

.. code:: console

    $ python fibonacci.py

If any errors are present, the console will report them. To see passed and
failed tests, add ``-v`` to the execution, eg:

.. code:: console

    $ python fibonacci.py -v
    ...
    Test passed.

Dedicated Unit Tests
--------------------

Unit tests are found in the ``tests/`` directory of the application root.
You may execute the tests by calling them on the cli, eg:

.. code:: console

    $ python ../tests/test_fibonacci.py
    ....
    ---------------------------------------------------------
    Ran 4 tests in 0.059s

    OK

These tests take advantage of the Flask framework's ability to simulate its
application stack without a running web service.
