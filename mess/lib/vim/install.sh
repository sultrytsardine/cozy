#
# VIM
#
echo "Installing vim..."
# VIMRC setup
apt install -i vim &> /dev/null || (echo Failed installing vim! && exit 1)
# if .vimrc exists, rename it
if [ -f "$HOME/.vimrc"]; then
    echo 'Backing up .vimrc -> .vimrc.bak...'
    mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
fi
ln --symbolic "$BASHER_LOCATION/vimrc" "$HOME/.vimrc"
# Vundle
echo "Installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
vim +PluginInstall +qall $> /dev/null || (echo Failed installing vim plugins && exit 1)
# if YouCompleteMe is installed, need to recompile
if [ -d "$HOME/.vim/bundle/YouCompleteMe" ]; then;
    echo "Recompiling YouCompleteMe libraries..."
    apt install -y build-essential cmake &> /dev/null || (echo Failed installing cmake and build-essential! && exit 1)
    python "$HOME/.vim/bundle/YouCompleteMe/install.py" $> /dev/null || (echo Compilation failed! && exit 1)
fi
