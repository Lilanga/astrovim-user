# Astrovim user configurations

This repository contains my personal configurations using for Neovide based on [AstroNvim](www.github.com/AstroNvim/AstroNvim) V4.
Updated to support Neovim 0.10.0 and AstroNvim 4. For the original AstroNvim configurations, please refer to the [AstroNvim](www.github.com/AstroNvim/AstroNvim) repository. AstroNvim 3 configurations are available in the astrovim3 branch.

## Installation

[Install Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md) if you do not have nvim alreay.

1. Backup your current configuration (if any)

    *Nix:

    ```bash
        mv ~/.config/nvim ~/.config/nvim.bak
        mv ~/.local/share/nvim ~/.local/share/nvim.bak
    ```

    Windows:

    ```pwsh
        mv ~/AppData/Local/nvim ~/AppData/Local/nvim.bak
        mv ~/AppData/Local/nvim-data ~/AppData/Local/nvim-data.bak
    ```

2. Clone this repository to your home directory

    *Nix:

    ```bash
        git clone git@github.com:Lilanga/astrovim-config.git ~/.config/nvim
    ```

    Windows:

    ```bash
        git clone git@github.com:Lilanga/astrovim-config.git ~/AppData/Local/nvim
    ```

## OS / Environment tested

Hack Nerd Font and Victor Mono NF are used in the configuration.Ensure you have the fonts installed in your system and set the terminal font to the same.

This configuration has been tested on Windows and some tweaks done for pwsh. Also I am using this nvim setup on WezTerm with Nushell. I have different user configurations for my macos setup.

Currently using with Neovim 0.10.0

## Screenshots

Following are screenshots of the applied NVIM configuration. I am using Iterm2 with semi transparent background settings. The font used is Fira Code.

![Welcome screen](https://raw.githubusercontent.com/Lilanga/astrovim-config/main/docs/welcome.png)

![Editor screen](https://raw.githubusercontent.com/Lilanga/astrovim-config/main/docs/screenshot.png)
