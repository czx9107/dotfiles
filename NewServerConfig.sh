#!/bin/bash

apt-get update
apt-get install -y zsh git stow

USER="wei"
PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4mRina55ndyjFgdphpIp01lk1daal3kWf7+jp0FM9S wei@PUS"
ZSH_DIR="/home/$USER/.zsh_plugins"
DOTFILES_DIR="config"

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
chmod 600 /home/$USER/.ssh/authorized_keys

# Install plugins for zsh
mkdir -p $ZSH_DIR
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_DIR/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_DIR/zsh-autosuggestions

chown -R $USER:$USER $ZSH_DIR 

# Install own dotfiles
sudo -u $USER bash <<EOF
cd /home/$USER
git clone https://github.com/czx9107/dotfiles $DOTFILES_DIR
cd $DOTFILES_DIR

rm -f /home/$USER/.zshrc
rm -f /home/$USER/.bashrc

stow vim
stow nvim
stow tmux
stow zsh
EOF

sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

echo "Setup complete!"
