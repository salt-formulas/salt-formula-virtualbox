
==========
VirtualBox
==========

VirtualBox is a general-purpose full virtualizer for x86 hardware, targeted at server, desktop and embedded use.

Sample pillars
==============

VirtualBox version 4.3

.. code-block:: yaml

    virtualbox:
      host:
        enabled: true
        version: 4.3
        extensions: false

VirtualBox version 5.0

.. code-block:: yaml

    virtualbox:
      host:
        enabled: true
        version: 5.0


Read more
=========

* https://www.virtualbox.org/wiki/Technical_documentation
* http://ubuntuforums.org/showthread.php?t=1810768
* https://www.virtualbox.org/wiki/Linux_Downloads

Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-virtualbox/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-virtualbox

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
