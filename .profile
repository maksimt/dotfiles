# append to the history file, don't overwrite it
shopt -s histappend
set -o vi
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=no
HISTFILESIZE=no

#brew install bash-git-prompt
GIT_PROMPT_ONLY_IN_REPO=1
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
		  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
		    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi	


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
ulimit -n 4096
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alLt'
alias la='ls -A'
alias l='ls -CF'

#export PATH=/Developer/NVIDIA/CUDA-8.0/bin${PATH:+:${PATH}}
#export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-8.0/lib\
#		 ${DYLD_LIBRARY_PATH:+:${DYLD_LIBRARY_PATH}}

# added by Anaconda2 4.3.1 installer
export PATH="/Users/maks/anaconda/bin:$PATH"
sshfs server: /Users/maks/server -o follow_symlinks 2>/dev/null 1>/dev/null || true
alias gs="git status"
alias gd="git diff"
alias gl="git log"
alias gh="git show" 
alias tmuxnew="tmux new-session -t"
alias tmuxd="tmux detach"
alias tmuxa="tmux -CC attach -t"

alias go='/usr/local/go/bin/go'
alias gofmt='/usr/local/go/bin/gofmt'
export GOROOT='/usr/local/go'

alias stat="stat -x"
alias dc='docker-compose'

function note() {
text=$@
datev=$(date +%Y%m%d)
echo "${datev} ${text}" >> ~/notes.txt
}
