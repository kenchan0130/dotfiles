function recho {
    echo -e "\e[31m$*\e[m";
}

function gecho {
    echo -e "\e[32m$*\e[m";
}

function yecho {
    echo -e "\e[33m$*\e[m";
}

function count-line {
    if test -p /dev/stdin
        cat -
    else
        cat "$*"
    end | wc -l | sed 's/^[\t ]*//g'
}

function count-word {
    if test -p /dev/stdin
        cat -
    else
        cat "$*"
    end | wc -w | sed 's/^[\t ]*//g'
}

function csv-viewer {
    if test -p /dev/stdin
        cat -
    else
        cat "$*"
    end | sed 's/,,/, ,/g;s/,,/, ,/g' | column -s, -t
}

set -x EDITOR (which vim)

set -xg PATH $PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin
set -xg PATH $PATH $HOME/tools
set -xg FISH_ROOT $HOME/.config/fish


## Perl
if test -d $HOME/perl5
    bass source $HOME/perl5/perlbrew/etc/bashrc
    bass export PERL5LIB=$HOME/perl5/lib/perl5:$HOME/perl5${PERL5LIB+:$PERL5LIB}
    set -xg PATH $PATH $HOME/perl5/bin
    alias ce='carton exec'
    alias ci='carton install'
fi

## Go
if type go >/dev/null 2>&1
    set -xg GOPATH $HOME/.go
    set -xg PATH $PATH $GOPATH/bin
end

## Node
if test -d $HOME/.nodebrew
    set -xg PATH $PATH $HOME/.nodebrew/current/bin
    function npm-exec {
        set -x PATH $PATH $(npm bin) $@
    }
    alias ne='npm-exec'
    alias ni='npm install'
end

## Ruby
if test -d $HOME/.rbenv
    set -xg PATH $PATH $HOME/.rbenv/bin $HOME/.rbenv/shims
    eval "$(rbenv init -)"
    alias be='bundle exec'
    alias bi='bundle install'
fi

## Java
if test -f /usr/libexec/java_home
    set -xg JAVA_HOME (/usr/libexec/java_home)
fi

## Direnv
if test type direnv >/dev/null 2>&1
    eval "$(direnv hook zsh)"
fi

## The fuck
if test type thefuck >/dev/null 2>&1
    alias fuck='$(thefuck $(fc -ln -1))'
    alias FUCK='$(thefuck $(fc -ln -1))'
fi


switch $OSTYPE
## Mac
case darwin*
    if test -f $FISH_ROOT/settings/osx.fish
        source $FISH_ROOT/settings/osx.fish
    end
## Linux
case linux*
    if test -f $FISH_ROOT/settngs/linux.fish
        source $FISH_ROOT/settings/linux.fish
    end
end


## alias
alias ks='ls'
alias grep='grep --color=always'
alias df='df -h'
alias relogin='exec $SHELL -l'
# rails
alias -g RET='RAILS_ENV=test'
alias -g RED='RAILS_ENV=development'
alias -g RES='RAILS_ENV=staging'
alias -g REP='RAILS_ENV=production'
alias rcs='rails c --sandbox'
# git
alias g='git'
alias gi='git'
alias gcm='git commit -m'
alias gch='git checkout'
alias gd='git diff'
alias gdi='git diff'
alias gdf='git diff'
alias gdc='git diff --cached'
alias gph='git push'
alias gpsh='git push'
alias gpl='git pull'
alias gpll='git pull'
alias gpul='git pull'
alias gf='git fetch'
alias gfc='git fetch'
alias gg='git grep'
alias ggr='git grep'
alias grm='git rm'
alias gre='git reset --merge'


## local
if test -f $HOME/.local.fish
    source $HOME/.local.fish
end
