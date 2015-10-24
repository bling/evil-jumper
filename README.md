evil-jumper
===========

evil-jumper is an add-on for [evil-mode][1] which replaces the implementation of the jump list such that it mimics more closely with Vim's behavior. Specifically, it will jump across buffer boundaries and revive dead buffers if necessary. The jump list can also be persisted to history file using `savehist` and restored between sessions.

installation
============

Install `evil-jumper` from [MELPA][3].

usage
=====

After installation, a global minor mode `evil-jumper-mode` will be made available.

license
=======

[GPL3][2]

[1]: https://bitbucket.org/lyro/evil/wiki/Home
[2]: http://www.gnu.org/copyleft/gpl.html
[3]: http://melpa.org
