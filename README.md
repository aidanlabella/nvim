# myneovim
My neovim configuration tree


## Prerequisites 
[Neovim](https://neovim.io/)
[Vim-Plug](https://github.com/junegunn/vim-plug)

## Setup
These instrutions will work for GNU/Linux, BSD and Apple macOS.
Installtion for Windows 10 is possible under the Windows Subsystem For Linux (WSL) and is theoretically possible under just the Windows Shell, but will require tweaking

1. Clone this repo into your home directory (e.g. ~/myneovim)
2. If you haven't yet already, install Vim-Plug
```
$ ./myneovim/install_scripts/vplug.sh
```
3. Create a symlink to the Neovim configuration tree
```
$ sudo ln -sf ~/myneovim/nvim ~/.config/nvim
```
4. Open Neovim and install all the plugins (there will be alot of errors on the first launch, this is normal)
```
$ nvim
:PlugInstall
```
5. To change the color scheme, open the file ~/myneovim/nvim/general/theme.vim and change the line 'colorscheme <colorscheme>', to the scheme of your choice



