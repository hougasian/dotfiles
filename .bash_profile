# OS X hits .bash_profile first, load all supporting files here.
# For the full exlanation: # http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
#
#

if [ -f ~/.bashrc ]       ; then source ~/.bashrc         fi
if [ -f ~/.bash_prompt ]  ; then source ~/.bash_prompt    fi
if [ -f dnvm.sh ]         ; then source dnvm.sh           fi    # Load .Net VMupgrade
