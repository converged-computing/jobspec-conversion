#!/bin/bash
#FLUX: --job-name=xad.txt
#FLUX: -t=3600
#FLUX: --urgency=16

export __Init_Default_Modules='1'
export TMOUT='7200'
export QT_GRAPHICSSYSTEM_CHECKED='1'
export SACCT_FORMAT='JobID%20,JobName,User,Partition,NodeList,Elapsed,State,ExitCode,MaxRSS,AllocTRES%32'
export LMOD_ANCIENT_TIME='86400'
export SHELL='/bin/bash'
export EBVERSIONMINICONDA3='4.9.2'
export HISTSIZE='1000'
export MANPATH='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/share/man:/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/man:/opt/scc/conda/software/Miniconda3/4.9.2/share/man:/usr/local/apps/lmod/lmod/share/man::'
export XDG_RUNTIME_DIR='/run/user/10355'
export SQUEUE_FORMAT='%20i %20u %20a %20P %10Q %5D %5C %11l %11L %18R %40j'
export FPATH='/usr/local/apps/lmod/lmod/init/ksh_funcs'
export __LMOD_REF_COUNT_MODULEPATH='/usr/local/scc/modulefiles/all:1;/usr/local/scc/modulefiles/quarantine:1;/usr/local/scc/modulefiles/other:1;/usr/local/apps/lmod/8.4.20/modulefiles/Core:1;/etc/modulefiles:1'
export LMOD_SETTARG_FULL_SUPPORT='no'
export CONDA_ENV='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11'
export XDG_SESSION_ID='3183'
export HOSTNAME='scclogin01.camhres.ca'
export LMOD_ROOT='/usr/local/apps/lmod'
export _ModuleTable002_='MDAwMDAzLjAwMDAwMDAwOC4wMDAwMDAwMDUuKmFuYWNvbmRhLjAwMDAwMDAwMy4qemZpbmFsLS4wMDAwMDIwMjAuMDAwMDAwMDExLip6ZmluYWwiLH0sU0NDPXtbImZuIl09Ii91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVzL290aGVyL1NDQy5sdWEiLFsiZnVsbE5hbWUiXT0iU0NDIixbImxvYWRPcmRlciJdPTEscHJvcFQ9e30sWyJzdGFja0RlcHRoIl09MCxbInN0YXR1cyJdPSJhY3RpdmUiLFsidXNlck5hbWUiXT0iU0NDIixbIndWIl09Ik0uKnpmaW5hbCIsfSxbImxhbmcvTWluaWNvbmRhMyJdPXtbImZuIl09Ii91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVzL2FsbC9sYW5nL01pbmljb25kYTMvNC45LjIubHVhIixbImZ1bGxOYW1lIl09ImxhbmcvTWluaWNvbmRhMy80Ljku'
export LMOD_PACKAGE_PATH='/usr/local/apps/lmod/etc'
export MAIL='/var/spool/mail/jxia'
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:'
export CONDA_PYTHON_EXE='/opt/scc/conda/software/Miniconda3/4.9.2/bin/python'
export __LMOD_REF_COUNT_MANPATH='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/share/man:1;/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/man:1;/opt/scc/conda/software/Miniconda3/4.9.2/share/man:1;/usr/local/apps/lmod/lmod/share/man:1'
export _CE_M=''
export LESSOPEN='||/usr/bin/lesspipe.sh %s'
export USER='jxia'
export EBROOTMINICONDA3='/opt/scc/conda/software/Miniconda3/4.9.2'
export __LMOD_REF_COUNT_LD_LIBRARY_PATH='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib/R/lib:1;/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib:1;/usr/local/apps/software/Tcl/8.5.13/lib:1;/usr/local/apps/software/zlib/1.2.11/lib:1;/usr/local/apps/software/Lua/5.1.4-8/lib:1'
export SHLVL='1'
export DISPLAY='localhost:23.0'
export LMOD_ADMIN_FILE='/usr/local/apps/lmod/etc/admin.list'
export QBATCH_SYSTEM='slurm'
export MODULESHOME='/usr/local/apps/lmod/lmod'
export __LMOD_REF_COUNT_PKG_CONFIG_PATH='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib/pkgconfig:1;/opt/scc/conda/software/Miniconda3/4.9.2/lib/pkgconfig:1'
export _ModuleTable001_='X01vZHVsZVRhYmxlXz17WyJNVHZlcnNpb24iXT0zLFsiY19yZWJ1aWxkVGltZSJdPWZhbHNlLFsiY19zaG9ydFRpbWUiXT1mYWxzZSxkZXB0aFQ9e30sZmFtaWx5PXt9LG1UPXtSPXtbImZuIl09Ii91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVzL3F1YXJhbnRpbmUvUi80LjAuMy1QeXRob24tMy44LjUtQW5hY29uZGEzLTIwMjAuMTEubHVhIixbImZ1bGxOYW1lIl09IlIvNC4wLjMtUHl0aG9uLTMuOC41LUFuYWNvbmRhMy0yMDIwLjExIixbImxvYWRPcmRlciJdPTMscHJvcFQ9e30sWyJzdGFja0RlcHRoIl09MCxbInN0YXR1cyJdPSJhY3RpdmUiLFsidXNlck5hbWUiXT0iUiIsWyJ3ViJdPSIwMDAwMDAwMDQuMDAwMDAwMDAwLjAwMDAwMDAwMy4qeXRob24uKnpmaW5hbC0uMDAw'
export LMOD_VERSION='8.4.20'
export PKG_CONFIG_PATH='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib/pkgconfig:/opt/scc/conda/software/Miniconda3/4.9.2/lib/pkgconfig'
export BASH_ENV='/usr/local/apps/lmod/lmod/init/bash'
export __LMOD_REF_COUNT_PATH='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11:1;/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/sbin:1;/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/bin:1;/opt/scc/conda/software/Miniconda3/4.9.2:1;/opt/scc/conda/software/Miniconda3/4.9.2/bin:1;/usr/local/apps/bin:1;/usr/local/apps/sbin:1;/lmod/lmod/libexec:1;/opt/slurmtools/bin:1;/usr/local/bin:1;/usr/bin:1;/usr/local/sbin:1;/usr/sbin:1;/sbin:1;/bin:1'
export _='/usr/bin/qbatch'
export MODULEPATH='/usr/local/scc/modulefiles/all:/usr/local/scc/modulefiles/quarantine:/usr/local/scc/modulefiles/other:/usr/local/apps/lmod/8.4.20/modulefiles/Core:/etc/modulefiles'
export LMOD_SHORT_TIME='86400'
export SSH_CONNECTION='172.28.201.185 58459 172.26.216.50 22'
export EBVERSIONR='4.0.3'
export OMP_NUM_THREADS='1'
export _LMFILES_='/usr/local/scc/modulefiles/other/SCC.lua:/usr/local/scc/modulefiles/all/lang/Miniconda3/4.9.2.lua:/usr/local/scc/modulefiles/quarantine/R/4.0.3-Python-3.8.5-Anaconda3-2020.11.lua'
export __LMOD_REF_COUNT_LOADEDMODULES='SCC:1;lang/Miniconda3/4.9.2:1;R/4.0.3-Python-3.8.5-Anaconda3-2020.11:1'
export LMOD_DIR='/usr/local/apps/lmod/lmod/libexec'
export LMOD_PKG='/usr/local/apps/lmod/lmod'
export MODULEPATH_ROOT='/usr/local/apps/modulefiles'
export HOME='/nethome/kcni/jxia'
export LD_LIBRARY_PATH='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib/R/lib:/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib:/usr/local/apps/software/Tcl/8.5.13/lib:/usr/local/apps/software/zlib/1.2.11/lib:/usr/local/apps/software/Lua/5.1.4-8/lib'
export LANG='en_US.UTF-8'
export CONDA_SHLVL='0'
export CONDA_PREFIX='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11'
export __LMOD_REF_COUNT__LMFILES_='/usr/local/scc/modulefiles/other/SCC.lua:1;/usr/local/scc/modulefiles/all/lang/Miniconda3/4.9.2.lua:1;/usr/local/scc/modulefiles/quarantine/R/4.0.3-Python-3.8.5-Anaconda3-2020.11.lua:1'
export _ModuleTable_Sz_='4'
export CONDA_DEFAULT_ENV='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11'
export LMOD_CMD='/usr/local/apps/lmod/lmod/libexec/lmod'
export SCC_LMOD_HIDE='1'
export EBDEVELMINICONDA3='/opt/scc/conda/software/Miniconda3/4.9.2/easybuild/lang-Miniconda3-4.9.2-easybuild-devel'
export SSH_TTY='/dev/pts/9'
export OLDPWD='/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/parallel_results'
export LMOD_SYSTEM_DEFAULT_MODULES='SCC'
export LMOD_CACHED_LOADS='no'
export SSH_CLIENT='172.28.201.185 58459 22'
export LOGNAME='jxia'
export PATH='/opt/scc/conda/software/Miniconda3/4.9.2/condabin:/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11:/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/sbin:/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/bin:/opt/scc/conda/software/Miniconda3/4.9.2:/opt/scc/conda/software/Miniconda3/4.9.2/bin:/usr/local/apps/bin:/usr/local/apps/sbin:/lmod/lmod/libexec:/opt/slurmtools/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin'
export TERM='xterm'
export EBDEVELR='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/easybuild/lang-R-4.0.3-Python-3.8.5-Anaconda3-2020.11-easybuild-devel'
export __LMOD_SET_FPATH='1'
export _ModuleTable003_='MiIsWyJsb2FkT3JkZXIiXT0yLHByb3BUPXt9LFsic3RhY2tEZXB0aCJdPTEsWyJzdGF0dXMiXT0iYWN0aXZlIixbInVzZXJOYW1lIl09ImxhbmcvTWluaWNvbmRhMy80LjkuMiIsWyJ3ViJdPSIwMDAwMDAwMDQuMDAwMDAwMDA5LjAwMDAwMDAwMi4qemZpbmFsIix9LH0sbXBhdGhBPXsiL3Vzci9sb2NhbC9zY2MvbW9kdWxlZmlsZXMvYWxsIiwiL3Vzci9sb2NhbC9zY2MvbW9kdWxlZmlsZXMvcXVhcmFudGluZSIsIi91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVzL290aGVyIiwiL3Vzci9sb2NhbC9hcHBzL2xtb2QvOC40LjIwL21vZHVsZWZpbGVzL0NvcmUiLCIvZXRjL21vZHVsZWZpbGVzIix9LFsic3lzdGVtQmFzZU1QQVRIIl09Ii91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVz'
export _CE_CONDA=''
export _ModuleTable004_='L2FsbDovdXNyL2xvY2FsL3NjYy9tb2R1bGVmaWxlcy9xdWFyYW50aW5lOi91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVzL290aGVyOi91c3IvbG9jYWwvYXBwcy9sbW9kLzguNC4yMC9tb2R1bGVmaWxlcy9Db3JlOi9ldGMvbW9kdWxlZmlsZXMiLH0='
export KRB5CCNAME='KEYRING:persistent:10355'
export LMOD_sys='Linux'
export LOADEDMODULES='SCC:lang/Miniconda3/4.9.2:R/4.0.3-Python-3.8.5-Anaconda3-2020.11'
export CONDA_EXE='/opt/scc/conda/software/Miniconda3/4.9.2/bin/conda'
export HISTCONTROL='ignoredups'
export EBROOTR='/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11'
export THREADS_PER_COMMAND='1'

