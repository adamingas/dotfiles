#!/bin/bash

export GIT_SSL_NO_VERIFY=1
path_to_nvim=$(which nvim)
if [ -x "$path_to_nvim" ] ; then
    echo "$(nvim --version | head -n 1) is already installed, would you like to update? Y/n"
    read confirm_update
else
    confirm_update="y"
fi 
lowercase_answer=$(echo "${confirm_update}" | awk '{ print tolower($0) }')

if [ "${lowercase_answer}" != "y" ]; then
    echo -e "\nExiting...\n"
    exit
fi

echo "$confirm_update"
# [ ! -d "$HOME/.nvim" ] && echo 'Nvim not present' && 
# TODO: Specify version to update to
cd /home/cdsw
curl -LOk https://github.com/neovim/neovim/releases/download/v0.8.3/nvim.appimage \
&& chmod u+x nvim.appimage \
&& ./nvim.appimage --appimage-extract \
&& mv /home/cdsw/squashfs-root/ /home/cdsw/.nvim \
&& ln -s /home/cdsw/.nvim/AppRun ~/.local/bin/nvim \
&& echo "$(nvim --version)"
[ ! -e "$HOME/.local/share/nvim/site/autoload/plug.vim" ] && curl -kfLo  ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip3 install neovim
[ ! -d "$HOME/.config/nvim" ] && mkdir -p ~/.config/nvim/

