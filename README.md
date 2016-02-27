# evil-jumper [![MELPA](https://melpa.org/packages/evil-jumper-badge.svg)](https://melpa.org/#/evil-jumper)

evil-jumper is an add-on for **older versions** of [evil-mode][1] (prior to Feb 2016) which replaces the implementation of the jump list such that it mimics more closely with Vim's behavior. Specifically, it will jump across buffer boundaries and revive dead buffers if necessary. The jump list can also be persisted to history file using `savehist` and restored between sessions.

# package status

evil-jumper is **OBSOLETE**.  evil-jumper has been merged into upstream evil-mode; therefore this functionality is already available by default.

# installation

Install `evil-jumper` from [MELPA][3].

# usage

After installation, a global minor mode `evil-jumper-mode` will be made available.

# license

[GPL3][2]

[1]: https://bitbucket.org/lyro/evil/wiki/Home
[2]: http://www.gnu.org/copyleft/gpl.html
[3]: http://melpa.org