export __Init_Default_Modules="1"
export TMOUT="7200"
export QT_GRAPHICSSYSTEM_CHECKED="1"
export SACCT_FORMAT="JobID%20,JobName,User,Partition,NodeList,Elapsed,State,ExitCode,MaxRSS,AllocTRES%32"
export LMOD_ANCIENT_TIME="86400"
export SHELL="/bin/bash"
export EBVERSIONMINICONDA3="4.9.2"
export HISTSIZE="1000"
export MANPATH="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/share/man:/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/man:/opt/scc/conda/software/Miniconda3/4.9.2/share/man:/usr/local/apps/lmod/lmod/share/man::"
export XDG_RUNTIME_DIR="/run/user/10355"
export SQUEUE_FORMAT="%20i %20u %20a %20P %10Q %5D %5C %11l %11L %18R %40j"
export FPATH="/usr/local/apps/lmod/lmod/init/ksh_funcs"
export __LMOD_REF_COUNT_MODULEPATH="/usr/local/scc/modulefiles/all:1;/usr/local/scc/modulefiles/quarantine:1;/usr/local/scc/modulefiles/other:1;/usr/local/apps/lmod/8.4.20/modulefiles/Core:1;/etc/modulefiles:1"
export LMOD_SETTARG_FULL_SUPPORT="no"
export CONDA_ENV="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11"
export XDG_SESSION_ID="3183"
export HOSTNAME="scclogin01.camhres.ca"
export LMOD_ROOT="/usr/local/apps/lmod"
export _ModuleTable002_="MDAwMDAzLjAwMDAwMDAwOC4wMDAwMDAwMDUuKmFuYWNvbmRhLjAwMDAwMDAwMy4qemZpbmFsLS4wMDAwMDIwMjAuMDAwMDAwMDExLip6ZmluYWwiLH0sU0NDPXtbImZuIl09Ii91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVzL290aGVyL1NDQy5sdWEiLFsiZnVsbE5hbWUiXT0iU0NDIixbImxvYWRPcmRlciJdPTEscHJvcFQ9e30sWyJzdGFja0RlcHRoIl09MCxbInN0YXR1cyJdPSJhY3RpdmUiLFsidXNlck5hbWUiXT0iU0NDIixbIndWIl09Ik0uKnpmaW5hbCIsfSxbImxhbmcvTWluaWNvbmRhMyJdPXtbImZuIl09Ii91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVzL2FsbC9sYW5nL01pbmljb25kYTMvNC45LjIubHVhIixbImZ1bGxOYW1lIl09ImxhbmcvTWluaWNvbmRhMy80Ljku"
export LMOD_PACKAGE_PATH="/usr/local/apps/lmod/etc"
export MAIL="/var/spool/mail/jxia"
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:"
export CONDA_PYTHON_EXE="/opt/scc/conda/software/Miniconda3/4.9.2/bin/python"
export __LMOD_REF_COUNT_MANPATH="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/share/man:1;/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/man:1;/opt/scc/conda/software/Miniconda3/4.9.2/share/man:1;/usr/local/apps/lmod/lmod/share/man:1"
export _CE_M=""
export LESSOPEN="||/usr/bin/lesspipe.sh %s"
export USER="jxia"
export EBROOTMINICONDA3="/opt/scc/conda/software/Miniconda3/4.9.2"
export __LMOD_REF_COUNT_LD_LIBRARY_PATH="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib/R/lib:1;/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib:1;/usr/local/apps/software/Tcl/8.5.13/lib:1;/usr/local/apps/software/zlib/1.2.11/lib:1;/usr/local/apps/software/Lua/5.1.4-8/lib:1"
export SHLVL="1"
export DISPLAY="localhost:23.0"
export LMOD_ADMIN_FILE="/usr/local/apps/lmod/etc/admin.list"
export QBATCH_SYSTEM="slurm"
export MODULESHOME="/usr/local/apps/lmod/lmod"
export __LMOD_REF_COUNT_PKG_CONFIG_PATH="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib/pkgconfig:1;/opt/scc/conda/software/Miniconda3/4.9.2/lib/pkgconfig:1"
export _ModuleTable001_="X01vZHVsZVRhYmxlXz17WyJNVHZlcnNpb24iXT0zLFsiY19yZWJ1aWxkVGltZSJdPWZhbHNlLFsiY19zaG9ydFRpbWUiXT1mYWxzZSxkZXB0aFQ9e30sZmFtaWx5PXt9LG1UPXtSPXtbImZuIl09Ii91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVzL3F1YXJhbnRpbmUvUi80LjAuMy1QeXRob24tMy44LjUtQW5hY29uZGEzLTIwMjAuMTEubHVhIixbImZ1bGxOYW1lIl09IlIvNC4wLjMtUHl0aG9uLTMuOC41LUFuYWNvbmRhMy0yMDIwLjExIixbImxvYWRPcmRlciJdPTMscHJvcFQ9e30sWyJzdGFja0RlcHRoIl09MCxbInN0YXR1cyJdPSJhY3RpdmUiLFsidXNlck5hbWUiXT0iUiIsWyJ3ViJdPSIwMDAwMDAwMDQuMDAwMDAwMDAwLjAwMDAwMDAwMy4qeXRob24uKnpmaW5hbC0uMDAw"
export LMOD_VERSION="8.4.20"
export PKG_CONFIG_PATH="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib/pkgconfig:/opt/scc/conda/software/Miniconda3/4.9.2/lib/pkgconfig"
export BASH_ENV="/usr/local/apps/lmod/lmod/init/bash"
export __LMOD_REF_COUNT_PATH="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11:1;/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/sbin:1;/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/bin:1;/opt/scc/conda/software/Miniconda3/4.9.2:1;/opt/scc/conda/software/Miniconda3/4.9.2/bin:1;/usr/local/apps/bin:1;/usr/local/apps/sbin:1;/lmod/lmod/libexec:1;/opt/slurmtools/bin:1;/usr/local/bin:1;/usr/bin:1;/usr/local/sbin:1;/usr/sbin:1;/sbin:1;/bin:1"
export _="/usr/bin/qbatch"
export MODULEPATH="/usr/local/scc/modulefiles/all:/usr/local/scc/modulefiles/quarantine:/usr/local/scc/modulefiles/other:/usr/local/apps/lmod/8.4.20/modulefiles/Core:/etc/modulefiles"
export LMOD_SHORT_TIME="86400"
export SSH_CONNECTION="172.28.201.185 58459 172.26.216.50 22"
export EBVERSIONR="4.0.3"
export OMP_NUM_THREADS="1"
export _LMFILES_="/usr/local/scc/modulefiles/other/SCC.lua:/usr/local/scc/modulefiles/all/lang/Miniconda3/4.9.2.lua:/usr/local/scc/modulefiles/quarantine/R/4.0.3-Python-3.8.5-Anaconda3-2020.11.lua"
export __LMOD_REF_COUNT_LOADEDMODULES="SCC:1;lang/Miniconda3/4.9.2:1;R/4.0.3-Python-3.8.5-Anaconda3-2020.11:1"
export LMOD_DIR="/usr/local/apps/lmod/lmod/libexec"
export LMOD_PKG="/usr/local/apps/lmod/lmod"
export MODULEPATH_ROOT="/usr/local/apps/modulefiles"
export HOME="/nethome/kcni/jxia"
export LD_LIBRARY_PATH="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib/R/lib:/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/lib:/usr/local/apps/software/Tcl/8.5.13/lib:/usr/local/apps/software/zlib/1.2.11/lib:/usr/local/apps/software/Lua/5.1.4-8/lib"
export LANG="en_US.UTF-8"
export CONDA_SHLVL="0"
export CONDA_PREFIX="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11"
export __LMOD_REF_COUNT__LMFILES_="/usr/local/scc/modulefiles/other/SCC.lua:1;/usr/local/scc/modulefiles/all/lang/Miniconda3/4.9.2.lua:1;/usr/local/scc/modulefiles/quarantine/R/4.0.3-Python-3.8.5-Anaconda3-2020.11.lua:1"
export _ModuleTable_Sz_="4"
export CONDA_DEFAULT_ENV="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11"
export LMOD_CMD="/usr/local/apps/lmod/lmod/libexec/lmod"
export SCC_LMOD_HIDE="1"
export EBDEVELMINICONDA3="/opt/scc/conda/software/Miniconda3/4.9.2/easybuild/lang-Miniconda3-4.9.2-easybuild-devel"
export SSH_TTY="/dev/pts/9"
export OLDPWD="/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/parallel_results"
export LMOD_SYSTEM_DEFAULT_MODULES="SCC"
export LMOD_CACHED_LOADS="no"
export SSH_CLIENT="172.28.201.185 58459 22"
export LOGNAME="jxia"
export PATH="/opt/scc/conda/software/Miniconda3/4.9.2/condabin:/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11:/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/sbin:/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/bin:/opt/scc/conda/software/Miniconda3/4.9.2:/opt/scc/conda/software/Miniconda3/4.9.2/bin:/usr/local/apps/bin:/usr/local/apps/sbin:/lmod/lmod/libexec:/opt/slurmtools/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin"
export TERM="xterm"
export EBDEVELR="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11/easybuild/lang-R-4.0.3-Python-3.8.5-Anaconda3-2020.11-easybuild-devel"
export __LMOD_SET_FPATH="1"
export _ModuleTable003_="MiIsWyJsb2FkT3JkZXIiXT0yLHByb3BUPXt9LFsic3RhY2tEZXB0aCJdPTEsWyJzdGF0dXMiXT0iYWN0aXZlIixbInVzZXJOYW1lIl09ImxhbmcvTWluaWNvbmRhMy80LjkuMiIsWyJ3ViJdPSIwMDAwMDAwMDQuMDAwMDAwMDA5LjAwMDAwMDAwMi4qemZpbmFsIix9LH0sbXBhdGhBPXsiL3Vzci9sb2NhbC9zY2MvbW9kdWxlZmlsZXMvYWxsIiwiL3Vzci9sb2NhbC9zY2MvbW9kdWxlZmlsZXMvcXVhcmFudGluZSIsIi91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVzL290aGVyIiwiL3Vzci9sb2NhbC9hcHBzL2xtb2QvOC40LjIwL21vZHVsZWZpbGVzL0NvcmUiLCIvZXRjL21vZHVsZWZpbGVzIix9LFsic3lzdGVtQmFzZU1QQVRIIl09Ii91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVz"
export _CE_CONDA=""
export _ModuleTable004_="L2FsbDovdXNyL2xvY2FsL3NjYy9tb2R1bGVmaWxlcy9xdWFyYW50aW5lOi91c3IvbG9jYWwvc2NjL21vZHVsZWZpbGVzL290aGVyOi91c3IvbG9jYWwvYXBwcy9sbW9kLzguNC4yMC9tb2R1bGVmaWxlcy9Db3JlOi9ldGMvbW9kdWxlZmlsZXMiLH0="
export KRB5CCNAME="KEYRING:persistent:10355"
export LMOD_sys="Linux"
export LOADEDMODULES="SCC:lang/Miniconda3/4.9.2:R/4.0.3-Python-3.8.5-Anaconda3-2020.11"
export CONDA_EXE="/opt/scc/conda/software/Miniconda3/4.9.2/bin/conda"
export HISTCONTROL="ignoredups"
export EBROOTR="/opt/scc/conda/software/R/4.0.3-Python-3.8.5-Anaconda3-2020.11"
ARRAY_IND=$SLURM_ARRAY_TASK_ID
command -v parallel > /dev/null 2>&1 || { echo "GNU parallel not found in job environment. Exiting."; exit 1; }
CHUNK_SIZE=1
CORES=1
export THREADS_PER_COMMAND=1
sed -n "$(( (${ARRAY_IND} - 1) * ${CHUNK_SIZE} + 1 )),+$(( ${CHUNK_SIZE} - 1 ))p" << EOF | parallel -j${CORES} --tag --line-buffer --compress
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_15996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_17996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_18996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19976.sh
EOF
