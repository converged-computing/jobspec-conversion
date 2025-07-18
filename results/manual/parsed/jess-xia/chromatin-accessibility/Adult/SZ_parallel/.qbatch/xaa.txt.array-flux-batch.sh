#!/bin/bash
#FLUX: --job-name=xaa.txt
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
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_6.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_11.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_16.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_21.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_26.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_31.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_36.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_41.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_46.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_51.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_56.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_61.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_66.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_71.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_76.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_81.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_86.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_91.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_96.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_1996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_2996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3991.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_3996.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4001.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4006.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4011.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4016.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4021.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4026.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4031.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4036.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4041.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4046.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4051.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4056.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4061.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4066.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4071.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4076.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4081.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4086.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4091.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4096.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4101.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4106.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4111.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4116.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4121.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4126.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4131.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4136.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4141.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4146.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4151.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4156.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4161.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4166.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4171.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4176.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4181.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4186.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4191.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4196.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4201.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4206.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4211.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4216.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4221.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4226.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4231.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4236.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4241.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4246.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4251.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4256.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4261.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4266.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4271.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4276.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4281.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4286.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4291.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4296.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4301.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4306.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4311.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4316.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4321.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4326.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4331.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4336.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4341.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4346.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4351.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4356.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4361.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4366.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4371.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4376.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4381.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4386.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4391.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4396.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4401.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4406.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4411.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4416.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4421.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4426.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4431.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4436.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4441.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4446.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4451.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4456.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4461.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4466.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4471.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4476.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4481.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4486.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4491.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4496.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4501.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4506.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4511.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4516.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4521.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4526.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4531.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4536.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4541.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4546.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4551.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4556.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4561.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4566.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4571.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4576.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4581.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4586.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4591.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4596.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4601.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4606.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4611.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4616.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4621.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4626.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4631.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4636.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4641.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4646.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4651.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4656.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4661.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4666.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4671.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4676.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4681.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4686.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4691.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4696.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4701.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4706.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4711.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4716.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4721.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4726.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4731.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4736.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4741.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4746.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4751.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4756.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4761.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4766.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4771.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4776.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4781.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4786.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4791.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4796.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4801.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4806.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4811.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4816.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4821.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4826.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4831.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4836.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4841.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4846.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4851.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4856.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4861.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4866.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4871.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4876.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4881.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4886.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4891.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4896.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4901.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4906.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4911.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4916.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4921.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4926.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4931.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4936.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4941.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4946.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4951.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4956.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4961.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4966.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4971.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4976.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4981.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4986.sh
/nethome/kcni/jxia/chromatin-accessibility/Adult/SZ_parallel/SZ_4991.sh
EOF
