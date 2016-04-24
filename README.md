* [What This Box Provides](#what-this-box-provides)
* [Getting Started](#getting-started)
* [Reinstalling](#reinstalling)
* [Changing the Database for psql](#changing-the-database-for-psql)
* [MySQL, SQLAlchemy, and Python 3](#mysql,-sqlalchemy,-and-python-3)
* [Genshi and Python 3.4](#genshi-and-python-3.4)
* [Passwords Baked Into This Image](#passwords-baked-into-this-image)
* [Use With Python 2.7](#use-ith-python-2.7)

What This Box Provides
======================

Using the tools here, you will be provided with a fully functional
Ubuntu 15.04 virtual machine, running Python 3.4 (or 2.7) in a
virtualenv (that will always be active when you "vagrant ssh" in),
TurboGears packages preinstalled (and reinstallable from local), along
with PostgreSQL or MySQL or MongoDB (depending on your configuration).

Getting Started
===============

To use this, the process is simple.

1. Get VirtualBox installed and working correctly.
2. Get Vagrant installed and working correctly.
3. Ensure that Vagrant is capable of getting a virtual machine started
   with virtualbox, and that you can "vagrant ssh" into that box.
4. Execute the command "vagrant init turbogears/tg2-ubuntu"
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

Note that the second option is likely to be the fastest rebuild
option.

Changing the Database for psql
==============================

psql connects to the "template1" database by default. You can connect
to your own PostgreSQL database either specifying the correct name on
the command line like this:

psql mydbname

Or by changing your PGDATABASE environment variable. Use "vagrant ssh"
to log in and edit your ${HOME}/.bashrc file, and change the line
which sets PGDATABASE (near the very end of the file).

MySQL, SQLAlchemy, and Python 3
===============================

The Python-MySQL adaptor does not work correctly under Python 3. If
you wish to use MySQL, you must use the Oracle mysql-connector adapter
to connect to it. Fortunately, this is a very easy (and minor) change,
and the required package (mysql-connector-python) is already included
in these images.

Edit /vagrant/module_name_here/development.ini and find your
sqlalchemy.url line. Change from this:

   sqlalchemy.url=mysql://user:password@host:port/databasename

To this:

   sqlalchemy.url=mysql+mysqlconnector://user:password@host:port/databasename

Genshi and Python 3.4
=====================

Genshi 0.7 (the latest released version) and Python 3.4 do not get
along well. tgext.admin is broken while using it, along with many
other items.

TurboGears 2.3.5 provides a fix, though. To use it, add the following
line to your [app:main] section, and get things working:

templating.genshi.name_constant_patch = true

Passwords Baked Into This Image
===============================

The following passwords are baked into this image. Because of this,
you should either update to your own, or make your own image entirely
from this recipe, before deploying into any production system.

* Shell: user: vagrant password: vagrant
* PostgreSQL: user: vagrant password: vagrant
* MySQL: user: root password: vagrant

The vagrant user for the operating system has passwordless sudo enabled.

Use With Python 2.7
===================

To use this virtual machine with Python 2.7, simply make a file named
".python2" in the same directory with your "setup.py" file. From
there, reinstalling (as documented above) will give you a Python 2.7
virtual env.
