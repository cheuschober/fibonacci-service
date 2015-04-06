Installation
============

The application is a self-contained Flask application with pre-defined
orchestration.

If you're looking for a how-to get started quickly, see the
*Developer Quickstart* document.

Requirements
------------

This application was designed to run atop Ubuntu v14.04. As-of this writing,
mileage may vary on other operating system types.

Currently, the only requirement is installing the `Salt`_ orchestration tool
which will complete configuration of the application from a bare-os state.

See the `Salt`_ documentation for how to best install `Salt`_ in your
environment.

Manual Configuration
--------------------

After Salt has finished installing, you may add the contents of the
``salt/root/`` folder as found in the application repository to your
``file_roots`` in the salt master/minion configuration.

.. note::

    The ``top`` file in the example does assume all sub-states are selected
    including documentation, gunicorn, and nginx. If you wish to disinclude
    these portions you may do so and provide suitable replacements.

Additionally, you should copy the pillar directives as found in
``salt/pillar`` adjusting them accordingly.

The default pillar settings are suitable for most production deployments.
Consult the *Pillar Keys* document for details on particular pillar settings
you may wish to adjust.

Automatic Configuration
-----------------------

After you have finished configuring your pillar, execute the following on your
minion node:

.. code:: console

    $ sudo salt-call state.highstate

Or, olternately, the following from the master:

.. code:: console

    $ sudo salt '<target>' state.highstate

replacing ``<target>`` as appropriate.

This should install and configure your webservice.

Confirmation
------------

Confirm your application is running by using curl:

.. code:: console

   $ http://<hostname>/api/fibonacci?count=5
   {
     "results": [
       0,
       1,
       1,
       2,
       3
     ]
   }

Network Configuration
---------------------

Out-of-the-box, this application does not compress HTTP traffic. The current
assumption is that network caching proxies will also provide the appropriate
compression.

.. _`Salt`: http://docs.saltstack.com/en/latest/
