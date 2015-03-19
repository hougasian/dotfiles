# Privileged access
if [ $UID -ne 0 ]; then
  alias sudo='sudo '
  alias root='sudo -s'
  alias reboot='sudo systemctl reboot'
  alias netctl='sudo netctl'
  alias osxkill='sudo killall -HUP mDNSResponder' # OS X 10.7 & 10.8
  alias osmkill='dscacheutil -flushcache;sudo killall -HUP mDNSResponder' # OS X 10.9 Mavericks
fi

# Colors
# ------------------------------------------------------------
export      NOCOLOR="\033[0m"
export        BLACK="\033[0;30m"
export    DARK_GRAY="\033[1;30m"
export         BLUE="\033[0;34m"
export   LIGHT_BLUE="\033[1;34m"
export        GREEN="\033[0;32m"
export  LIGHT_GREEN="\033[1;32m"
export         CYAN="\033[0;36m"
export   LIGHT_CYAN="\033[1;36m"
export          RED="\033[0;31m"
export    LIGHT_RED="\033[1;31m"
export       PURPLE="\033[0;35m"
export LIGHT_PURPLE="\033[1;35m"
export BROWN_ORANGE="\033[0;33m"
export       YELLOW="\033[1;33m"
export   LIGHT_GRAY="\033[0;37m"
export        WHITE="\033[1;37m"

export LESS_TERMCAP_mb=$'\E'${RED:4}          # begin blinking
export LESS_TERMCAP_md=$'\E'${LIGHT_RED:4}    # begin bold
export LESS_TERMCAP_me=$'\E'${NOCOLOR:4}      # end mode
export LESS_TERMCAP_se=$'\E'${NOCOLOR:4}      # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'        # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E'${NOCOLOR:4}      # end underline
export LESS_TERMCAP_us=$'\E'${LIGHT_GREEN:4}  # begin underline

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Directory control 
# ---------------------------------------------------------------------

alias ls='ls -GhF'                  # linux: --color=auto; Mac: -G 
alias lr='ls -R'                    # recursive ls
alias ll='ls -lG'
alias la='ll -AG'    
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'
alias tree='tree -Csu'     # nice alternative to 'recursive ls'; Don't have tree installed - WHY NOT?

# Add some color to grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
 
# Some other useful stuff
alias ports='netstat -tulanp' # show open ports
alias mkdir='mkdir -pv' # mkdir, create parent 
alias h='history'
alias j='jobs -l'
alias cls='clear'
alias which='type -a'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Some help with du
alias du='du -kh'       # a more readable output.
alias df='df -kTh'

# Make Bash nicer 
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias ..='cd ..'
alias ...='cd ../..'
alias ~="cd ~"

# reloads the prompt, usefull to take new modifications into account
alias reload="source ~/.bashrc"
# grabs the latest .bash_profile file and reloads the prompt
alias updatebashrc="curl https://raw.githubusercontent.com/hougasian/dotfiles/master/.bashrc > ~/.bashrc && reload"

# Memory / Environment
# ---------------------------------------------------------------------
# Memory
alias meminfo='free -m -l -t' # pass options to free 
 
# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
 
# get top process eating cpu 
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
 
alias cpuinfo='lscpu' # Get server cpu info
 
# get GPU ram on desktop / laptop## 
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'


# Network
# ---------------------------------------------------------------------

alias ip="dig +short myip.opendns.com @resolver1.opendns.com" # your public ip
alias localip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"  # your local ip
alias lsnet='sudo lsof -i'                          # lsnet:        Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs
 
# Display useful host related informaton
ii() {
    echo -e "\nYou are logged on ${LIGHT_GREEN}$HOSTNAME${NOCOLOR}"
    echo -e "\nAdditionnal information:$NOCOLOR " ; uname -a
    echo -e "\n${LIGHT_RED}Users logged on:$NOCOLOR " ; w -h
    echo -e "\n${LIGHT_RED}Current date :$NOCOLOR " ; date
    echo -e "\n${LIGHT_RED}Machine stats :$NOCOLOR " ; uptime
    echo -e "\n${LIGHT_RED}Current network location :$NOCOLOR " ; scselect
    echo -e "\n${LIGHT_RED}Public facing IP Address :$NOCOLOR " ;ip
    echo -e "\n${LIGHT_RED}DNS Configuration:$NC " ; scutil --dns
    echo
}


