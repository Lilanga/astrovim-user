# Astrovim user configurations

This repository contains my personal configurations using for Neovide based on [AstroNvim](www.github.com/AstroNvim/AstroNvim) V4.
Updated to support Neovim 0.10.0 and AstroNvim 4. For the original AstroNvim configurations, please refer to the [AstroNvim](www.github.com/AstroNvim/AstroNvim) repository. AstroNvim 3 configurations are available in the astrovim3 branch.

## Installation

[Install Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md) using the package manager of your choice. For Windows, I recommend using [Scoop](https://scoop.sh/).

1. Backup your current configuration

   ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. Clone this repository to your home directory

    ```bash
    git clone https://github.com/Lilanga/astrovim-user.git ~/.config/nvim
    ```

## OS / Environment tested

Hack Nerd Font and Victor Mono NF are used in the configuration.Ensure you have the fonts installed in your system and set the terminal font to the same.

This configuration has been tested on Windows and some tweaks done for pwsh. This should work on other environments, but I haven't tested it. I have different user configurations for my macos setup.

Currently using with Neovim 0.10.0

## Screenshots

Following are screenshots of the applied NVIM configuration. I am using Windows termincal with semi transparent background settings. The font used here is Hack Nerd font.

![Welcome screen](https://raw.githubusercontent.com/Lilanga/astrovim-user/main/docs/welcome.png)

![Editor screen](https://raw.githubusercontent.com/Lilanga/astrovim-user/main/docs/screenshot.png)
