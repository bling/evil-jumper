evil-jumper
===========

evil-jumper is an add-on for [evil-mode][1] which replaces the implementation of the jump list such that it mimics more closely with Vim's behavior. Specifically, it will jump across buffer boundaries and revive dead buffers if necessary. The jump list can also be persisted to a file and restored between sessions.

installation
============

Add `evil-jumper.el` to the `load-path` and `(require 'evil-jumper)`.

usage
=====

Requiring the file will automatically set up `C-i` and `C-o`.

license
=======

[GPL3][2]

[1]: https://gitorious.org/evil
[2]: http://www.gnu.org/copyleft/gpl.html
