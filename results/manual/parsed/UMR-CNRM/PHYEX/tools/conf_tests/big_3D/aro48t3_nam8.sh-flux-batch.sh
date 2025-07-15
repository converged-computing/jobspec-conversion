#!/bin/bash
#FLUX: --job-name=dinosaur-omelette-0408
#FLUX: --urgency=16

export JOB_NAME='arome_e700'
export JOB_ID='$SLURM_JOB_ID'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_STACKSIZE='4G'
export KMP_STACKSIZE='4G'
export KMP_MONITOR_STACKSIZE='4G'
export I_MPI_HARD_FINALIZE='1'
export I_MPI_SCALABLE_OPTIMIZATION='0'
export I_MPI_DAPL_UD_RNDV_EP_NUM='4'
export I_MPI_SHM_SPIN_COUNT='10'
export I_MPI_SPIN_COUNT='10'
export TMPGFS='$TMPDIR'
export WORKGFS='$WORKDIR/benchmarks'
export TMPLOC='$TMPGFS'
export ISYNC='0'
export NAMELDIR='$TESTDIR/Namelists'
export BINDIR='$HOMEPACK/$MYLIB/bin'
export DATADIR='/scratch/work/khatib/data/cy47.forecast_arome_e700'
export TOOLSDIR='/home/gmap/mrpm/khatib/benchmarks/tools'
export PATH='$TOOLSDIR:$PATH'
export DR_HOOK='0'
export DR_HOOK_IGNORE_SIGNALS='-1'
export DR_HOOK_SILENT='1'
export DR_HOOK_SHOW_PROCESS_OPTIONS='0'
export MPL_MBX_SIZE='2048000000'
export EC_PROFILE_HEAP='0'
export EC_PROFILE_MEM='0'
export EC_MPI_ATEXIT='0'
export EC_MEMINFO='0'
export OPENBLAS_NUM_THREADS='1'
export MKL_CBWR='AUTO,STRICT'
export MKL_NUM_THREADS='1'
export MKL_DEBUG_CPU_TYPE='5'
export FTRACE_JOB='1'
export ECHO_MPSH='OFF'
export OUTPUT_LISTING='YES'
export LOGDIR='$JOB_INITDIR/${JOB_NAME}.l${JOB_ID}'
export ARCHIVE_AND_ZIP_ODB='0'
export MPSH_NPES='$NNODES'

JOB_INITDIR=$SLURM_SUBMIT_DIR
export JOB_NAME=arome_e700
export JOB_ID=$SLURM_JOB_ID
echo JOB_INITDIR=$JOB_INITDIR
echo JOB_NAME=$JOB_NAME
echo JOB_ID=$JOB_ID
NNODES=$SLURM_JOB_NUM_NODES
MPITASKS_PER_NODE=$((SLURM_NTASKS/SLURM_JOB_NUM_NODES))
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
MPI_TASKS=$SLURM_NTASKS
NTASKS_IO=$(($(grep processor /proc/cpuinfo | wc -l)/1/$OMP_NUM_THREADS))
echo NNODES=$NNODES
echo MPITASKS_PER_NODE=$MPITASKS_PER_NODE
echo
echo MPI_TASKS=$MPI_TASKS
echo OMP_NUM_THREADS=$OMP_NUM_THREADS
set -x
LOCAL_MPI_WRAPPER="/opt/softs/mpiauto/mpiauto"
LOCAL_STACK_LIMIT=unlimited
ulimit -l unlimited
set +x
set -x
export OMP_STACKSIZE=4G
export KMP_STACKSIZE=4G
export KMP_MONITOR_STACKSIZE=4G
export I_MPI_HARD_FINALIZE=1
export I_MPI_SCALABLE_OPTIMIZATION=0
export I_MPI_DAPL_UD_RNDV_EP_NUM=4
export I_MPI_SHM_SPIN_COUNT=10
export I_MPI_SPIN_COUNT=10
set +x
export TMPGFS=$TMPDIR
export WORKGFS=$WORKDIR/benchmarks
export TMPLOC=$TMPGFS
echo TMPGFS=$TMPGFS
echo TMPLOC=$TMPLOC
export ISYNC=0
if [ "$MTOOL_IS" = "ON" ] ; then
  export ISYNC=1
elif [ $NNODES -gt 1 ] && [ "$TMPLOC" != "$TMPGFS" ] ; then
  export ISYNC=1
