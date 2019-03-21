# OS X hits .bash_profile first, load all supporting files here.
# For the full exlanation: # http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
#
#

if [ -f ~/.bash_color ]     ; then source ~/.bash_color     fi
if [ -f ~/.bash_functions ] ; then source ~/.bash_functions fi
if [ -f ~/.bash_alias ]     ; then source ~/.bash_alias     fi
if [ -f ~/.bash_dev ]       ; then source ~/.bash_dev       fi
if [ -f ~/.bashrc ]         ; then source ~/.bashrc         fi
if [ -f ~/.bash_prompt ]    ; then source ~/.bash_prompt    fi
