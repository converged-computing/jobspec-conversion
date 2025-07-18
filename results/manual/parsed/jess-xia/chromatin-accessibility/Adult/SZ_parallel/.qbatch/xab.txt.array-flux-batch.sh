#!/bin/bash
#FLUX: --job-name=xab.txt
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
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_5996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_7996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_8996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9986.sh
EOF
