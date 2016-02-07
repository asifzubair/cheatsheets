# ~/.bashrc: executed by bash(1) for non-login shells.

#If not run interactively, don't do anything
[ -z "$PS1" ] && return

#export PS1='\h:\w\$ '
umask 022 


# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval `dircolors`
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -alh'
alias lh='ls $LS_OPTIONS -l'
alias lt='ls $LS_OPTIONS -alt'
# alias l='ls $LS_OPTIONS -lA'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias em='emacs -nw -fg black -bg white'
alias m='less'
alias moer='less'
alias mroe='less'
alias more='less'
alias l='less'
alias s='source'
alias node="qsub -q cmb -l mem=2000mb,nodes=\$1 -I"
alias anynode="qsub -q cmb -I -l pmem=2000mb,vmem=2000mb -l walltime=24:00:00 -l nodes=1:ppn=1"

alias iqstat='qstat -u asifzuba'
alias qsubi1='qsub -q cegs -l walltime=12:00:00 -l nodes=1:ppn=1 -l mem=5gb -I'
alias qsubi4='qsub -q cegs -l walltime=12:00:00 -l nodes=1:ppn=4 -l mem=3900mb,pmem=3900mb,vmem=3900mb -I'
alias qsubi8='qsub -q cegs -l walltime=12:00:00 -l nodes=1:ppn=8 -l mem=12010mb,pmem=12010mb,vmem=12010mb -I'
alias qsubi12='qsub -q cegs -l walltime=12:00:00 -l nodes=1:ppn=12 -l mem=24101mb,vmem=24101mb -I'
alias qsubi16='qsub -q cegs -l walltime=12:00:00 -l nodes=1:ppn=16 -l mem=31695mb,vmem=31695mb -I'
alias qsubi24='qsub -q cegs -l walltime=12:00:00 -l nodes=1:ppn=24 -l mem=48296mb,vmem=48296mb -I'

alias sdiff='sdiff -w 200'

#alias less='more'
alias vi='vim'
alias gatk='java -jar ${HOME}/bin/GenomeAnalysisTK-3.4-0/GenomeAnalysisTK.jar'


# Sourcels more specifc aliases
if [ -e $HOME/.alias ]
then
    source $HOME/.alias
fi

# If this is an xterm set the title to user@host:dir
case $TERM in
xterm*)
    echo "XTERM"    
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    TERM=xterm
    ;;  
*)
# Define ANSI color sequences
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color
NORMAL="\[\033[0m\]"
BOLD="\[\033[1m\]"
WHITE="\[\033[0;37m\]"
BRIGHTGREEN="\[\033[1;32m\]"
BRIGHTBLUE="\[\033[1;34m\]"
BRIGHTPURPLE="\[\033[1;35m\]"
BRIGHTRED="\[\033[1;31m\]"
BRIGHTCYAN="\[\033[1;36m\]"

# Find out if we are root
if [ $UID -eq 0 ] ; then
# If root make the whole prompt RED
# The # character serves as an extra reminder that I am root

##
## http://askubuntu.com/questions/24358/how-do-i-get-long-command-lines-to-wrap-to-the-next-line
## If you have PS1 configured with colours, make sure you have \\[ inside your 
## PS1 quote preceding the color set.
##

        SYM='#'
        P1="\\[$BRIGHTRED\u$@\h(\w)\n(\$?)$SYM$NORMAL"
        export PS1="$P1"
else
        SYM='>'
        P1="$BOLD\u$BRIGHTPURPLE@$BRIGHTGREEN"
        P2="\h$BRIGHTCYAN(\w$BRIGHTCYAN"
        P3=")\n$BOLD(\$?)$BRIGHTPURPLE$SYM$NORMAL "
        export PS1="\\[$P1$P2$P3"
fi

#if [ -x /usr/usc/gnu/coreutils/default/setup.sh ]; then
#   source /usr/usc/gnu/coreutils/default/setup.sh
#fi
# Define the actual prompt
# This is split up for easier reading

echo "Welcome to $HOSTNAME"

export HOME="/home/cmb-07/sn1/asifzuba"

export R_LIBS="${HOME}/install/rpacks"

#export R_LIBS=$HOME/cmb/R_LIBS

if [ -n "`screen -ls | grep login | grep Detached`" ]; then
    screen -r login;
fi

umask 002

source /usr/usc/git/default/setup.sh

eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`
export MANPATH="$HOME/perl5/man:$MANPATH"
export PERL5LIB="/auto/cmb-07/sn1/asifzuba/software_frozen/brew/linuxbrew/lib/perl5/site_perl:${PERL5LIB}"

export PATH="${HOME}/software_frozen/local/bin:${PATH}"
export PATH="/home/cmb-07/sn1/asifzuba/software_frozen/brew/linuxbrew/sbin:$PATH"
export PATH="/home/cmb-07/sn1/asifzuba/software_frozen/brew/linuxbrew/bin:$PATH"

cd $HOME
