# myneovim
My neovim configuration tree


## Prerequisites 
[Neovim >=0.8.0](https://neovim.io/)<br/>
[Packer](https://github.com/wbthomason/packer.nvim)

## Setup
These instrutions will work for GNU/Linux, BSD and Apple's macOS.
Installtion for Windows 10/11 is possible under the Windows Subsystem for Linux (WSL) and is theoretically possible under just the Windows Shell, but may require some tweaks (i.e. config file locations).

1. Clone this repo into your home directory (e.g. ~/myneovim)
2. Create a symlink to the Neovim configuration tree
```
$ sudo ln -sf ~/myneovim/nvim ~/.config/nvim
```
3. Open Neovim and install all the plugins (there will be alot of errors on the first launch, this is normal)
```
$ nvim
```
4. To change the color scheme, open the file `~/.config/nvim/lua/plugins/init.lua` and change the line `colorscheme <colorscheme>` in the config function under `use 'dracula/vim'` to that of your choice. If your scheme is a plugin, then change the `dracula/vim` as such. If not, it does not need to be modified.

## Misc
Currently, the latest working version of JDTLS is 
jdtls@1.12.0-202206011637
