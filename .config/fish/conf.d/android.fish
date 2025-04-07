set -l android_home "$HOME/.local/share/android-sdk"
if test -d "$android_home"
    set -x ANDROID_HOME "$android_home"
    fish_add_path --path "$android_home/build-tools"
    fish_add_path --path "$android_home/platform-tools"
end
