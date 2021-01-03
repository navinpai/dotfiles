# aliases
alias x="exit"
alias rm='rm -i'

alias gcm="git checkout master"
alias gdom="git diff origin/master"
alias gdomn="git diff origin/master -- name-only"
alias gc="git checkout"
alias gb="git branch"
alias gp="git pull"
alias gl="git log"
alias grh="git reset --hard HEAD"
alias gmm="git merge master"
alias gs="git status"

# functions
function setjdk {
  local ver=${1?Usage: setjdk <version>}

  export JAVA_HOME=$(/usr/libexec/java_home -v $ver)
  PATH=$(echo $PATH | tr ':' '\n' | grep -v Java | tr '\n' ':')
  export PATH=$JAVA_HOME/bin:$PATH
}

function jdk_version() {
  running_version=$(java -version 2>&1 | awk -F '"' 'NR==1 {print substr($2,1,3)}')
  if [[ $running_version -eq '11.' ]] then
      echo " (11)"
  elif [[ $running_version -eq '1.8' ]] then
      echo " (1.8)"
  fi
}

autoload -Uz jdk_version


function mkcd() {
  dir="$*";
  mkdir -p "$dir" && cd "$dir";
}

autoload -Uz mkcd

# Don't need this for zsh
# parse_git_branch() {
#    git branch 2> /dev/null | sed -e '/^[^]/d' -e 's/ \(.*\)/ (\1):/'
# }

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'

setopt PROMPT_SUBST
PROMPT='%F{blue}%n%F{white}@%F{green}%m%F{cyan}$(jdk_version)%F{red}${vcs_info_msg_0_} %F{yellow}%~%f $ '
