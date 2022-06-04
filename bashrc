#.bashrc

if [ -n "$RCECHO" ]; then
	echo "bashrc"
fi

if [ -z "$PS1" ]; then
	return
elif [ -n "$RCECHO" ]; then
	echo "bashrc: is interactive"
fi

[ -r "$HOME/.shrc" ] && . "$HOME/.shrc"

[ -r "$HOME/bashrc_$TERM_PROGRAM" ] && . "$HOME/bashrc_$TERM_PROGRAM"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
