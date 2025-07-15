#!/bin/bash
#FLUX: --job-name=hicma-dev
#FLUX: -c=32
#FLUX: -t=60
#FLUX: --urgency=16

export STARPU_CALIBRATE='0'

export STARPU_CALIBRATE=0
numnodes=1
numtasks=1
numthreads=1
tracearg=""
prog=""
minmaxsub=""
dry=""
if [ $# -eq 14 ]; then
    numnodes=$1
    nummpi=$2
    numthreads=$3
    trace=$4
    prog=$5
    minmaxsub=$6
    exps="$7"
    dry=$8
    sizefile=$9
    time_limit=${10}
    queue=${11}
    scheds=${12}
    maxsub=${13}
    minsub=${14}
else
    echo "usage: $0 numnodes nummpi numthreads [trace,-] [hic,cham] [enable minmaxsub depending on #tasks,-] exps [dry,-] sizefile time_limit queue scheds [maxsub,-] [minsub,]"
    echo
    echo "Your input:"
    echo $*
    exit
fi
sr=$numnodes #$(echo "scale=0;sqrt ( $numnodes ) / 1" | bc -l) ;
p=$(echo " ( l($sr) / l(2) )/2" | bc -l) ;
p=$(echo " scale=0;( $p / 1 ) " | bc -l) ;
sqrt_numnodes=$(echo " scale=0;( 2 ^ $p )/1 " | bc -l) ;
sqrt_numnodesQ=$((numnodes/sqrt_numnodes))
ntasks_per_node=$((nummpi/numnodes))
_factor=2 #TODO #ratio of mb/maxrank
_acc=8          #fixed accuracy
if [ ! -f "$sizefile" ]; then
    echo "Size file does not exist: $sizefile"
    exit
fi
. $sizefile
sruncmd="" 
for sched in $scheds;do
    export STARPU_SCHED=$sched
    #Loop over experimental cases
    for iexp in $exps;do 
        echo Experiment case:$iexp nrows:${nrows[iexp]} mb:${nb[iexp]}
        _m=${nrows[iexp]} 
        _b=${nb[iexp]}
        if [ -z "$_m" ]; then 
            continue
        fi
        if [ -z "$_b" ]; then 
            continue
        fi
        _mb=$_b;
        _storage_maxrk=200
        _n=$((_m/_mb*_storage_maxrk));
        _nb=$_storage_maxrk
	#ss
        _maxrank=$_nb
	#edsin
        _maxrank=400
        if [ "$prog" == "hic" ]; then
	    rankfile=$HOME/hicma-dev/exp/ranks/$prog-$sched-$_m-$_mb-$_nb-$numnodes-$nummpi-$numthreads-$SLURM_JOBID-SS-$_acc-$_maxrank
            cmd="$HOME/hicma-dev/build/timing/time_zpotrf_tile \
            --m=$_m \
            --n_range=$_n:$_n \
            --k=$_m \
            --mb=$_mb \
            --nb=$_nb \
            --nowarmup \
            --threads=$numthreads \
            --p=1 \
            $tracearg \
            --rk=0 \
            --acc=$_acc \
            --starshdecay=2 \
            --starshmaxrank=$_maxrank \
            --starshwavek=100 \
	    --ss \
	    --rankfile=$rankfile \
	    "
        elif [ "$prog" == "cham" ]; then
            if [ "$trace" != "-" ]; then
                cmd="/project/k1205/akbudak/hicma-dev/chameleon/build-fxt-s121/timing/time_dpotrf_tile --nowarmup --p=$sqrt_numnodes --m=$_m --n_range=$_m:$_m:$_m --nb=$_b --threads=$numthreads $tracearg"
            else
                cmd="/project/k1205/akbudak/hicma-dev/chameleon/build/timing/time_dpotrf_tile --nowarmup --p=$sqrt_numnodes --m=$_m --n_range=$_m:$_m:$_m --nb=$_b --threads=$numthreads"
            fi
        fi
        minmaxsubinfo=
        if [ "$minmaxsub" != "-" ]; then
            _mt=$((_m/_mb))
            _ntasks=$((_mt*_mt*_mt/3))
            _maxsub=$((_ntasks/8))
            _minsub=$((_ntasks/10))
            #_maxsub=10000; _minsub=8000
            #_maxsub=1000;  _minsub=500
            minmaxsubinfo="MT:$_mt NTASKS:$_ntasks MAXSUB:$_maxsub MINSUB:$_minsub"
            export STARPU_LIMIT_MAX_SUBMITTED_TASKS=$_maxsub
            export STARPU_LIMIT_MIN_SUBMITTED_TASKS=$_minsub
        fi
        if [ "$maxsub" != "-" -a "$minsub" != "-" ]; then
            minmaxsubinfo="MAXSUB:$maxsub MINSUB:$minsub"
            export STARPU_LIMIT_MAX_SUBMITTED_TASKS=$maxsub
            export STARPU_LIMIT_MIN_SUBMITTED_TASKS=$minsub
        fi
        msg="M:$_m N:$_n MB:$_mb NB:$_nb MAXRANK:$_maxrank DATE:`date` SCHED:$STARPU_SCHED CMD:$cmd $minmaxsubinfo" 
        echo "!BEGIN:" $msg 
        if [ "$trace" != "-" ]; then
            traceprefix=`pwd`/exp/trace/$prog-$sched-$_m-$_mb-$_nb-$numnodes-$nummpi-$numthreads/$SLURM_JOBID
            mkdir -p $traceprefix
            export STARPU_FXT_PREFIX=$traceprefix
        fi
        if [ "$dry" == "dry" ]; then
            echo $cmd
        else
            echo "!BEGIN:" $msg 1>&2 
	    export MKL_NUM_THREADS=1 
	    export KMP_AFFINITY=granularity=fine,scatter
            $sruncmd $cmd
            echo "!END:" $msg 
            echo "!END:" $msg 1>&2 
        fi
        if [ "$trace" != "-" ]; then
            combinedtrace=${traceprefix}trace
            /project/k1205/akbudak/codes/starpu-1.2.1-fxt/tools/starpu_fxt_tool -i ${traceprefix}prof_file_akbudak_* -o ${combinedtrace}
            mv activity.data  dag.dot  data.rec  distrib.data  tasks.rec  trace.html $traceprefix/ #paje.trace    
            echo $SLURM_JOBID > $traceprefix/0_jobid 
            #echo "Dot is starting:"
            #dot -Tpng $traceprefix/dag.dot -o $traceprefix/$prog.png
            #echo "Dot ended"
        fi
        echo
        date
    done
done
exit 0
    --printindex \
    --check \
    --printmat \
    --printindex \
    --trace \
--tag-output --timestamp-output 
$SLURM_JOBID    Job ID  5741192 $PBS_JOBID
$SLURM_JOB_NAME Job Name    myjob   $PBS_JOBNAME
$SLURM_SUBMIT_DIR   Submit Directory    /lustre/payerle/work    $PBS_O_WORKDIR
$SLURM_JOB_NODELIST Nodes assigned to job   compute-b24-[1-3,5-9],compute-b25-[1,4,8]   cat $PBS_NODEFILE
$SLURM_SUBMIT_HOST  Host submitted from login-1.deepthought2.umd.edu    $PBS_O_HOST
$SLURM_JOB_NUM_NODES    Number of nodes allocated to job    2   $PBS_NUM_NODES
$SLURM_CPUS_ON_NODE Number of cores/node    8,3 $PBS_NUM_PPN
$SLURM_NTASKS   Total number of cores for job???    11  $PBS_NP
$SLURM_NODEID   Index to node running on
relative to nodes assigned to job   0   $PBS_O_NODENUM
$PBS_O_VNODENUM Index to core running on
within node 4   $SLURM_LOCALID
$SLURM_PROCID   Index to task relative to job   0   $PBS_O_TASKNUM - 1
