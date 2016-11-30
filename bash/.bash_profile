export BUNDLE_EDITOR=vim
export GOPATH=$HOME/Work/go-projects
export PATH=$PATH:$GOPATH/bin
export DISABLE_SPRING=true

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

eval "$(rbenv init -)"

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

doxbranch(){
  git checkout -b mr_$1_`ruby -e 'print (0..6).reduce(""){ |x| "#{x}#{Random.new.rand(9)}" }'`
}
alias doxbranch=doxbranch
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

# Enable git's tab-completion library
source /usr/local/etc/bash_completion.d/git-completion.bash

# Shortcut for bundle exec
alias be="bundle exec"

# Prompt
  function parse_git_branch {
    branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    if [ "HEAD" = "$branch" ]; then
      echo "(no branch)"
    else
      echo "$branch"
    fi
  }

  function prompt_segment {
    # for colours: http://en.wikipedia.org/wiki/ANSI_escape_code#Colors
    # change the 37 to change the foreground
    # change the 45 to change the background
    if [[ ! -z "$1" ]]; then
      echo "\[\033[${2:-30};46m\]${1}\[\033[0m\]"
    fi
  }

  function build_mah_prompt {
    # time
    ps1="$(prompt_segment " \@ ")"

    # cwd
    ps1="${ps1} $(prompt_segment " \w ")"

    # git branch
    git_branch=`parse_git_branch`
    if [[ ! -z "$git_branch" ]]
    then
      ps1="${ps1} $(prompt_segment " $git_branch " 30)"
    fi

    # next line
    ps1="${ps1}\n⚡ "

    # set prompt output
    PS1="$ps1"
  }

  PROMPT_COMMAND="build_mah_prompt; $PROMPT_COMMAND"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
