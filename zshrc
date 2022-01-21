# .zshrc


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi


unset path

[ -r "$HOME/.rc" ] && . "$HOME/.rc"

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

ZVM_CURSOR_STYLE_ENABLED=false
#zinit light jeffreytse/zsh-vi-mode

autoload -Uz compinit; compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
