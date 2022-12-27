# .profile

if [ -n "$RCECHO" ]; then
	echo "profile"
fi

if [ -r $HOME/.aliases ]; then
	. $HOME/.aliases
fi

#if [ x"${SHELL##*/}" != x"zsh" ]; then
#	export INPUTRC="$HOME/.inputrc"
#	bind -f "$INPUTRC"
#fi

if [ -e /usr/local/nvim ]; then
	EDITOR='nvim'
elif [ -e /usr/local/vim ]; then
	EDITOR='vim'
else
	EDITOR='vi'
fi

export EDITOR
export VISUAL="$EDITOR"

if [ -e '/usr/local/bin/most' ]; then
	PAGER='most'
else
	PAGER='less'
fi
export PAGER

export IRCNICK='DrEuclidean'
export IRCNAME='Fox Mulder'

export BASH_SILENCE_DEPRECATION_WARNING=1

export PKG_CONFIG_PATH='/usr/local/opt/libffi/lib/pkgconfig'

export GTAGSLIBPATH='/usr/lib:/usr/local/lib'
export GTAGSOBJDIRPREFIX='/usr/local/obj'
export GTAGS_OPTIONS='--objdir'

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_VERBOSE=0

export LYNX_CFG="$HOME/.lynx.cfg"

export REPO_AUTOUPDATE="NO"

#if [[ x"$TERM_PROGRAM" == x'iTerm.app' ]]; then
#	export USE_STATUSLINE=1
#fi

# vi: ts=2 sw=2 noexpandtab tw=79:
