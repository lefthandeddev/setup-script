#!/bin/bash -i

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

function echo_success() {
    echo -e "${GREEN}${@}${RESET}"
}

function echo_warn() {
    echo -e "${YELLOW}${@}${RESET}"
}

function echo_fail() {
    echo -e "${RED}${@}${RESET}"
}

function echo_step() {
    echo -e "${BLUE}${@}${RESET}"
}

echo_step "💻 Setting up your machine!"
echo_warn "You may be asked for your password 🔑"


echo_step "Installing dependencies..."

sudo dnf update -y > /dev/null
sudo dnf install -y wget git zsh > /dev/null

echo_success "Done! 😃"


echo_step "Setting up Zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    wget -O - https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash > /dev/null
fi

# TODO: Configure .zshrc
echo_success "Ok! 👌"


echo_step "Installing node with nvm..."

if [ ! -d "$HOME/.nvm" ]; then
    wget -O - https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash > /dev/null

    source $HOME/.nvm/nvm.sh
    source $HOME/.profile
    source $HOME/.bashrc
fi

if  ! command -v nvm > /dev/null; then
    echo_fail "Something went wrong with nvm 🤷‍♂️"
    exit -1
fi

nvm install node > /dev/null

echo_success "Success! 😺"

if  ! command -v code > /dev/null; then
    echo_step "Installing VS Code..."

    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc > /dev/null
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' > /dev/null

    sudo dnf check-update -y > /dev/null
    sudo dnf install -y code > /dev/null
fi

echo_success "Great! 😀"


echo_warn "You may need to restart your terminal 💻"
echo_success "🎉🎉🎉 Finished! 🎉🎉🎉"
