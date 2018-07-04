# alias
alias rm='rmtrash'
alias orgrm='/bin/rm'
alias sed='gsed'
alias readlink='greadlink'
alias awk='gawk'
alias date='gdate'
alias grep='ggrep'
alias tar='gtar'
alias sha256sum='gsha256sum'

if test -d $HOME/.tools/osx
    set -xg PATH $PATH $HOME/.tools/osx
end

# Android
if test -d $HOME/Library/Android/sdk/platform-tools
    set -xg PATH $PATH $HOME/Library/Android/sdk/platform-tools
end

# 画像を表示する君
if begin; type convert >/dev/null 2>&1; and test -d /Applications/iTerm.app; or test -d $HOME/Applications/iTerm.app; end
    set image_dir $HOME/.background_images/
    set image_list ""
    for image_file_name in (ls -F "$image_dir" | grep -v / | sed 's/@$//')
        set -l image_file_path "$image_dir$image_file_name"
        if test -f $image_file_path
            set image_list $image_list $image_file_path
        end
    end
    function refresh_feeling
        if test -z "$BUFFER"
            set display_image_path /tmp/background_(/usr/bin/uuidgen)_(/bin/date +%s).png
            set -l width (math (tput lines)\*10)
            set -l height (math (tput cols)\*5)
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
            /bin/rm $display_image_path
        else
            echo "You have no buffer."
        end
    end
else
   echo "Refresh feeling is not active. Please install convert command or iTerm.app." >&2
end

