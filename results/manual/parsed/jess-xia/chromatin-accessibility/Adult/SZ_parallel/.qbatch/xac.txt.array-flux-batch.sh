#!/bin/bash
#FLUX: --job-name=xac.txt
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
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_9996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_10996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_12996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_13996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_14981.sh
EOF
