#!/bin/bash

echo "export PATH=$PATH:$HOME/bin/" >> $HOME/.bashrc
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
cd $HOME
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
&& chmod +x nvim.appimage \
&& ./nvim.appimage --appimage-extract
[ -d "$HOME/.nvim" ] && rm -r "$HOME/.nvim" 
[ ! -d "$HOME/bin" ] && mkdir -p "$HOME/bin"
mv $HOME/squashfs-root/ $HOME/.nvim \
&& ln -s $HOME/.nvim/AppRun ~/bin/nvim \
&& echo "$(nvim --version)"
[ ! -e "$HOME/.local/share/nvim/site/autoload/plug.vim" ] && curl -kfLo  ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip3 install neovim python-lsp-server pylsp-mypy python-pylsp-ruff
[ ! -d "$HOME/.config/nvim" ] && mkdir -p ~/.config/nvim/
nvim +PlugInstall +qall
