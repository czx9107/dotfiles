#!/bin/bash

apt-get update
apt-get install -y zsh git stow neovim

USER="wei"
PUBLIC_KEY=""
ZSH_DIR="/home/$USER/.zsh_plugins"

# Add new user with zsh as default shell and home dir
useradd -m -s /bin/zsh $USER

# Change user's group to SUDO, and execute sudo command with NO password
usermod -aG sudo $USER
echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users

# Configuring SSH
mkdir -p /home/$USER/.ssh
echo "$PUBLIC_KEY" >> /home/$USER/.ssh/authorized_keys

chown -R $USER:$USER /home/$USER/.ssh
chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/authorized_keys

# Install plugins for zsh
mkdir -p %ZSH_DIR
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM_DIR/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM_DIR/zsh-autosuggestions

chown -R $USER:$USER $ZSH_DIR 
