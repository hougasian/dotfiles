# if .bashrc, run it. OS X hits .bash_profile first. 
# For the full exlanation: 
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

# if .bash_prompt, run it. @paul_irish
# https://github.com/paulirish/dotfiles; a lot more here, but love the prompt!

if [ -f ~/.bash_prompt ]; then
   source ~/.bash_prompt
fi
