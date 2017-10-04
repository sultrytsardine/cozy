echo Setting up GitHub two-factor access...
apt install gcc libgnome-keyring-dev -y &> /dev/null || (echo Failed installing gnome-keyring! && exit 1)
make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring &> /dev/null || (echo Failed building gnome-keyring! && exit 1)
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
