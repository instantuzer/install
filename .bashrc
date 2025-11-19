#
# ~/.bashrc
#

eval "$(zoxide init bash)"
source <(fzf --bash)

if [[ "$(tty)" =~ ^/dev/tty[1-6]$ ]]; then
setfont ter-132n
	if [[ ! -f ~/.wifi_done ]]; then
	nmtui
	fi
	touch ~/.wifi_done
#btop -t -u 100
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#### main ####

alias vam='vim $(fzf --preview="bat --color=always {}")'
alias v='vim'

alias f='fzf --preview="bat --color=always {}" --preview-window="right,75%,border-left,<80(up,70%,border-bottom)"'
alias bt='systemctl start bluetooth'

#### pacman ####

alias is='sudo pacman -S'
alias ss='sudo pacman -Ss'
alias qs='sudo pacman -Qs'
alias ql='sudo pacman -Ql'
alias up='sudo pacman -Syu --ignore appname'
alias qi='sudo pacman -Qi'
alias si='sudo pacman -Si'
alias qe='sudo pacman -Qe'
alias qqe='sudo pacman -Qqe'

#### git ####

alias gy='git clone https://aur.archlinux.org/yay ; cd yay ; makepkg -si'
alias gc='printf "name/name\nREPONAME: " && read -rp "" REPO  && git clone https://github.com/$REPO'
alias push='git add . && git commit -m "." && git push'
alias pp='cd ~/lol && git add . && git commit -m "." && git push'
alias gst='git status'
alias gs='git show --name-only'
alias gb='git blame --color-lines $(fzf)'
alias gch='git log -p -U0 --no-prefix'
#alias god='git log -p  --unified=0 | grep -E '^-' | cut -c2-'
alias god='git log -p  --unified=0 | grep -E '^-' | bat'
alias resto='git restore .'
alias gn='gh repo create --private --source=. --remote=origin'
alias gl='git log -p --follow --'

alias sto='stow --adopt --no-folding .'

alias cb='cat ~/.bashrc'
alias key='cat ~/.config/i3/config | grep'
alias wk='~/.config/i3/wttr.sh'

alias ls='eza -la'
alias cl='read -rp "FILENAME: " CLIP && cat $CLIP | xclip -selection clipboard'
alias hi='history'
alias find='fzf'
alias se="sudoedit"
alias vi='vim'
alias nvim='vim'
alias ff='fastfetch'
alias b='btop -t'
alias m='tmux'
alias conf='vim ~/.config/i3/config'
alias c='startx'
alias t='echo '' && date && echo '' && cal -m'
alias zl='unzip -l'

alias cls='clear'
alias clr='clear'

alias bsh='vim ~/.bashrc'
alias sobash='source ~/.bashrc'


#PS1="\u@\h \$ "
#PS1=' $(date +"%T") \$ '
#PS1='\[\e[38;5;214m\] $(date +"%T") \$ \[\e[0m\]'
t
#PS1='\n \[\e[38;5;214m\]$PWD 😺  '
PS1='\n \[\e[38;5;214m\]$PWD 😺  '
