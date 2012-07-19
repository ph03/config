# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.

if [ -f /etc/profile.d/bash-completion.sh ]; then
  source /etc/profile.d/bash-completion.sh
fi

export LC_TIME="de_DE.utf8"

##SVN+GIT

scm_ps1() {
  local s
  s=$(svn info 2>/dev/null)
  if [ $? -eq 0 ]; then
    s=\(svn:$(echo -n "${s}" | sed -n -e '/^Revision: \([0-9]*\).*$/s//\1/p' )\)
    s="${s} "
  else
    s=$(__git_ps1 "(git:%s) ")
  fi
  echo -n "$s"
}

#export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\]"
# = martinez@phoenix ~/ProjVC/vclibs $

#export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
# = [martinez@phoenix vclibs (master=)]$

#export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w $(__git_ps1 " (%s)")\$ \[\033[00m\]'
# = martinez@phoenix ~/ProjVC/isomdef  (master=)$

export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w $(scm_ps1)\$ \[\033[00m\]'

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"

export GIT_SSL_NO_VERIFY=1
##

#export CGAL_MAKEFILE="/usr/local/share/cgal/cgal.mk"

export PATH=":/home/martinez/bin:/home/martinez/.local/bin:/usr/lib64/ccache/bin:/usr/lib/colorgcc/bin:$PATH"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

#export LIBXCB_ALLOW_SLOPPY_LOCK=1

export MAPLE="/opt/maple"

#if [ -f /usr/share/mc/mc.sh ]; then
   . /usr/libexec/mc/mc.sh
#fi

export PROJROOT="/home/martinez/ProjMPI"
export PROJVC="/home/martinez/ProjVC"

export RI="--format ansi --width 70"

#export PYTHONSTARTUP="/home/martinez/.pythonrc"
#export PYTHONPATH="/usr/local/lib64/python2.5/site-packages"

#MCGL
export PATH="/home/martinez/ProjMPI/MCGL/impexp:$PATH"
#export MATLABPATH="/home/martinez/ProjMPI/MCGL:$MATLABPATH"
#export MATLABPATH="/home/martinez/ProjMPI/Matlab/base"
#export MATLABPATH="/home/martinez/ProjMPI/SG08:$MATLABPATH"

#export MATLABPATH="/home/martinez/ProjVC/vc-mp09-public/matlab:$MATLABPATH"

#Matlab
export MATLABPATH="/home/martinez/.local/pkg/plot2svg:$MATLABPATH"
export MATLABPATH="/home/martinez/ProjVC/scratch/matlab/utils:$MATLABPATH"


#Jacket
#export MATLABPATH="/home/martinez/local/pkg/jacket/engine:$MATLABPATH"
#export LD_LIBRARY_PATH="/home/martinez/local/pkg/jacket/engine/lib64:$LD_LIBRARY_PATH"

#export VTK_DATA_ROOT="/home/martinez/local/pkg/VTKData"

#CULA
#export CULA_ROOT="/home/martinez/local/pkg/cula"
#export CULA_INC_PATH="$CULA_ROOT/include"
#export CULA_BIN_PATH_32="$CULA_ROOT/bin"
#export CULA_BIN_PATH_64="$CULA_ROOT/bin64"
#export CULA_LIB_PATH_32="$CULA_ROOT/lib"
#export CULA_LIB_PATH_64="$CULA_ROOT/lib64"
#export LD_LIBRARY_PATH="$CULA_LIB_PATH_64:$LD_LIBRARY_PATH"

#bashcomp
#source /etc/profile.d/bash-completion.sh

#NVSG
#export NVSGSDKHOME="/usr/local/nvsg-sdk"

#VTKLibs
export VTKLIBS="-L/usr/lib64 -lvtkCommon -lvtkDICOMParser -lvtkFiltering -lvtkGenericFiltering -lvtkGraphics -lvtkHybrid -lvtkIO -lvtkImaging -lvtkNetCDF -lvtkRendering -lvtkVolumeRendering -lvtkWidgets"
export VTKCFLAGS="-I/usr/include/vtk-5.4"

#Static CUDPPD
#export CUDPPDLIB="/home/martinez/workspace/cuda/cudpp/lib/libcudpp64.a"
#export CUDPPDLIBEMU="/home/martinez/workspace/cuda/cudpp/lib/libcudpp64_emu.a"

#meshlab
export PATH="/home/martinez/.local/pkg/meshlab_svn/meshlab/src/distrib:$PATH"

#VL
export VL_VERBOSITY_LEVEL="NORMAL"
export VL_ROOT="/opt/VL/VC"

#tetgen
export PATH="/home/martinez/local/pkg/tetgen1.4.3:$PATH"

#poclbm
export PATH="/home/martinez/local/pkg/poclbm:$PATH"

#if [[ -f "${HOME}/.gentoo/java-env-classpath" ]]; then
#  source ${HOME}/.gentoo/java-env-classpath
#fi

export MKL_THREADING_LAYER=GNU

#enable vi mode
set -o vi

#gibo (github gitignore boilerplate)
export PATH="/home/martinez/.local/pkg/gitignore-boilerplates:$PATH"
source /home/martinez/.local/pkg/gitignore-boilerplates/gibo-completion.bash

#export PATH="/home/martinez/.local/pkg/SublimeText2:$PATH"
alias config='git --git-dir=/home/martinez/.config.git/ --work-tree=/home/martinez'
