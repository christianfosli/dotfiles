# dotfiles 

I use this repo to backup and keep in sync my bash/git/tmux ++
config files. I go a bit back and forth between Fedora Linux and WSL with
Ubuntu.

**I advise against using these dotfiles directly.
Some commands may only work specifically on my set-up or in my workflow.
Feel free to copy relevant bits into your own dotfiles**

## set up

* clone repo into $HOME/.config

* Symlink the bash config files. Most of the other dotfiles should work by
  themselves due to [XDG base directory](https://wiki.archlinux.org/index.php/XDG_Base_Directory)

## Quick-Ref bash / GNU tools

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

### Files and Directories

* Push/Pop directories to stack `pushd $dir` then later `popd`

* Copy file contents to clipboard (on WSL) `cat $file | clip.exe`

* Search command history: `<C-r> startOfCommand`

* **GREP**: Recursively search for "pattern" and print matching lines and
  line numbers `grep -rn pattern dir`  (use `.` for `dir` for current)

  * Use *extended* regular expressions such as `(), |,`
    :grep -E "(.png$|.PNG$)" .
  
  * Exclude dir: `grep -rn --exclude-dir=node_modules pattern dir`

  * Exclude `.gitignore`: `git grep -n pattern dir`

* Find files by filename: `find . -name "pattern"` or
 `find . -name node_modules -prune -o -name tmux* -print`
 ( if we find node\_modules, stop dont look inside => TRUE  OR   if name tmux* print it. )

 * Or use a fuzzy finder like FZF or [skim](https://github.com/lotabout/skim)

* Create symlink `ln -s actual_file_path symlink_path`

* Extract .tar.gz file `tar -xzf <filename` (remember eXtract tZe File)

### Networking

* List ip-address `ip addr`

* List ip addresses on same network: `ip neigh`

* Check hostname for ip in local network: `nmblookup -A <ip>`

* SSH `ssh username@ip -p portnumber`

  * Start ssh service to allow log-ins (fedora) `systemctl start sshd.service`

* Copy files between local computer and remote 
  `scp $file username@ip:/home/$dir` or `scp username@ip:/home/$file $localdir`

* Check wifi devices, connect to wifi networks etc 
  `nmcli radio ...`, `nmcli device wifi...`, `nmcli connection ...`

* Good-to-know cURL options

  * Download to file from URL: `-O`

  * Silent: `--silent` | `-s`. Good idea when piping output to e.g. bash.

  * Follow redirects: `--location` | `-L`

  * Retries: `--retry <n>`

  * Fail on bad status code: `--fail` | `-f`

  * Basic auth: `-u username:pass`

  * Client certs: `--cert cert-w-key.pem:password` or `--cert cert.crt --key key.key`

## Quick-Ref git

Open help-page: `git help command`

* Everyday work

  * Check what's up       `git status`

  * See what happened     `git log [--graph --all --date=human --stat]`)

    * one-line commits: `git log [--graph --all] --oneline`

  * Add files to stage    `git add filename`

    * Stage part of file  `git add -p filename`

  * Check diff            `git diff branch1 branch2`  or `file1 file2` etc

    * Check message and diff of commit: `git show <commit-hash>`

    * Check diff for a merge commit:

      * Given this commit:
      ```patch
      commit ccc333
      Merge: aaa111 bbb222 
      ```

      ```console
      git diff aaa111...bbb222
      ```
  * Commit stage to current branch `git commit`

    * Commit all tracked files with changes: `git commit -a`

    * Use interactive patch selection to decide what to commit: `git commit -p`

    * Show diff below the commit message: `git commit -v`

  * Undo changes          `git restore <filename>`

  * Unstage file          `git reset <filename>`

* Misc

  * Does origin/master have new commits? (commits not reachable from HEAD)

    `git fetch origin && git log ..origin/master`

  * Ignore future local changes to a tracked file (useful for config files...)
    `git update-index --skip-worktree <filename>`

    * Undo with `git update-index --no-skip-worktree <filename>`

* Branches

  * Show branches         `git branch` or `git branch -vv` or `git branch -r`
  
  * Create branch         `git branch <branch-name>`

  * Switch to branch      `git switch <branch>`

  * Do both 2 above       `git switch -c <branch name>`

  * Merge/rebase branch   *first checkout the to-branch* then
                          `git merge <from-branch>` or `git rebase <from-branch>`

  * Delete branch         `git branch -d <branch>`
                          force delete with `git branch -D <branch>`

  * Delete every branch except master `git branch | grep -v "master" | xargs git branch -D`

  * Reset branch to earlier commit / branch / tag `git reset --hard <commit>`

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

  * Delete remote branch  `git push <remote> -d <branch>`

  * Update submodules     `git submodule update` or `git submodule update --remote`

## quick-ref tmux

* list sessions `tmux ls` or `Ctrl-b s`

* attach `tmux attach #`

* rename window `Ctrl-b ,`

* new pane `Ctrl-b "` or `Ctrl-b %`

* move pane to a new window `Ctrl-b !`

* toggle layouts `Ctrl-b <space>`

* resize panes `Ctrl-b alt-arrows`

## quick-ref dotnet

* run fsharp fsx script `dotnet fsi <filename>`

* open fsharp interpreter `dotnet fsi --readline`

## quick-ref docker

* Most used commands: `docker ps`, `docker images`, `docker build`, `docker run`

* Most used docker-run flags: `-it` interactive terminal, `-d` detached (in the background)

* Detach from running container: Ctrl P Q

* Remove all non-running images: `docker rmi $(docker ps -aq)` or `docker image prune -a`

* Check disk usage: `docker system df`

## special keys

* `esq`   `Ctrl-]`
