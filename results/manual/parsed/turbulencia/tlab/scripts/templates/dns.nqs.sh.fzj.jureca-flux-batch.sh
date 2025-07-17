#!/bin/bash
#FLUX: --job-name=hanky-onion-6721
#FLUX: --queue=batch
#FLUX: --urgency=16

export TOOLS_HOME='$HOME/bin'
export PATH='$PATH:$TOOLS_HOME'
export CONFIG_FILE='$TOOLS_HOME/CONFIG.default'
export PSP_OPENIB='0'
export PSP_UCP='1'
export PSP_ONDEMAND='0'
export PSP_GUARD='0'

export TOOLS_HOME=$HOME/bin
export PATH=$PATH:$TOOLS_HOME
export CONFIG_FILE=$TOOLS_HOME/CONFIG.default
. $CONFIG_FILE
ABORT="no"
LOCALDIR=$WORK/$JOBDIR
TRASHDIR=$WORK/$JOBDIR-transfered
mkdir -p $LOCALDIR
cd $LOCALDIR
dns.pre $LOCALDIR $STEP
touch *
module purge
module load Intel ParaStationMPI FFTW GCCcore/.8.3.0 CMake imkl
if [ $THREADSPERRANK -ge 2 ]; then
    export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
    export OMP_MAX_THREADS=${SLURM_CPUS_PER_TASK}
    export KMP_AFFINITY=compact
fi
export PSP_OPENIB=0
export PSP_UCP=1
export PSP_ONDEMAND=0
export PSP_GUARD=0
case $RUNMODE in
  "preprocess" )
    preprocess $TIMESTAMP
    ABORT="yes"
    ;;
  "simulation" )
    simulation $TIMESTAMP
    if [ $? -ne 0 ]; then
       ABORT="yes"
    fi 
    ;;
  "postprocess" )
    postprocess $TIMESTAMP
    ABORT="yes"
  ;;
esac
if [ -f tlab.err ]; then
    ABORT="yes"
fi
if [ -f tlab.err.0 ]; then
    ABORT="yes"
fi
stat -t core* >/dev/null 2>&1 && ABORT="yes"
if [ -f tlab.ini ]; then
    cp tlab.ini tlab.ini-$TIMESTAMP
fi
LOGFILES="tlab.ini.bak tlab.log dns.out dns.les partinfos.txt mapping.txt"
for FILE in $LOGFILES; do
    if [ -f $FILE ]; then
        mv $FILE $FILE-$TIMESTAMP
    fi
done
STATSDIR=stats-$TIMESTAMP
if [ ! -e $STATSDIR ]; then
    mkdir $STATSDIR
    if [ -f tlab.ini ]; then
	cp tlab.ini $STATSDIR
    fi
    LIST=`ls | egrep 'avg[0-9]|?cr[0-9]|?sp[0-9]|pdf[0-9]|cavgXi[0-9]|pdfXi[0-9]|int[0-9]|kin[0-9]'`
    echo "Moving statistic files into $STATSDIR"
    if [ -n "$LIST" ]; then
       mv $LIST $STATSDIR
    fi
else
    echo "$STATSDIR exists. Aborting"
fi
if [ $RUNMODE = "simulation" ];then
    if [ $ABORT = "no" ]; then
	if [ -f $LOCALDIR/dns.nqs.new-vars ]; then
	    . $LOCALDIR/dns.nqs.new-vars
	fi
	if [ -f $LOCALDIR/tlab.ini ]; then
	    ITIME=`awk -F"=" '{ 
				if ( $1 == "End" ) 
				    {
				    print $2 
				    }
			    }' $LOCALDIR/tlab.ini` 
	else
	    echo "Error getting max time"
	    exit 1
	fi
	if [ $ITIME -lt $MAXITER ]; then
	    # Submit Script
	    qsend -name $NAME -time $TIME -maxiter $MAXITER -mem $MEM \
	          -script $SCRIPT -jobdir $JOBDIR -step $STEP -np $NP \
                  -rankspernode $RANKSPERNODE -threadsperrank $THREADSPERRANK -commmode $COMMMODE
	fi       
    fi
fi
