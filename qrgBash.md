# Quick Ref Guide BASH

`ls`            List files in directory
`ls -la`        List all files, and show permissions

`grep txt`      filter (ex ls | grep .jar  ->  list all .jar files)
  `grep -rHino` "string"
                list files in directory with string in contents

`mv filename dest`
        ex `mv qrg.txt ~/Desktop`
  `mv sourceFolder destFolder`
                Move folder
`cp filename dest`

`rm filename`   remove (non-directory) file
  `rm -rf name`   remove directory and contents, force
                (do not ask confirmation)

`cat filename`  display file contents
`cat file1 file2 file3`
                display contents off all 3 files
`cat file1 file2 > file3`
                save file1file2 to file3
`cat file | clip.exe`
                copy contents of file to windows sys clipboard

`man cmd`       hjelp cmd

`cd ..`         Navigate up

CTRL-C        quit/cancel command
CTRL-D        quit terminal

`cmd.exe /C start filename`
                Opens file in windows app
                (cmd.exe /C --> Run command after /C in win CMD then terminate)
`see filename`  open in default on linux (at least Ubuntu)
                (can use wsl-open to make this work on WSL)
`open filename` open in default on mac

pip3 v 10+ >>> `pip3 cmd` funker ikke -> bruk `python3 -m pip cmd`
                      (python3 -m pip install --user appname)
                      eller spesifiser full path /usr/local/bin/pip3

-------------------------------
## Special Keys Unix

* `esc`   `CTRL-[`

* `tab`   `CTRL-I`

-------------------------------

## Bra programmer

* vim           git clone vim repo -> build from source

                ./configure --with-features=huge --enable-python3interp=yes \
                            --with-python3-config-dir=/usr/lib/python3.6/config
                sudo make install (sjekk python dir)
                
                Etterpå set som default editor++ Sjekk YouCompleteMe guide

* git           apt
* texlive       apt
* screenfetch   apt                   display sysinfo
* python3/pip3  apt
* python-lang-server                  error/format check, help pages(til Ale)
               `pip3 install python-language-server[all]`
* vim-vint      pip3                  linting for vim (til Ale)
* -yqq npm      apt
* wsl-open      npm                   åpne apps med windows default
                                      ved `wsl-open -a file` settes default for
                                      denne filetype, kan så bruke `xdg-open`/`see`
* lftp          apt                   ftp/sftp ved lftp -u username address
                                      v/ behov   set ssl:verify-certificate false
                                      download dir:  mirror dir localdir

-------------------------------

## Bash in VIM 8

* `:term bash`  start terminal window
* `:term cmd`   run cmd
* `:term++close cmd`
                run cmd, automatically close when finished
* CTRL-W W      switch focus window
* CTRL-W C      end jobs
* `:hide`       hides terminal window
* `:q`          quit/close terminal window

-------------------------------

## WslTty / MinTTY

ALT F2          New window
ALT ENTER       Full screen
