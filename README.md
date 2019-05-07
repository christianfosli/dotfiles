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

  * Move by words `Ctrl- <Arrow-Keys>`

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

  (mostly just tested on Fedora Linux)
  
  * List ip-address `ip addr`
  
  * List ip addresses on same network: `ip neigh`

  * Check hostname for ip in local network: `nmblookup -A <ip>`

  * SSH `ssh username@ip -p portnumber`

    * Start ssh service to allow log-ins (fedora) `systemctl start sshd.service`

  * Copy files between local computer and remote 
    `scp $file username@ip:/home/$dir` or `scp username@ip:/home/$file $localdir`

  * Check wifi devices, connect to wifi networks etc 
    `nmcli radio ...`, `nmcli device wifi...`, `nmcli connection ...`

## quick-ref git

Open help-page: `git --help command`

* Init

  * Create a new repo     `git init`

  * Clone existing repo   `git clone url`
  
  * Add a submodule       `git submodule add url` then `git submodule init`
    (If cloning a repo which uses submodules we still need to 'submodule init')

* Everyday work

  * Check what's up       `git status`

  * See what happened     `git log [--graph --all --date=human --stat]`)

    * one-line commits: `git log [--graph --all] --oneline`

    * only show first parent for merge-commits:
      `git log --first-parent [-m --stat]`

    * GUI log: `gitk [--all]`

  * Add files to stage    `git add filename`

    * Stage part of file  `git add -p filename`

  * Check diff            `git diff branch1 branch2`  or `file1 file2` etc

  * Commit stage to current branch `git commit`

    * Commit all tracked files with changes: `git commit -a`

    * Use interactive patch selection to decide what to commit: `git commit -p`

    * Show diff below the commit message: `git commit -v`

    * Note for writing commit message:
      "When applied this commit will " + Header max 50 char

  * Undo changes          `git checkout <filename>`

  * Unstage file          `git reset <filename>`

  * Does origin/dev have new commits? (commits not reachable from HEAD)

    `git fetch origin && git log ..origin/dev`

  * Show commits reachable from `<branch>` but not origin/dev
  i.e. which changes will be introduced when I PR `branch` into origin/dev

    `git log origin/dev..<branch>`

  * Show commit message and changes in a commit `git show --stat <commit-hash>/<branch>`

  * Ignore future local changes to a tracked file (useful for config files...)
    `git update-index --skip-worktree <filename>`

    * Undo with `git update-index --no-skip-worktree <filename>`

* Branches

  * Show branches         `git branch` or `git branch -vv` or `git branch -r`
  
  * Create branch         `git branch <branch-name>`

  * Switch to branch      `git checkout <branch>`

  * Do both 2 above       `git checkout -b <branch name>`

  * Merge/rebase branch   *first checkout the to-branch* then
                          `git merge <from-branch>` or `git rebase <from-branch>`

  * Delete branch         `git branch -d <branch>`
                          force delete with `git branch -D <branch>`

  * Reset branch to earlier commit / branch / tag
                          `git reset --hard <commit>`

  * Clean up latest n commits
    (opens interactive rebase editor letting you squash
     pick, fixup, reorder  `git rebase -i HEAD~n`

    * Note: **Don't rebase commits that exist outside your local
      repository!** (Will require force-push)

* Remotes

  * Fetch latest changes  `git fetch <remote>`

    * And remove remote remote tracking branches which have been deleted
    `git fetch -p <remote>` (shows [gone] on `git branch -v`)

  * Show remote info      `git remote -v` or more info with `git remote show <remote>`

  * Fetch and merge       `git pull`

  * Fetch and rebase      `git pull --rebase`

  * Push to remote        `git push <remote> <branch> [--force-with-lease]`

  * Push and add upstream (tracking) reference `git push -u <remote> <branch>`

  * Delete remote         `git push <remote> -d <branch>`

  * Update submodules     `git submodule update` or `git submodule update --remote`

### Nice branch model for smaller/personal projects * *

[Ref](http://www.bitsnbites.eu/a-stable-mainline-branching-model-for-git)

* Master branch

  * Builds/runs and tests pass

  * Tag commits that represent a release version `vx.y.z` (major.minor.patch)

* Feature branches - make dedicated (short-lived) branches for features

  * named "feature/description" e.g. "feature/add-timeline"

  * based on origin/master. Frequently rebase origin/master into this.

  * merge into master when complete (typically via PR)

### Git Flow

* Master branch: Represents code in prod

* Develop branch: Updated with latest features and fixes!

* Feature branch: Branched from dev. Merged back to dev once done
  (typically via a PR)

* Release branch: Branched from dev. Test. Branch to master AND dev when
  ready for prod, and tag the commit on master `vx.y`.

* Hotfix branch: Important bug found in prod. Branched from master.
  Once fixed, merge into both master and dev.

## quick-ref tmux

* list sessions `tmux ls` or `Ctrl-b s`

* attach `tmux attach #`

* rename window `Ctrl-b ,`

* new pane `Ctrl-b "` or `Ctrl-b %`

* move pane to a new window `Ctrl-b !`

* toggle layouts `Ctrl-b <space>`

* resize panes `Ctrl-b alt-arrows`

## special keys

* `esq`   `Ctrl-]`
