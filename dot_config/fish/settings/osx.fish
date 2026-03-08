# alias
alias sed='gsed'
alias readlink='greadlink'
alias awk='gawk'
alias date='gdate'
alias grep='ggrep'
alias tar='gtar'
alias sha256sum='gsha256sum'
alias vim='mvim -v'

if test -d (brew --prefix)/bin
    set -xg PATH (brew --prefix)/bin $PATH
end

if test -d $HOME/.tools/osx
    set -xg PATH $PATH $HOME/.tools/osx
end

# Android
if test -d $HOME/Library/Android/sdk/platform-tools
    set -xg PATH $PATH $HOME/Library/Android/sdk/platform-tools
end

# gcloud
if test -f (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
    source (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
end

# MySQL Client
if test -d (brew --prefix)/opt/mysql-client/bin
    fish_add_path (brew --prefix)/opt/mysql-client/bin
end

# goss
if test -f $HOME/.goss/goss
    set -xg GOSS_PATH $HOME/.goss/goss
end

if test -d /Applications/Secretive.app/
	set -xg SSH_AUTH_SOCK $HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
end
