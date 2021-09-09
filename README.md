# myneovim
My neovim configuration tree


## Prerequisites 
[Neovim >=0.5](https://neovim.io/)<br/>
[Packer](https://github.com/wbthomason/packer.nvim)

## Setup
These instrutions will work for GNU/Linux, BSD and Apple's macOS.
Installtion for Windows 10 is possible under the Windows Subsystem for Linux (WSL) and is theoretically possible under just the Windows Shell, but may require some tweaks (i.e. config file locations).

1. Clone this repo into your home directory (e.g. ~/myneovim)
2. Create a symlink to the Neovim configuration tree
```
$ sudo ln -sf ~/myneovim/nvim ~/.config/nvim
```
3. If you haven't yet already, install Packer (this is the plugin manager)
```
$ ./myneovim/install_scripts/packer.sh
```
4. Open Neovim and install all the plugins (there will be alot of errors on the first launch, this is normal)
```
$ nvim
:PackerInstall
:PackerCompile
```
5. To change the color scheme, open the file `~/.config/nvim/lua/plugins/init.lua` and change the line `colorscheme <colorscheme>` in the config function under `use 'dracula/vim'` to that of your choice. If your scheme is a plugin, then change the `dracula/vim` as such. If not, it does not need to be modified.



