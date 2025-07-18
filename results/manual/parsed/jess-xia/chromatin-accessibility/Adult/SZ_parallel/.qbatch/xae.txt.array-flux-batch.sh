#!/bin/bash
#FLUX: --job-name=xae.txt
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
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_19996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_20761.sh
EOF
