## zhsrc

# alias
# shell command
alias ls='ls -CF'
alias sl='ls -CF'
alias ll='ls -1'
alias lt='ls -1t'
alias la='ls -CFal'
alias lls='tree -N -L 2'
alias lla='tree -a -N -L 2'
alias tls='tmux ls'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias ag='ag -a --color --group'
alias agf='ag -a -g'
alias agh='ag -a -l'
alias diff='colordiff -u'
alias less='less -NR'
alias vi='nvim -u NONE'
alias vim='nvim'
alias vimdiff='nvim -d'
alias wl='wc -l'
alias fzf='fzf-tmux'
alias open='xdg-open'
alias taginit='ctags -R -f .tags'
alias syncinit='cp ~/usr/doc/vim/sync_template.vim ./.pvimrc'
alias markdown='python -m markdown'
alias vcat='(){ if [ -n "${1}" ];then cat $1|sed "s/,/ ,/g"|column -t -s,|less -S; else echo "please specify csv file"; fi }'
alias rfcid='(){ ID=`cat ~/usr/doc/share/rfc/rfc-index.txt|fzf`; if [ -z ${ID} ]; then return 1 ; else echo ${ID}; unset ID ; fi }'
alias gcd='(){ SRCLOC=`ghq list|fzf`; if [ -z ${SRCLOC} ] ; then return 1; else cd ~/.ghq/${SRCLOC}; unset SRCLOC ; fi }'
# git shortcut
alias gs='git status'
alias gd='git diff'
alias gl='git log --stat'
alias glo='git log --oneline'
alias glp='git log -p'
alias gb='git branch'
alias gba='git branch -a'
alias gss='(){ if [ -n "${1}" ];then git stash push -u -m $1; else git stash push -u; fi }'
alias gsx='(){ TARGETSTASH=`git stash list|cut -d':' -f1|fzf`; if [ -z ${TARGETSTASH} ];then echo "DROP not done"; else git stash drop ${TARGETSTASH}; unset TARGETSTASH ;fi }'
alias gsl='git stash list'
alias gsd='git diff `git stash list|cut -d':' -f1|fzf`'
alias gsa='(){ TARGETSTASH=`git stash list|cut -d':' -f1|fzf`; if [ -z ${TARGETSTASH} ];then echo "APPLY not done"; else git stash apply ${TARGETSTASH}; unset TARGETSTASH ;fi }'
alias gsr='(){ TARGETSTASH=`git stash list|cut -d':' -f1|fzf`; if [ -z ${TARGETSTASH} ];then echo "APPLY REVESE not done"; else git stash show ${TARGETSTASH} -p|git apply --reverse; unset TARGETSTASH ;fi }'
# cd shortcut
alias hcd='cd ~/Documents/GoogleDrive/help'
alias ccd='cd ~/.ghq/github.com/sc18naoki/dotfiles/'
alias cds='() { target_path=`cat ~/usr/doc/share/shell/cd_path.dat|fzf`; if [ -z ${target_path} ]; then :;else cd ${target_path};fi }'
# execute on filetype
alias -s html=vivaldi
alias -s md=vivaldi
alias -s vim='nvim -S'
alias -s exe='mono'
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

## plugin(if there were)

# tmux; this line is prerequisite, not working with .zprofile
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux
set -o ignoreeof # stop tmux from exiting with C-d 

# fzf;
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
