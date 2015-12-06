# alias
alias rm='rmtrash'
alias orgrm='/bin/rm'
alias sed='gsed'
alias readlink='greadlink'
alias awk='gawk'
alias date='gdate'
alias grep='ggrep'
alias tar='gtar'

if test -d $HOME/.tools/osx
    set -xg PATH $PATH $HOME/.tools/osx
end

# 画像を表示する君
if type convert >/dev/null 2>&1 && test -d /Applications/iTerm.app
    set display_image_path /tmp/background.png
    set image_dir $HOME/dotfiles/background_images/
    for set -l image_file in (ls -F $image_dir | grep -v /)
        set file_path $image_dir$image_file
        if test -f $file_path
            set image_list $image_file $file_path
        end
    end
    function background-image {
        set width (((tput lines)*10))
        set height (((tput cols)*5))
        if test -z $BUFFER
            set image_index (((RANDOM%$#image_list)+1))
            set image_path $image_list[$image_index]
            convert $image_path -resize "$height"x"$width" -size "$height"x"$width" xc:"#353535" +swap -gravity center -composite $display_image_path
            osascript -e "tell application \"iTerm\"
            set current_terminal to (current terminal)
            tell current_terminal
            set current_session to (current session)
            tell current_session
            set background image path to \"$display_image_path\"
            end tell
            end tell
            end tell"
            zle reset-prompt
            zle accept-line
        else
            zle accept-line
        end
    }
    zle -N background-image
    bindkey '^m' background-image
end

# Android
set -xg PATH $PATH $HOME/Library/Android/sdk/platform-tools