fi
echo ISYNC=$ISYNC
export NAMELDIR=$TESTDIR/Namelists
HOMEPACK=${HOMEPACK:=$HOME/pack}
export BINDIR=$HOMEPACK/$MYLIB/bin
OUTPUTDIR=${OUTPUTDIR:-$PWD} #No cd command have been done before this line
export DATADIR=/scratch/work/khatib/data/cy47.forecast_arome_e700
export TOOLSDIR=/home/gmap/mrpm/khatib/benchmarks/tools
ierr=0
for var in NAMELDIR BINDIR DATADIR TOOLSDIR ; do
  eval "dir=\$$var"
  if [ ! "$dir" ] ; then
    echo "$var is not set."
    ierr=1
  fi
  if [ $ierr -ne 0 ] ; then
    exit 1
  fi
done
ierr=0
for dir in $NAMELDIR $BINDIR $REFDIR $TOOLSDIR ; do
  if [ ! -d $dir ] ; then
    echo "$dir does not exists."
    ierr=1
  fi
  if [ $ierr -ne 0 ] ; then
    exit 1
  fi
done
echo TOOLSDIR=$TOOLSDIR
echo NAMELDIR=$NAMELDIR
echo DATADIR=$DATADIR
echo BINDIR=$BINDIR
export PATH=$TOOLSDIR:$PATH
export TOOLSDIR
export DATADIR
set -x
export DR_HOOK=0
export DR_HOOK_IGNORE_SIGNALS=-1
export DR_HOOK_SILENT=1
export DR_HOOK_SHOW_PROCESS_OPTIONS=0
export MPL_MBX_SIZE=2048000000
export EC_PROFILE_HEAP=0
export EC_PROFILE_MEM=0
export EC_MPI_ATEXIT=0
export EC_MEMINFO=0
export OPENBLAS_NUM_THREADS=1
export MKL_CBWR="AUTO,STRICT"
export MKL_NUM_THREADS=1
export MKL_DEBUG_CPU_TYPE=5
set +x
export FTRACE_JOB=1
echo "FTRACE_JOB=$FTRACE_JOB"
if [ $FTRACE_JOB -ne 0 ] ; then
  if [ -d $JOB_INITDIR ] ; then
    FTRACE_DIR=$JOB_INITDIR
  else
    FTRACEDIR=
    if [ ! "$FTRACEDIR" ] ; then
      echo "FTRACEDIR is not set."
      exit 1
    fi
    if [ ! -d $FTRACEDIR ] ; then
      mkdir -p $FTRACEDIR
      if [ $? -ne 0 ] ; then
        echo "Can't make directory $FTRACEDIR"
        exit 1
      fi
    fi
    FTRACE_DIR=$FTRACEDIR
  fi
   SCRATCH_FTRACE_DIR=$TMPGFS
  if [ $FTRACE_JOB -eq 1 ] ; then
    set -x
    export DR_HOOK=1
    export DR_HOOK_OPT=prof
    export PROFDIR=$SCRATCH_FTRACE_DIR/${JOB_NAME}.d${JOB_ID}
    export PROFMRG=$FTRACE_DIR/${JOB_NAME}.h${JOB_ID}
    set +x
  elif [ $FTRACE_JOB -ge 2 ] ; then
    set -x
    export PROFDIR=$SCRATCH_FTRACE_DIR/${JOB_NAME}.f${JOB_ID}
    export PROFMRG=$FTRACE_DIR/${JOB_NAME}.t${JOB_ID}
    set +x
  fi
fi
set +x
set -x
export ECHO_MPSH=OFF
export OUTPUT_LISTING=YES
export LOGDIR=$JOB_INITDIR/${JOB_NAME}.l${JOB_ID}
set +x
set -x
export ARCHIVE_AND_ZIP_ODB=0
set +x
echo
OUTDIR=
OUTDIR=${OUTDIR:=$TMPGFS}
if [ "$TMPGFS" != "$TMPLOC" ] ; then
  if [ "$OUTDIR" = "$TMPLOC" ] ; then
    echo "Output files on LOCAL file system"
  elif [ "$OUTDIR" = "$TMPGFS" ] ; then
    echo "Output files on GLOBAL file system"
  else
    echo "Output files on directory : $OUTDIR"
  fi
else
  echo "Output files on directory : $OUTDIR"
fi
echo
TMPNFS=$(mktemp -d --tmpdir=/tmp/$LOGNAME)
if [ -d $TMPNFS ] ; then
  echo "temporary directory on NFS for small I/Os : $TMPNFS"
else
  TMPNFS="."
