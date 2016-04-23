#!/bin/sh
echo "clone mac-provisioning repository..."
git clone https://github.com/kagemiku/mac-provisioning.git mac-provisioning \
    && cd mac-provisioning \
    && echo "success" \
    || {echo "failure"; exit 1}

echo "install dotfiles..."
git clone https://github.com/kagemiku/dotfiles.git ~/dotfiles \
    && ~/dotfiles/install.sh \
    && source ~/.bash_profile \
    && echo "success" \
    || {echo "faiure"; exit 1}

echo "install xcode tools..."
sudo xcodebuild -license \
    && xcode-select --install \
    && echo "success" \
    || {echo "failure"; exit 1}

echo "install homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
    && echo "success" \
    || {echo "failure"; exit 1}

echo "install ansible..."
brew install python \
    && brew install ansible \
    && echo "success" \
    || {echo "failure"; exit 1}

echo "execute ansible-playbook..."
cd ansible \
    && ansible-playbook -i hosts localhost.yml \
    && cd - \
    && echo "success" \
    || {echo "failure"; exit 1}

echo "install zplug..."
git clone https://github.com/b4b4r07/zplug ~/.zplug \
    && chsh -s /bin/zsh \
    && source ~/.zshrc \
    && echo "success" \
    || {echo "failure"; exit 1}

exit 0
