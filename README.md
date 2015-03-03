What This Box Provides
======================

Using the tools here, you will be provided with a fully functional
Ubuntu 14.10 virtual machine, running Python 3.4 in a virtualenv (that
will always be active when you "vagrant ssh" in), TurboGears packages
preinstalled (and reinstallable from local), along with PostgreSQL.

Getting Started
===============

To use this, the process is simple.

1. Get VirtualBox installed and working correctly.
2. Get Vagrant installed and working correctly.
3. Ensure that Vagrant is capable of getting a virtual machine started
   with virtualbox, and that you can "vagrant ssh" into that box.
4. Execute the command "vagrant init tg2pg9 pedersen/tg2pg9"
5. Execute the command "vagrant up"

At this point, you now have a fully functioning python installation,
ready to run TurboGears. To quickstart your first application, do the
following:

  vagrant ssh
  cd /vagrant
  gearbox quickstart module_name_here
  cd module_name_here
  python setup.py develop
  gearbox setup-app

Almost done. You now need to edit
/vagrant/module_name_here/development.ini and change the "host" line
from 127.0.0.1 to 0.0.0.0

At this point, you can now execute the following command:

  gearbox serve --reload

On your machine (not in the "vagrant ssh") window, open a browser and
point it at http://localhost:8080/ and view the quickstarted web
application.

Reinstalling
============

There are two types of reinstallation. If you have installed some
Python packages, and they have broken your environment, then you can
simply run this command: "tginst" inside of a "vagrant ssh"
session. Your Python virtualenv will be rebuilt.

If you have more serious problems, simply using "vagrant halt",
"vagrant destroy", "vagrant up" from your machine (not inside of a
"vagrant ssh" session) will cause the entire machine to be
rebuilt. This will destroy any data outside of /vagrant so be careful!

Changing the Database for "psql"
================================

psql connects to the "template1" database by default. You can connect
to your own PostgreSQL database either specifying the correct name on
the command line like this:

psql mydbname

Or by changing your PGDATABASE environment variable. Use "vagrant ssh"
to log in and edit your ${HOME}/.bashrc file, and change the line
which sets PGDATABASE (near the very end of the file).
