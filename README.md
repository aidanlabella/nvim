# NVIM Configuration
@aidanlabella's neovim config

## Prerequisites 
[Neovim >=0.9.0](https://neovim.io/)<br/>
[Lazy.nvim](https://github.com/folke/lazy.nvim)

## Setup
These instrutions will work for GNU/Linux, BSD and Apple's macOS.
Installtion for Windows 10/11 is possible under the Windows Subsystem for Linux (WSL) and is theoretically possible under just the Windows Shell, but may require some tweaks (i.e. config file locations).

1. Clone this repo into your home directory (e.g. `~/nvim`). Alternatively, you can clone this directly into `~/.config` - this will allow you to skip step 2.
2. Create a symlink to the Neovim configuration tree
```
$ sudo ln -sf ~/nvim ~/.config/nvim
```
3. Open Neovim and install all the plugins (Lazy should do this automatically)
```
$ nvim
```
4. To change the settings, such as the color scheme, edit the file `lua/settings.lua`.

## Misc
Currently, the latest working version of JDTLS is 
jdtls@1.12.0-202206011637
