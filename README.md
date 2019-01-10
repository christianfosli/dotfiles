# dotfiles 

I use this repo to backup and keep in sync my bash/git/tmux ++
config files.

**I advise against using these dotfiles directly.
Some commands may only work specifically on my set-up or in my workflow.
Feel free to copy relevant bits into your own dotfiles**

## set up

* clone repo, for example into $HOME

* run the applicable script in script directory,
  or make symlinks etc manually

## quick-ref bash / GNU tools

* Exit `Ctrl-D`

* Cancel (kill) app/job `Ctrl-C`

* Suspend `Ctrl-Z` suspend (pause) an app/job (go back to bash)

* Resume job `fg`  (list all with `jobs`)

* Readline (emacs-style shortcuts):
  * Go to beginning of line `Ctrl-a`
  * Go to end of line `Ctrl-e`
  * Delete line `Ctrl-x <Backspace>`
  * Open command in $EDITOR, execute upon exit `Ctrl-x Ctrl-e` or `fc`

* Very basics:: moving files/folders `mv source dest`, copying
  files/folders `cp source dest`, change directory `cd $dir`
  cd up `cd ..` cd previous `cd -`, print file to stdout
  `cat $file`, view file nicely `less $file`, manuals `man $cmd`

* Push/Pop directories to stack `pushd $dir` then later `popd`

* Copy file contents to clipboard (on WSL) `cat $file | clip.exe`

* **GREP**: Recursively search for "pattern" and print matching lines and
  line numbers `grep -rn pattern dir`  (use `.` for `dir` for current)

  * Use *extended* regular expressions such as `(), |,`
    :grep -E "(.png$|.PNG$)" .
  
  * Exclude dir: `grep -rn --exclude-dir=node_modules pattern dir`

  * Exclude `.gitignore`: `git grep -n pattern dir`

* Create symlink `ln -s actual_file_path symlink_path`

* List all files in long format (with permissions and stuff) `ls -la`
  (usually aliased to `ll`

* Network Stuffs
  
  * List ip-address `ip addr`
  
  * List ip addresses on same network: `ip neigh`

  * Check hostname for ip in local network: `nmblookup -A <ip>`

  * SSH `ssh username@ip`

    * Start ssh service to allow log-ins (fedora) `systemctl start sshd.service`

  * Copy files between local computer and remote 
    `scp $file username@ip:/home/$dir` or `scp username@ip:/home/$file $localdir`

  * Check wifi devices, connect to wifi networks etc 
    `nmcli radio ...`, `nmcli device wifi...`, `nmcli connection ...`

* quick commandline calculator: *bc* (reads from filename or stdin) ex:
  `printf "5*10\n" | bc`

## quick-ref git

Open help-page: `git --help command`

* Init

  * Create a new repo     `git init`

  * Clone existing repo   `git clone url`
  
  * Add a submodule       `git submodule add url` then `git submodule init`
    (If cloning a repo which uses submodules we still need to 'submodule init')

* Everyday work

  * Check what's up       `git status`

  * See what happened     `git log [--graph --all --date=relative]`)

    * one-line commits: `git log [--graph --all] --oneline`

    * only show first parent for merge-commits: `git log --first-parent`

    * visual tool: `gitk [--all]`

  * Add files to stage    `git add filename`

    * Stage part of file  `git add -p filename`

    * Interactive mode:   `git add -i`

  * Check diff            `git diff branch1 branch2`  or `file1 file2` etc

  * Commit stage to current branch `git commit`

    * Commit all tracked files with changes: `git commit -a`

    * Use interactive patch selection to decide what to commit: `git commit -p`

    * Note for writing commit message:
      "When applied this commit will " + Header max 50 char

  * Undo changes          `git reset` / `git checkout`

  * Mark a known point    `git tag`
  
  * Does origin/dev have new commits? (commits not reachable from HEAD)

    `git fetch origin && git log ..origin/dev`

  * Show commits reachable from `<branch>` but not origin/dev
  i.e. which changes will be introduced when I PR `branch` into origin/dev

    `git log origin/dev..<branch>`

* Branches

  * Show branches         `git branch` or `git branch -vv`
  
  * Create branch         `git branch <branch-name>`

  * Switch to branch      `git checkout <branch>`

  * Do both 2 above       `git checkout -b <branch name>`

  * Merge/rebase branch   *first checkout the to-branch* then
                          `git merge <from-branch>` or `git rebase <from-branch>`

  * Delete branch         `git branch --delete <branch>`

  * Reset branch to earlier commit / branch / tag
                          `git reset --hard <commit>`
  * Clean up latest n commits
    (opens interactive rebase editor letting you squash
     pick, fixup, reorder  `git rebase -i HEAD~n`

    * Note: **Don't rebase commits that exist outside your local
      repository!** (Will require force-push)

* Remotes

  * Fetch latest changes  `git fetch <remote>`

  * Show remote info      `git remote show <remote>`

  * Fetch and merge       `git pull`

  * Fetch and rebase      `git pull --rebase`

  * Push to remote        `git push <remote> <branch>`

  * Force Push to remote  `git push <remote> --force-with-lease`

  * Delete remote         `git push <remote> --delete <branch>`

  * Update submodules     `git submodule update` or `git submodule update --remote`

### Nice branch model * *

[Ref](http://www.bitsnbites.eu/a-stable-mainline-branching-model-for-git)

* Master branch

  * Builds/runs and tests pass

* Feature branches - make dedicated (short-lived) branches for features

  * named "feature/description" e.g. "feature/add-timeline"

  * based on origin/master. Frequently rebase origin/master into this.

  * merge into master when all ok

* Release branches - Fork of master branch

  * named "release/x.y.z" (major.minor.patch)

  * the commit that represents a release should be tagged "x.y.z"

  * if bugs preferably fix on master then cherry-pick to release branch,
    alternatively fix on release branch and open ticket for properly
    fixing on master

## quick-ref tmux

* list sessions `tmux ls` or `Ctrl-b s`

* attach `tmux attach #`

* rename window `Ctrl-b ,`

* new pane `Ctrl-b "` or `Ctrl-b %`

* toggle layouts `Ctrl-b <space>`

* resize panes `Ctrl-b alt-arrows`

## special keys

* `esq`   `Ctrl-]`
