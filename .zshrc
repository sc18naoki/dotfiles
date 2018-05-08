## zhsrc

# alias
# shell command
alias ls='ls -CF'
alias sl='ls -CF'
alias ll='ls -1'
alias lt='ls -1tA'
alias la='ls -CFal'
alias lls='tree -N -L 2'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color=auto'
alias diff='colordiff -u'
alias less='less -N'
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias wl='wc -l'
alias open='xdg-open'
alias gv='grv'
alias fzf='fzf-tmux'
# gui application
# cd shortcut
alias hcd='cd ~/Documents/GoogleDrive/help'
alias ccd='cd ~/usr/src/dotfiles/'
# git alias
alias gam='git add .;git commit -m "update"'

# minor amendment:even for clipboard integration of vim, required.
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# function
# cd-ignore-case
cd () {
  builtin cd "$@" 2>/dev/null && return
  emulate -L zsh
  setopt local_options extended_glob
  local matches
  matches=( (#i)${(P)#}(N/) )
  case $#matches in
    0) # There is no match, even case-insensitively. Try cdpath.
      if ((#cdpath)) &&
         [[ ${(P)#} != (|.|..)/* ]] &&
         matches=( $^cdpath/(#i)${(P)#}(N/) ) &&
         ((#matches==1))
      then
        builtin cd $@[1,-2] $matches[1]
        return
      fi
      # Still nothing. Let cd display the error message.
      builtin cd "$@";;
    1)
      builtin cd $@[1,-2] $matches[1];;
    *)
      print -lr -- "Ambiguous case-insensitive directory match:" $matches >&2
      return 3;;
  esac
}

# tmux; this line is prerequisite, not working with .zprofile
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux
set -o ignoreeof # stop tmux from exiting with C-d 
