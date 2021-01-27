# myneovim
My neovim configuration tree


## Prerequisites 
[Neovim](https://neovim.io/)<br/>
[Vim-Plug](https://github.com/junegunn/vim-plug)

## Setup
These instrutions will work for GNU/Linux, BSD and Apple's macOS.
Installtion for Windows 10 is possible under the Windows Subsystem for Linux (WSL) and is theoretically possible under just the Windows Shell, but may require some tweaks (i.e. config file locations).

1. Clone this repo into your home directory (e.g. ~/myneovim)
2. Create a symlink to the Neovim configuration tree
```
$ sudo ln -sf ~/myneovim/nvim ~/.config/nvim
```
3. If you haven't yet already, install Vim-Plug (this is the plugin manager)
```
$ ./myneovim/install_scripts/vplug.sh
```
4. Open Neovim and install all the plugins (there will be alot of errors on the first launch, this is normal)
```
$ nvim
:PlugInstall
```
5. To change the color scheme, open the file ~/myneovim/nvim/general/theme.vim and change the line 'colorscheme dracula', to the scheme of your choice



