function installation_bootstrap () {
  # homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # brew package installation
  brew install iterm2 google-chrome zsh-completions neovim

  # p10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
}

installation_bootstrap()
