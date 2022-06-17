# .zshrc

if [ -n "$RCECHO" ]; then
	echo "zshrc"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

unset path

[ -r "$HOME/.shrc" ] && . "$HOME/.shrc"

PROMPT='%# '

# shorten directory name in prompt
#function zsh_directory_name() {
#  emulate -L zsh
#  [[ $1 == d ]] || return
#  while [[ $2 != / ]]; do
#    if [[ -e $2/.git ]]; then
#      typeset -ga reply=(${2:t} $#2)
#      return
#    fi
#    2=${2:h}
#  done
#  return 1
#}

### vim cursor
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	else
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select

_fix_cursor() {
	echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

### zinit
if [ ! -d $HOME/.zinit/bin ]; then
	git clone https://github.com/zdharma-continuum/zinit.git $HOME/.zinit/bin
fi

. $HOME/.zinit/bin/zinit.zsh


zinit ice depth"1"

#export ZSH_THEME="powerlevel10k/powerlevel10k"
#export POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_unique"
#zinit load romkatv/powerlevel10k

export FZF_BASE="/usr/local/opt/fzf"
export DISABLE_FZF_AUTO_COMPLETION="false"
export DISABLE_FZF_KEY_BINDINGS="false"
zinit light junegunn/fzf

zinit snippet OMZP::git

#zinit light zsh-users/zsh-syntax-highlighting

#zinit light xPMo/zsh-ls-colors

autoload -Uz compinit; compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "/home/ldve/.ghcup/env" ] && source "/home/ldve/.ghcup/env" # ghcup-env

export ZLE_RPROMPT_INDENT=0

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