# Quality of life in the terminal
# ---------------------------------------------------------------------

# tab completion for ssh hosts
if [ -f ~/.ssh/known_hosts ]; then
    complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
fi
 
# Tab complete for sudo
complete -cf sudo

gzipsize(){
	echo $((`gzip -c $1 | wc -c`/1024))"KB"
}

# Find files and ignore directories
ff(){
  find . -iname $1 | grep -v .svn | grep -v .sass-cache
}

fif(){
	if [ "$#" -eq 1 ]; then
		grep -nr $1 . --color
	else
		s `grep -nr $1 . | sed -n $2p | cut -d: -f-2`
	fi
}

# cd and ls in one
cl() {
if [ -d "$1" ]; then
  cd "$1"
  ls
  else
  echo "bash: cl: '$1': Directory not found"
fi
}

extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

lowercase()  # move filenames to lowercase
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

# OS X
# ---------------------------------------------------------------------

# VNC
alias vnc='/System/Library/CoreServices/Screen\ Sharing.app/Contents/MacOS/Screen\ Sharing'
# disables shadow on screenshots
# defaults write com.apple.screencapture disable-shadow -bool true

alias reset-cal='rm ~/Library/Calendars/Calendar\ Cache'  # Clear iCal cache

trash () { command mv "$@" ~/.Trash ; }                   # Moves a file to the MacOS trash
ql () { qlmanage -px "$*" >& /dev/null; }                 # Opens any file in MacOS Quicklook Preview

# Web Development
# ---------------------------------------------------------------------

alias ownit='sudo chmod -R o+w /Library/WebServer/Documents'
alias vhosts='sudo vim /etc/apache2/extra/httpd-vhosts.conf'
alias hosts='sudo vim /etc/hosts'
alias dev='cd /Library/WebServer/Documents'
alias a='atom'
alias err="tail -f /var/log/apache2/error_log"
headers () { /usr/bin/curl -I -L $@ ; }                 # Grabs headers from web page

# opens up the IOS Simulator without launching xcode
alias iossimulator="(cd /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/ && open -a iPhone\ Simulator.app)"

# compile sass 
# prerequisites: SASS gem; $gem install sass; MUST be in project $DIR
alias watch:s="echo 'Watching /stylesheets/sass/*.scss and outputting to /stylesheets/*.css' && sass --watch stylesheets/sass:stylesheets" 
alias watch:c="echo 'Watching /javascripts/coffee/*.coffee and outputting to /javascripts/*.js' && coffee -o javascripts -cw javascripts/coffee"

# ruby/rails testing
alias ccmb='clear && bundle exec rake cucumber'
alias ccmb:w='clear && bundle exec rake cucumber:wip'
alias rsp='clear && bundle exec rake spec'

# ruby/rails sunspot
alias solr='bundle exec rake sunspot:solr:start'
alias solr:s='bundle exec rake sunspot:solr:stop'
alias solr:i='bundle exec rake sunspot:solr:reindex'

# rails/rake
alias routes='bundle exec rake routes'
alias migrate='bundle exec rake db:migrate'
alias migrate:r='bundle exec rake db:migrate:reset'

# Generates a random password
randpwd() {
	if [ -z $1 ]; then
		MAXSIZE=10
	else
		MAXSIZE=$1
	fi
	array1=( 
	q w e r t y u i o p a s d f g h j k l z x c v b n m Q W E R T Y U I O P A S D 
	F G H J K L Z X C V B N M 1 2 3 4 5 6 7 8 9 0 
	\! \@ \$ \% \^ \& \* \! \@ \$ \% \^ \& \* \@ \$ \% \^ \& \* 
	) 
	MODNUM=${#array1[*]} 
	pwd_len=0 
	while [ $pwd_len -lt $MAXSIZE ] 
	do 
	    index=$(($RANDOM%$MODNUM)) 
	    echo -n "${array1[$index]}" 
	    ((pwd_len++)) 
	done 
	echo 
}
