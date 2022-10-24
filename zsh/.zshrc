# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# bootstrap todo: clone p10k
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"


setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
# unsetopt HIST_SAVE_NO_DUPS       # Write a duplicate event to the history file

# Alias
source ./aliases

# Completion
_comp_options+=(globdots) # With hidden files
# source /my/path/to/zsh/completion.zsh # see https://thevaluable.dev/zsh-completion-guide-examples/
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
autoload -Uz compinit
compinit

# Directory Stack, use command 'dirs -v'
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

export CLICOLOR=1

