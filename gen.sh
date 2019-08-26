#!/usr/bin/env bash

CONFIG_PATH=`pwd`/config

exists() {
    command -v "$1" >/dev/null 2>&1
}

program_exists() {
    local ret='0'
    exists "$1" || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ];
    then
        return 1
    fi

    return 0
}

# basic key binding
cat ${CONFIG_PATH}/tmux.basic.conf  > tmux.conf

# In Mac, You'd better to do : `brew install reattach-to-user-namespace`
if program_exists "reattach-to-user-namespace";
then
    (cat <<REATTACH_TO_USER_NAMESPACE
# Mac 下 tmux 使用系统剪贴板
set-option -g default-command "reattach-to-user-namespace -l $SHELL"

REATTACH_TO_USER_NAMESPACE
) >> tmux.conf
fi

# not change window name automatically
cat ${CONFIG_PATH}/tmux.not-change-window-name.conf >> tmux.conf

# bottom statusbar
cat ${CONFIG_PATH}/tmux.status.conf >> tmux.conf

# colors
cat ${CONFIG_PATH}/tmux.colors.conf >> tmux.conf

# mouse support according to tmux version
tmux_version_major=`tmux -V | cut -d' ' -f2 | cut -d'.' -f1`
tmux_version_minor=`tmux -V | cut -d' ' -f2 | cut -d'.' -f2`

echo "# tmux 和 vim 的鼠标滚动冲突, 如果选择 vim 的鼠标滚动, 那么禁用下面这些鼠标支持配置" >> tmux.conf
if [ $tmux_version_major -eq 2 -a $tmux_version_minor -lt 1 ] || [ $tmux_version_major -le 1 ]
then
    cat ${CONFIG_PATH}/tmux.mouse1.conf >> tmux.conf
else
    cat ${CONFIG_PATH}/tmux.mouse2.conf >> tmux.conf
fi
