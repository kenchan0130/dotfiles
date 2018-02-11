# alias
alias rm='rmtrash'
alias orgrm='/bin/rm'
alias sed='gsed'
alias readlink='greadlink'
alias awk='gawk'
 alias awk='gawk'
alias date='gdate'
alias grep='ggrep'
alias tar='gtar'
 alias sha256sum='gsha256sum'

if test -d $HOME/.tools/osx
    set -xg PATH $PATH $HOME/.tools/osx
end

# Android
set -xg PATH $PATH $HOME/Library/Android/sdk/platform-tools

# 画像を表示する君
if begin; type convert >/dev/null 2>&1; and test -d /Applications/iTerm.app; end
    set display_image_path /tmp/background.png
    set image_dir $HOME/.background_images/
    set image_list ""
    for image_file in (ls -F $image_dir | grep -v /)
        set -l file_path $image_dir$image_file
        if test -f $file_path
            set image_list $image_list $file_path
        end
    end
    function background_image
        set -l width (math (tput lines)\*10)
        set -l height (math (tput cols)\*5)
        if test -z "$BUFFER"
            set image_index (math (math (random)%(count $image_list)+1))
            set image_path $image_list[$image_index]
            convert $image_path -resize "$height"x"$width" -size "$height"x"$width" xc:"#353535" +swap -gravity center -composite $display_image_path
            osascript -e "tell application \"iTerm\"
            set current_window to (current window)
            tell current_window
            set current_session to (current session)
            tell current_session
            set background image to \"$display_image_path\"
            end tell
            end tell
            end tell"
        end
    end

    # function fish_user_key_bindings
    #     bind enter background_images
    # end
end

