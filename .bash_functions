# Display useful host related informaton
ii() {
  echo -e "\nYou are logged on ${CYAN}$HOSTNAME${NOCOLOR}"
  echo -e "\n${LIGHT_RED}Additionnal information :$NOCOLOR " ; uname -a
  echo -e "\n${LIGHT_RED}Users logged on :$NOCOLOR " ; w -h
  echo -e "\n${LIGHT_RED}Current date :$NOCOLOR " ; date
  echo -e "\n${LIGHT_RED}Machine stats :$NOCOLOR " ; uptime
  echo -e "\n${LIGHT_RED}Current network location :$NOCOLOR " ; scselect
  echo -e "\n${LIGHT_RED}Public facing IP Address :$NOCOLOR " ;ip
  echo -e "\n${LIGHT_RED}Local network IP Address :$NOCOLOR " ;ip
  #echo -e "\n${LIGHT_RED}DNS Configuration:$NOCOLOR " ; scutil --dns
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

gzipsize() {
  echo $((`gzip -c $1 | wc -c`/1024))"KB"
}

# Find files and ignore directories
ff() {
  find . -iname $1 | grep -v .svn | grep -v .sass-cache
}

fif() {
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

extract() {     # Handy Extract Program.
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

lowercase() {  # move filenames to lowercase
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

trash () { command mv "$@" ~/.Trash ; }                   # Moves a file to the MacOS trash
ql () { qlmanage -px "$*" >& /dev/null; }                 # Opens any file in MacOS Quicklook Preview

headers () { /usr/bin/curl -I -L $@ ; }                 	# Grabs headers from web page

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

# Switch to dev directory and remove and DS_Store files
dev() {
  cd /Library/WebServer/Documents
  # delete all .DS_Store files
  find . "-name" ".DS_Store" -exec rm {} \;
  clear
  ll
}
