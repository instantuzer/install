#
# ~/.bashrc
#

if [[ "$(tty)" =~ ^/dev/tty[1-6]$ ]]; then
setfont ter-132n
btop -t -u 100
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
 
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
alias gs='git status'
alias gl='git show --name-only'
alias gb='git blame $(fzf)'
alias resto='git restore .'

alias sto='stow --adopt --no-folding .'

alias a='cat ~/.bashrc'
alias k='cat /home/d/.config/i3/config | grep'
alias wk='/home/d/.config/i3/wttr.sh'

alias ls='eza -la'
alias cl='read -rp "FILENAME: " CLIP && cat $CLIP | xclip -selection clipboard'
alias hi='history'
alias find='fzf'
alias se="sudoedit"
alias vi='vim'
alias vim='vim'
alias ff='fastfetch'
alias b='btop -t'
alias m='tmux'
alias conf='vim /home/d/.config/i3/config'
alias c='startx'
alias t='echo '' && date && echo '' && cal -m' 

alias cls='clear'
alias clr='clear'

alias bsh='vim ~/.bashrc'
alias sobash='source ~/.bashrc'

alias f='fzf --preview="bat --color=always {}"'
alias vam='vim $(fzf --preview="bat --color=always {}")'

alias cd='z'
eval "$(zoxide init bash)"
source <(fzf --bash)

#PS1="\u@\h \$ "
#PS1=' $(date +"%T") \$ '
#PS1='\[\e[38;5;214m\] $(date +"%T") \$ \[\e[0m\]'
t
PS1='\n \[\e[38;5;214m\]$(pwd) \n\n 😺 '
