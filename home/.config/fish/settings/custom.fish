set -xg FISH_ROOT $HOME/.config/fish
set -xg PATH $PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin

## local
if test -f $HOME/.local.fish
    source $HOME/.local.fish
end

## bobthefish

set -g theme_color_scheme solarized

## fish-ghq
set -g GHQ_SELECTOR peco
set -g GHQ_SELECTOR_OPTS "--prompt='ghq>'"

## custom functions

function recho
    echo -e "\e[31m$argv\e[m";
end

function gecho
    echo -e "\e[32m$argv\e[m";
end

function yecho
    echo -e "\e[33m$argv\e[m";
end

function csv-viewer
    set -l v
    if [ $argv ]
        cat "$argv" | while read line
            set v $v $line
        end
    else
        while read line
            set v $v $line
        end
    end
    sed 's/,,/, ,/g;s/,,/, ,/g' <(printf "%s\n" $v | psub) | nkf -w | column -s, -t | less -#2 -N -S
end

function remove-color
    set -l v
    if [ $argv ]
        cat "$argv" | while read line
            set v $v $line
        end
    else
        while read line
            set v $v $line
        end
    end
    sed -r 's/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g' <(printf "%s\n" $v | psub)
end

function relogin
    eval $SHELL -l
end

function peco-z
    z -l 2> /dev/null | awk '{ print $2 }' | peco --prompt='cd>' | read recent
    if [ $recent ]
        cd $recent
        commandline -f repaint
    end
end

function peco-find-directory
    [ $argv ]; and set cmd "$argv"; or set cmd "cd"
    if type fd >/dev/null 2>&1
        fd . -t d --max-depth 4 -E .git/ -E .history/ | peco --prompt="$cmd>" | read recent
    else
        find . -type d -maxdepth 4 | grep -v .git | grep -v .history | peco --prompt="$cmd>" | read recent
    end

    if [ $recent ]
        $cmd $recent
        commandline -f repaint
    end
end

function yaml2json
    set -l v
    if [ $argv ]
        cat "$argv" | while read line
            set v $v $line
        end
    else
        while read line
            set v $v $line
        end
    end

    ruby -ryaml -rjson -e 'puts JSON.pretty_generate(YAML.load(STDIN.read))' <(printf "%s\n" $v | psub)
end

function json2yaml
    set -l v
    if [ $argv ]
        cat "$argv" | while read line
            set v $v $line
        end
    else
        while read line
            set v $v $line
        end
    end

    ruby -ryaml -rjson -e 'puts YAML.dump(JSON.parse(STDIN.read))' <(printf "%s\n" $v | psub)
end

## Perl
if test -d $HOME/perl5
    source $HOME/perl5/perlbrew/etc/perlbrew.fish
    bass 'export PERL5LIB=$HOME/perl5/lib/perl5:$HOME/perl5${PERL5LIB+:$PERL5LIB}'
    set -xg PATH $PATH $HOME/perl5/bin
    alias ce='carton exec'
    alias ci='carton install'
end

## Go
if type go >/dev/null 2>&1
    set -xg GOPATH $HOME/.go
    set -xg GOBIN $GOPATH/bin
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
if type rbenv >/dev/null 2>&1
    set -xg PATH $PATH $HOME/.rbenv/shims
    rbenv init - | source
    alias be='bundle exec'
    alias bi='bundle install'
end

## Python
if type pyenv >/dev/null 2>&1
    mkdir -p $HOME/.pyenv/bin
    set -xg PYENV_ROOT $HOME/.pyenv
    set -xg PATH $PATH $PYENV_ROOT/bin
    eval (pyenv init - | source) >/dev/null 2>&1
    eval (pyenv virtualenv-init - | source) >/dev/null 2>&1
end

# Java
bass "source $SDKMAN_DIR/bin/sdkman-init.sh"

## Direnv
if type direnv >/dev/null 2>&1
    eval (direnv hook fish)
end

## kubectx
if type kubectx >/dev/null 2>&1
    function kubectx-switch
        kubectx | peco --prompt='kubectx>' | read recent
        if [ $recent ]
            kubectx $recent
            commandline -f repaint
        end
    end
end

## homesick
if test -d $HOME/.homesick
    source $HOME/.homesick/repos/homeshick/homeshick.fish
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
# kubectl
alias k='kubectl'
# git
alias g='git'
alias gi='git'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch'
alias gg='git grep'
alias ggr='git grep'
alias grm='git rm'
alias gst='git status'

function gch
    git branch -a --sort=-authordate | grep -v -e '->' -e '*' | perl -pe 's/^\h+//g' | perl -pe 's#^remotes/origin/###' | perl -nle 'print if !$c{$_}++' | peco --prompt='git checkout>' | xargs git checkout
end

## 2 times because 2 times because local priority is high
if test -f $HOME/.local.fish
    source $HOME/.local.fish
end

set -xg EDITOR (which vim)

## triggered by key binding
function fish_user_key_bindings
    # Set fish default mode as insert
    fish_vi_key_bindings insert

    bind \cr 'peco_select_history (commandline -b)'
    bind -M insert \cr 'peco_select_history (commandline -b)'

    bind \ch 'peco-z'
    bind -M insert \ch 'peco-z'

    bind \cf 'peco-find-directory'
    bind -M insert \cf 'peco-find-directory'

    if type refresh_feeling >/dev/null 2>&1
        # This mean is Kanna bind!
        bind \ck 'refresh_feeling'
        bind -M insert \ck 'refresh_feeling'
    end
end