fi
mkdir -p $TMPLOC
if [ $ISYNC -gt 0 ] ; then
  mkdir -p $TMPGFS
  cd $TMPGFS
else
  cd $TMPLOC
fi
set -x
NAMELIST=namel_previ.48
CTRLLIST=extra_namelists48.list
LINKS=links_inline48.scpt
EXECUTABLE=MASTERODB
EXPLIST=./NODE.001_01
set +x
set -x
NPROC_IO=$NTASKS_IO
NPROC=$((MPI_TASKS-NPROC_IO))
NPROMA=-16
NFPROMA=-24
LOPT_SCALAR=.TRUE.
NSTROUT=${NPROC}
NSTRIN=${NPROC}
NPRGPEW=16
NPRTRV=16
set +x
cat > namelist_mods2 <<EOF
 &NAM_NEBN
   CFRAC_ICE_ADJUST='S',
   CFRAC_ICE_SHALLOW_MF='S',
   LSIGMAS=.TRUE.
   LSUBG_COND=.TRUE.,
   VSIGQSAT=0.02,
 /
 &NAM_PARAM_ICEN
   CSEDIM='STAT',
   CSNOWRIMING='M90',
   LCONVHG=.TRUE.,
   LCRFLIMIT=.TRUE.,
   LEVLIMIT=.TRUE.,
   LFEEDBACKT=.TRUE.,
   LNULLWETG=.TRUE.,
   LNULLWETH=.TRUE.,
   LSEDIM_AFTER=.FALSE.,
   LWETGPOST=.TRUE.,
   LWETHPOST=.TRUE.,
   NMAXITER_MICRO=1,
   XFRACM90=0.1,
   XMRSTEP=0.00005,
   XSPLIT_MAXCFL=0.8,
   XTSTEP_TS=0.,
   LCRIAUTI=.TRUE.,
   XCRIAUTC_NAM=0.001,
   XCRIAUTI_NAM=0.0002,
   XT0CRIAUTI_NAM=-5.,
   LRED=.TRUE.,
   LSEDIC=.TRUE.,
 /
 &NAM_PARAM_MFSHALLN
 /
 &NAM_TURBN
 /
 &NAM_PARAM_LIMA
 /
 &NAMPARAR
   LOSIGMAS=-,
   LOSUBG_COND=-,
   VSIGQSAT=-,
   LOSEDIC=-,
   CFRAC_ICE_ADJUST=-,
   CFRAC_ICE_SHALLOW_MF=-,
   CSEDIM=-,
   CSNOWRIMING=-,
   LCONVHG=-,
   LCRFLIMIT=-,
   LEVLIMIT=-,
   LFEEDBACKT=-,
   LNULLWETG=-,
   LNULLWETH=-,
   LSEDIM_AFTER=-,
   LWETGPOST=-,
   LWETHPOST=-,
   NMAXITER_MICRO=-,
   XFRACM90=-,
   XMRSTEP=-,
   XSPLIT_MAXCFL=-,
   XTSTEP_TS=-,
   LCRIAUTI=-,
   RCRIAUTC=-,
   RCRIAUTI=-,
   RT0CRIAUTI=-,
 /
 &NAMTRANS
   LFFTW=.TRUE.,
 /
 &NAMPAR0
   NPRINTLEV=1,
   LOPT_SCALAR=${LOPT_SCALAR},
   MBX_SIZE=2048000000,
   NPROC=${NPROC},
   NPRGPNS=-,
   NPRGPEW=-,
   NPRTRW=-,
   NPRTRV=-,
 /
 &NAMDIM
   NPROMA=$NPROMA,
 /
 &NAMFPSC2
   NFPROMA=$NFPROMA,
 /
 &NAMFPSC2_DEP
   NFPROMA_DEP=$NFPROMA,
 /
 &NAMPAR1
   LSPLIT=.TRUE.,
   NSTRIN=${NSTRIN},
   NSTROUT=${NSTROUT},
 /
 &NAMFA
   CMODEL=' ',
 /
 &NAMIAU
   LIAU=.FALSE.,
 /
 &NAMARG
   CNMEXP='0000',
 /
 &NAMCT0
   CSCRIPT_LAMRTC=' ',
   CSCRIPT_PPSERVER=' ',
   CFPNCF='ECHFP',
   NSDITS(0)=0,
   NFRSDI=4,
   NFPOS=1,
 /
 &NAMCT1
   N1POS=1,
 /
 &NAMFPC
   CFPDIR='${OUTDIR}/PF',
 /
 &NAMOPH
   CFNHWF='${OUTDIR}/ECHIS',
   CFPATH='${OUTDIR}/',
 /
 &NAMIO_SERV 
   NPROC_IO=${NPROC_IO}, 
   NMSG_LEVEL_SERVER=1, 
   NMSG_LEVEL_CLIENT=1, 
   NPROCESS_LEVEL=5,
 /
 &NAMRIP
    CSTOP='h24',
    TSTEP=50.,
 /
