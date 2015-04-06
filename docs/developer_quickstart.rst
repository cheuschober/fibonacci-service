Developer Quickstart
====================

The following steps may be followed to create a functioning development
environment.

Quickstart
----------

To run this project, for development or testing, start vagrant by executing:

.. code:: console

    $ vagrant up

This will allocate a virtual machine and provision it using `Vagrant`_ and the
`Salt`_ provisioner. When the machine is fully provisioned, enter it by
executing

.. code:: console

    $ vagrant ssh

To stop your virtual machine, execute:

.. code:: console

  $ vagrant halt

Should you ever need to destroy your virtual machine, you may use:

.. code:: console

    $ vagrant destroy

This will destroy the virtual machine *and all data not in a sync'ed folder*.
The ``vagrant up`` command may then be used to rebuild the virtual machine.

All of the above vagrant commands should be run from the same directory as the
``Vagrantfile``.

Speed Up Provisioning
---------------------

To speed up provisioning in cases where you expect to regularly create or
destroy virtual machines, you should enable the *Vagrant Cachier Plugin* which
will automatically cache calls to your package manager. To enable this plugin:

.. code:: console

    $ vagrant plugin install vagrant-cachier

Forwarding SSH Keys
-------------------

By default, `Vagrant`_ is configured to attempt to retrieve ssh keys from the
host through a process known as *agent forwarding* but in order for this to
work it must be enabled in your ``~/.ssh/config`` file. An example block may be
found below:

.. code:: text

    Host 127.0.0.1
        User [your-ssh-username]
        IdentityFile [~/.ssh/path-to-your-privkeyfile]
        ForwardAgent yes

In the above example, replace elements contained in brackets ``[]`` with their
appropriate values. The private key file is named ``id_rsa`` on most linux
systems.

You may choose an alternative ``Host`` parameter, if you wish -- this assumes
you only wish to forward agents only to virtual machines and services on
localhost which is a generally secure posture.

Global Defaults
---------------

You may optionally add lines to ``~/.vagrant.d/Vagrantfile`` that will be
automatically merged into the ``Vagrantfile`` used by this project. Generally,
this is used to bring over common development settings such as your git
config or vim settings. An example ``~/.vagrant.d/Vagrantfile`` may be found
below:

.. code:: ruby

    # -*- mode: ruby -*-
    # vi: set ft=ruby :

    Vagrant.configure(2) do |config|
      config.ssh.forward_agent = true

      if File.exists?(File.join(Dir.home, '.gitconfig'))
        config.vm.provision "file", source: '~/.gitconfig',
                                    destination: '.gitconfig'
      end
      if File.exists?(File.join(Dir.home, '.vimrc'))
        config.vm.provision "file", source: '~/.vimrc',
                                    destination: '.vimrc'
      end
      if Dir.exists?(File.join(Dir.home, '.vim'))
        config.vm.provision "file", source: '~/.vim',
                                    destination: '.vim'
      end
    end

Use Local Formulas
------------------

If you wish to develop your formulas in-concert with your application you may
wish to use a local formulas root. To do-so, place all of your formulas in a
single folder, eg ``/home/myuser/formulas`` and set an environment variable at
the top of your ``~/vagrant.d/Vagrantfile`` to point to the folder:

.. code:: ruby

    ENV["SALT_FORMULAS_ROOT"] = "/home/myuser/formulas"

Updating
--------

If you have a need to update this virtual machine, you may do so by entering
your virtual machine and issuing a salt highstate command:

.. code:: console

    $ salt '*' state.highstate

.. _`Vagrant`: https://www.vagrantup.com/
.. _`Salt`: http://docs.saltstack.com/en/latest/
