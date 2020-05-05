export BUNDLE_EDITOR=vim
export EDITOR="vim"

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

source "$HOME/.tmuxinator.bash"

# Take you to the dir of a file in a gem. e.g. `2gem rspec`
2gem () {
  cd "$(dirname $(gem which $1))"
}

# VIM aliases
alias vi="vim"

# Git aliases
alias g="git"
alias gs="git status"
alias gd="git diff --patience --ignore-space-change"
alias gc="git checkout"
alias gb="git branch"
alias ga="git add"
alias gh="git hist"
alias gclean='git branch --merged | grep -v "\*" | grep -v master | xargs -n 1 git branch -d'
alias gsync='git checkout --quiet HEAD; git fetch origin master:master; git checkout --quiet -'

# brew services aliases
alias brewstart="brew services list | ag stopped | awk 'NR>0{ print $1 }' | while read in; do brew services start $in; done"
alias brewstop="brew services list | ag running | awk 'NR>0{ print $1 }' | while read in; do brew services stop $in; done"

# foreman aliases
alias fs="foreman start -c web=0,server=0,all=1"

# RSpec aliases
rspecmodifiedfunction(){
  SPEC_FILES="$(git diff --name-status ${1:-HEAD} | ag -v "assets/(javascripts|stylesheets)" | ag "^M\s*app/" | cut -f 2 | sed  "s/app\/\(.*\)\.rb/spec\/\1_spec\.rb/g")"
  echo "RUNNING:"
  echo "${SPEC_FILES}"
  echo $SPEC_FILES | xargs rspec
}
alias rspec-modified=rspecmodifiedfunction

doxbranch(){
  git checkout -b mr-$1-`ruby -e 'print (0..6).reduce(""){ |x| "#{x}#{Random.new.rand(9)}" }'`
}
alias doxbranch=doxbranch
alias neo4jstart="bundle exec rake neo4j:start[development] neo4j:start[test]"
alias neo4jstop="bundle exec rake neo4j:stop[development] neo4j:stop[test]"
# alias doxagg='bin/rails r "puts DocNews::FeedEntry.select(\"id\").aggregated.order(\"RAND()\").limit(5).map(&:id).join(\",\")" | pbcopy"

# fancy ls command
# -l  long format
# -F  / after dirs, * after exe, @ after symlink
# -G  colorize
# -g suppress owner
# -o suppress group
# -h humanize sizes
# -q print nongraphic chars as question marks
alias l="ls -lFGgohq"

# give the fullpaths of files passed in argv or piped through stdin
function fullpath {
  ruby -e '
    $stdin.each_line { |path| puts File.expand_path path }  if ARGV.empty?
    ARGV.each { |path| puts File.expand_path path }         unless ARGV.empty?
  ' "$@"
}

## MOVE TO LOCAL
# Enable git's tab-completion library
source $HOME/git-completion.bash
source $HOME/git-prompt.sh

# Shortcut for bundle exec
alias be="bundle exec"

# shortcut for checking on timemachine
alias tmsnoop="sudo fs_usage -w -f pathname | grep backupd | grep '(R___'"

## Prompt
#function parse_git_branch {
#  branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
#  if [ "HEAD" = "$branch" ]; then
#    echo "(no branch)"
#  else
#    echo "$branch"
#  fi
#}
#
#function prompt_segment {
#  # for colours: http://en.wikipedia.org/wiki/ANSI_escape_code#Colors
#  # change the 37 to change the foreground
#  # change the 45 to change the background
#  if [[ ! -z "$1" ]]; then
#    echo "\[\033[${2:-30};46m\]${1}\[\033[0m\]"
#  fi
#}
#
#function build_mah_prompt {
#  # time
#  ps1="$(prompt_segment " \@ ")"
#
#  # cwd
#  ps1="${ps1} $(prompt_segment " \w ")"
#
#  # git branch
#  git_branch=`parse_git_branch`
#  if [[ ! -z "$git_branch" ]]
#  then
#    ps1="${ps1} $(prompt_segment " $git_branch " 30)"
#  fi
#
#  # next line
#  ps1="${ps1}\n⚡ "
#
#  # set prompt output
#  PS1="$ps1"
#}

# Colours
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"
       GRAY="\[\033[1;30m\]"

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=true

function parse_git_branch {
  if test -n __git_ps1; then
    # branch_parse="\(([^\s])[\s]([\*\+\$\%<>\=]*)?\)"
    # branch_parse="\(([^ ]*)[ ]?([\*\+\$\%]*)(.*)\)"
    branch_parse="\(([^ \*\+\$\%\<\>\=]*)[ ]?([\*\+\$\%]*)(.*)\)"
    state=""
    # unstaged (*)
    # staged (+)
    # stashed ($)
    # untracked (%)

    # behind (<)
    # ahead (>)
    # diverged (<>)

    if [[ `__git_ps1` =~ $branch_parse ]]; then
      branch=${BASH_REMATCH[1]}
      local_match=${BASH_REMATCH[2]}
      remote_match=${BASH_REMATCH[3]}
      color="${GREEN}"
      state=""
      remote_status=""

      for ((i=0; i < ${#local_match}; i++))
      do
        case ${local_match:$i:1} in
          '*')
            color="${RED}"
            state="$state${RED}⁉";;
          '+')
            color="${GREEN}"
            state="$state${GREEN}‼";;
          '$')
            color="${YELLOW}"
            state="$state${COLOR_NONE}🗒 ";;
          '%')
            color="${YELLOW}"
            state="$state${COLOR_NONE}💩 ";;
        esac
      done

      for ((i=0; i < ${#remote_match}; i++))
      do
        case ${remote_match:$i:1} in
          '<>')
            # diverged
            color="${RED}"
            remote_status="$remote_status${YELLOW}↕️";;
          '>')
            # ahead
            color="${GREEN}"
            remote_status="$remote_status${YELLOW}↑";;
          '<')
            # behind
            color="${RED}"
            remote_status="$remote_status${YELLOW}↓";;
          '=')
        esac
      done

      git_status="$(git status 2> /dev/null)"

      if [[ ! ${git_status}} =~ "working tree clean" ]]; then
        state="$state${RED}⚡"
      fi

      # return the output you want here
      echo "${LIGHT_GRAY}\w $color($branch)${COLOR_NONE}$state$remote_status"
    else
      echo "${LIGHT_GRAY}\w"
    fi
  fi
}

function background_tasks {
  has_jobs="$(jobs -p)"
  echo "${LIGHT_RED} ${has_jobs:+\j bg task}${COLOR_NONE}"
}

#sets what the prompt should be
function prompt_func() {
  previous_return_value=$?;
  prompt="$(parse_git_branch)${COLOR_NONE}"
  if test $previous_return_value -eq 0
  then
    PS1="${GREEN}➜  ${COLOR_NONE}${prompt}${GREEN}${COLOR_NONE}$(background_tasks)\n\$ "
  else
    PS1="${RED}➜  ${COLOR_NONE}${prompt}${RED}${COLOR_NONE}$(background_tasks)\n\$ "
  fi
}

PROMPT_COMMAND=prompt_func

#PROMPT_COMMAND="build_mah_prompt; $PROMPT_COMMAND"

# MOVE TO LOCAL
# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

[[ -f ~/.bashenv.local ]] && source ~/.bashenv.local
