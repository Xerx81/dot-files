#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\033[1;32m\]\W \[\033[1;37m\]❯ \[\033[0m\]'

# Quick 4K to 1080p AMD VAAPI Video Downscaler (No Audio)
scale1080() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: scale1080 input.mp4 output.mp4"
        return 1
    fi
    ffmpeg -vaapi_device /dev/dri/renderD128 -i "$1" -vf 'format=nv12,hwupload,scale_vaapi=w=1920:h=1080' -c:v h264_vaapi -qp 20 -an "$2"
}
