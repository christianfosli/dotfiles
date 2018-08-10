# Directory to put .files from ~ directory

In ~ create symlinks to use these files - e.g.

    ln -s /home/cfosli/dotfiles/bashrc /home/cfosli/.bashrc

TODO: Make a .sh script to automate all of this, that is:

* Set up symlinks in ~ to the files in this repo
* Set up symlinks in ~ to freq used dirs in windows home dir
  when running on wsl (`oneDrive`, `googleDrive`, `documents`, `downloads`...)
* Install good stuffs from apt, install `pip3`, `pyls`, `wsl-open`, `xdg-tools`??,
  `lftp`, ...?? Dependencies needed for vim
* Clone and build vim
* Clone `Github/vimconfig` into ~/.vim
