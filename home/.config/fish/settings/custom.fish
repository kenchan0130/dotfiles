function recho
    echo -e "\e[31m$argv\e[m";
end

function gecho
    echo -e "\e[32m$argv\e[m";
end

function yecho
    echo -e "\e[33m$argv\e[m";
end

function count-line
    set -l v ""
    if test -p /dev/stdin
        set v (cat -)
    else
        set v (cat "$argv")
    end
    echo $v | wc -l | sed 's/^[\t ]*//g'
end

function count-word
    set -l v ""
    if test -p /dev/stdin
        set v (cat -)
    else
        set v (cat "$argv")
    end
    echo $v | wc -w | sed 's/^[\t ]*//g'
end

function csv-viewer
    set -l v ""
    if test -p /dev/stdin
        set v (cat -)
    else
        set v (cat "$argv")
    end
    echo $v | sed 's/,,/, ,/g;s/,,/, ,/g' | column -s, -t
end

set -x EDITOR (which vim)

set -xg PATH $PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin
set -xg PATH $PATH $HOME/tools
set -xg FISH_ROOT $HOME/.config/fish


## Perl
if test -d $HOME/perl5
    bass source $HOME/perl5/perlbrew/etc/bashrc
    bass 'export PERL5LIB=$HOME/perl5/lib/perl5:$HOME/perl5${PERL5LIB+:$PERL5LIB}'
    set -xg PATH $PATH $HOME/perl5/bin
    alias ce='carton exec'
    alias ci='carton install'
end

## Go
if type go >/dev/null 2>&1
    set -xg GOPATH $HOME/.go
    set -xg PATH $PATH $GOPATH/bin
end

## Node
if test -d $HOME/.nodebrew
    set -xg PATH $PATH $HOME/.nodebrew/current/bin
    function npm-exec
        set -x PATH $PATH (npm bin) $argv
    end
    alias ne='npm-exec'
    alias ni='npm install'
end

## Ruby
if test -d $HOME/.rbenv
    set -xg PATH $PATH $HOME/.rbenv/bin $HOME/.rbenv/shims
    alias be='bundle exec'
    alias bi='bundle install'

    function rbenv
        functions -e rbenv
        rbenv init - fish >/dev/null ^&1
        rbenv $argv
    end
end

## Java
if test -f /usr/libexec/java_home
    set -xg JAVA_HOME (/usr/libexec/java_home)
end

## Direnv
if type direnv >/dev/null 2>&1
    eval (direnv hook fish)
end

## The fuck
if type thefuck >/dev/null 2>&1
    function fuck
        thefuck (fc -ln -1)
    end
    function FUCK
        fuck
    end
end


switch (uname)
    ## Mac
    case Darwin
        if test -f $FISH_ROOT/settings/osx.fish
            source $FISH_ROOT/settings/osx.fish
        end
    ## Linux
    case Linux
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
alias RET='RAILS_ENV=test'
alias RED='RAILS_ENV=development'
alias RES='RAILS_ENV=staging'
alias REP='RAILS_ENV=production'
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
alias gst='git status'
alias gre='git reset --merge'


## local
if test -f $HOME/.local.fish
    source $HOME/.local.fish
end