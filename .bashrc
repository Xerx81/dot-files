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

# yt-dlp command to download YouTube videos in 720p
dl720() {
    if [ -z "$1" ]; then
        echo "Usage: dl720 <YouTube_URL> [Optional_Output_Name]"
        return 1
    fi

    if [ -z "$2" ]; then
        # If no output name is provided, use the default YouTube title
        yt-dlp -f "bv*[height<=720]+ba/b[height<=720]" --merge-output-format mp4 "$1"
    else
        # If an output name is provided, save it as that name
        yt-dlp -f "bv*[height<=720]+ba/b[height<=720]" --merge-output-format mp4 -o "$2.%(ext)s" "$1"
    fi
}

export PATH=$PATH:/home/yuvraj/.spicetify