EOF
cat namelist_mods2 > namelist_modset
\rm -f namelist_mods2
echo
echo Namelists adaptations :
cat namelist_modset
echo
set +x
cp $NAMELDIR/$NAMELIST namelist
perl -w $TOOLSDIR/xpnam namelist --dfile=namelist_modset
set -x
echo
/bin/cat namelist.new
set +x
\rm -f namelist_modset namelist
\mv namelist.new fort.4
set -x
set -x
$TOOLSDIR/getdata.sh
set +x
for file in $(cat $NAMELDIR/$CTRLLIST) ; do
  set -x
  cp $NAMELDIR/$file .
  set +x
done
if [ -s $NAMELDIR/$LINKS ] ; then
  set -x
  cp $NAMELDIR/$LINKS .
  chmod 755 $LINKS
  . ./$LINKS
  \rm $LINKS
  set +x
fi
echo
set -x
cp $BINDIR/$EXECUTABLE .
set +x
if [ ! -f $EXECUTABLE ] ; then
  echo "executable $BINDIR/$EXECUTABLE could not be copied."
  exit 1
fi
if [ "$LOCAL_STACK_LIMIT" ] ; then
  set -x
  ulimit -s $LOCAL_STACK_LIMIT
  set +x
fi
export MPSH_NPES=$NNODES
. grib_api_profile $EXECUTABLE
. intel_mpi_fabric $EXECUTABLE
set -x
cd $TMPLOC
set +x
. rttov_profile
if [ $ISYNC -eq 0 ] ; then
  set -x
  $TOOLSDIR/input_sync.sh
  set +x
else
  set -x
  $TOOLSDIR/input_sync.sh
  set +x
fi
mkdir -p $OUTDIR
echo
if [ $(echo $LOCAL_MPI_WRAPPER | grep -c mpiauto) -ne 0 ] ; then
  set -x
  time $LOCAL_MPI_WRAPPER -np $MPI_TASKS -nnp $MPITASKS_PER_NODE -- ./$EXECUTABLE </dev/null \
  errorcode=$?
  2>&1 | grep -v "FA[DC]GR[AM]: Field .* is not declared in \`faFieldName.def'"
  set +x
elif [ "$LOCAL_MPI_WRAPPER" = "srun" ] ; then
  set -x
  time $LOCAL_MPI_WRAPPER ./$EXECUTABLE </dev/null \
  errorcode=$?
  2>&1 | grep -v "FA[DC]GR[AM]: Field .* is not declared in \`faFieldName.def'"
  set +x
elif [ "$LOCAL_MPI_WRAPPER" ] ; then
  set -x
  time $LOCAL_MPI_WRAPPER -np $MPI_TASKS ./$EXECUTABLE </dev/null \
  errorcode=$?
  2>&1 | grep -v "FA[DC]GR[AM]: Field .* is not declared in \`faFieldName.def'"
  set +x
else
  set -x
  time ./$EXECUTABLE \
  errorcode=$?
  2>&1 | grep -v "FA[DC]GR[AM]: Field .* is not declared in \`faFieldName.def'"
  set +x
fi
echo
if [ "$OUTPUT_LISTING" = "YES" ] ; then
  set -x
  $TOOLSDIR/outsync.sh
  set +x
fi
if [ $FTRACE_JOB -gt 0 ] ; then
  set -x
  $TOOLSDIR/profsync.sh
  set +x
fi
set -x
ls -l $OUTDIR
set +x
set -x
if grep " NSTEP =  1728 CNT0" NODE.001_01 > /dev/null; then
  cp $EXPLIST $OUTPUTDIR/
else
  mkdir $OUTPUTDIR/error
  cp $EXPLIST $OUTPUTDIR/error/
fi
set +x
set -x
cd $TMPGFS
$TOOLSDIR/cleansync.sh
set +x
set -x
$TOOLSDIR/epilog.sh
set +x
if [ "$MTOOL_IS" != "ON" ] && [ "$AUTO_CLEAN" = "ON" ] ; then
  cd $HOME
  \rm -rf $TMPGFS
fi
