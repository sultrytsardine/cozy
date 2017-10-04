echo Configuring git to your liking...
git config --global user.name wtty-fool
git config --global user.email wtty.fool@gmail.com
git config --global core.editor vim
echo Setting git aliases...
git config --global alias.last 'log -1 --stat'
git config --global alias.cp 'cherry-pick'
git config --global alias.co 'checkout'
git config --global alias.cl 'clone'
git config --global alias.ci 'commit'
git config --global alias.st 'status -sb'
git config --global alias.br 'branch'
git config --global alias.unstage 'reset HEAD --'
git config --global alias.dc 'diff --cached'
git config --global alias.lg 'log --graph --pretty format:"%Cred%h%Creset -%C(yel%Cblue<%an>%Creset" --abbrev-commit --date relative --all'

