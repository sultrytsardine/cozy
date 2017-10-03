# Basher
Bash yer commandline in

Inspired by oh-my-zsh's first commit (basically a bunch of .zsh scrripts with sane defaults) and vim's plugin manager - Vundle

## Goals
+ sets up your environment just the way you like on fresh installs
+ helps you keep track of changes and update
+ supports your own plugins and extensions!

## Plugins
found in `.basher/plugins`, each plugin has at least 3 scripts: `install.sh`, `uninstall.sh`, and `<plugin_name>.sh`, where `<plugin_name>` is the same as it's directory's name

## Properties
+ default location: `$HOME/.basher`
+ main script: `$BASHER/basher.sh`
+ fresh install? do `./$HOME/.basher/install.sh`
+ plugin management: `$BASHER/plugins.sh`
+ plugin location: `$BASHER/plugins/`

