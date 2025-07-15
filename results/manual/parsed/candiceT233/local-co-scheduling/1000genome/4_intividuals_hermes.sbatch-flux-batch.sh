#!/bin/bash
#FLUX: --job-name=4genome_hermes
#FLUX: -t=5400
#FLUX: --urgency=16

export GLOG_minloglevel='1 # 0:log everything, 2: minimal logging'
export FLAGS_logtostderr='1'

SIZE=250000
ADAPTER_MODE="WORKFLOW"
module purge
module load python/miniconda3.7 gcc/9.1.0 git/2.31.1 cmake/3.21.4 
source /share/apps/python/miniconda3.7/etc/profile.d/conda.sh
ulimit -c unlimited
NODE_COUNT=$SLURM_JOB_NUM_NODES
NODE_NAMES=`echo $SLURM_JOB_NODELIST|scontrol show hostnames`
DEV1_DIR=/state/partition1/tang584 # Candice's burst buffer
DEV2_DIR=/files0/oddite/tang584 #Candice's PFS
SCRIPT_DIR=/qfs/projects/oddite/lenny/1000genome-workflow/bin
. ~/spack/share/spack/setup-env.sh
source /qfs/people/tang584/hermes_stage/hermes/load_hermes_dep.sh
HERMES_INSTALL_DIR=/qfs/people/tang584/install/hermes
HERMES_SCRIPT=$HOME/scripts/local-co-scheduling/1000genome
CONFIG_DIR=$HERMES_SCRIPT/hermes_configs
HERMES_DEFAULT_CONF=$CONFIG_DIR/hermes_1000genome_default.yaml
HERMES_CONF=$CONFIG_DIR/hermes.yaml
if [ "$NODE_COUNT" = "1" ]; then
    sed "s/\$HOST_BASE_NAME/\"localhost\"/" $HERMES_DEFAULT_CONF  > $HERMES_CONF
    sed -i "s/\$HOST_NUMBER_RANGE/ /" $HERMES_CONF
else
    sed "s/\$HOST_BASE_NAME/\"node\"/" $HERMES_DEFAULT_CONF  > $HERMES_CONF
    rpc_host_number_range=$(echo "$SLURM_JOB_NODELIST" | grep -Po '[\[].*[\]]')
    sed -i "s/\$HOST_NUMBER_RANGE/${rpc_host_number_range}/" $HERMES_CONF
fi
echo "NODE_NAMES = $NODE_NAMES"
echo "SLURM_JOB_NODELIST = $SLURM_JOB_NODELIST"
hostlist=$(echo -e "$NODE_NAMES" | xargs | sed -e 's/ /,/g')
echo "hostlist = $hostlist"
mkdir -p $DEV1_DIR/hermes_slabs
mkdir -p $DEV2_DIR/hermes_swaps
rm -rf $DEV1_DIR/hermes_slabs/*
rm -rf $DEV2_DIR/hermes_swaps/*
export GLOG_minloglevel=1 # 0:log everything, 2: minimal logging
export FLAGS_logtostderr=1
START_INDIVIDUALS () {
    list=()
    while read -ra tmp; do
        list+=("${tmp[@]}")
    done <<< "$NODE_NAMES"
    if [ $SIZE -eq 250000 ]
    then
        INCREMENT=1000
        a=1
        b=1001
    else
        INCREMENT=1
        a=0
        b=1
    fi
    set -x
    for i in {0..3}
    do
        a=$(($a + $INCREMENT))
        b=$(($b + $INCREMENT))
        echo "running node: ${list[$i]} t$i $a $b ADAPTER_MODE=$ADAPTER_MODE"
        # srun -w ${list[$i]} -n1 -N1 --exclusive which mpirun
        # if [ $i -eq 3 ]; then export HERMES_STOP_DAEMON=1; fi
        srun -w ${list[$i]} -n1 -N1 --exclusive \
            mpirun -np 1 \
                -genv LD_PRELOAD=$HERMES_INSTALL_DIR/lib/libhermes_posix.so \
                -genv HERMES_CONF=$HERMES_CONF \
                -genv ADAPTER_MODE=$ADAPTER_MODE \
                -genv HERMES_STOP_DAEMON=0 \
                -genv HERMES_CLIENT=1 \
            $SCRIPT_DIR/individuals.py $HERMES_SCRIPT/ALL.chr1.250000.vcf 1 $a $b $SIZE &
    done
    # sleep 3
    set +x
}
START_HERMES_DAEMON (){
    for node in $NODE_NAMES
    do
        echo $node
        # HERMES_DAEMON $node
        srun -w $node -n1 -N1 killall hermes_daemon
        export HERMES_CONF=${HERMES_CONF} 
        srun -w $node -n1 -N1 mpirun ${HERMES_INSTALL_DIR}/bin/hermes_daemon &
    done
    sleep 3
}
STOP_DAEMON() {
    mpirun -np $NODE_COUNT -ppn 1 -host $hostlist \
        -genv LD_PRELOAD=$HERMES_INSTALL_DIR/lib/libhermes_posix.so \
        -genv HERMES_CONF=$HERMES_CONF \
        -genv ADAPTER_MODE=$ADAPTER_MODE \
        -genv HERMES_STOP_DAEMON=1 \
        -genv HERMES_CLIENT=1 \
        echo "finished"
}
HERMES_DATA_STAGEIN (){
    # data stage_in
    start_time=$SECONDS
    STAGE_PROCS=1
    ALL_PPROCS=$(( $STAGE_PROCS * $NODE_COUNT ))
    mpirun -np $ALL_PPROCS -ppn $STAGE_PROCS -host $hostlist \
        $HERMES_INSTALL_DIR/bin/stage_in $HERMES_SCRIPT/ALL.chr1.250000.vcf 0 0 MinimizeIoTime
    duration=$(($SECONDS - $start_time))
    echo "HERMES_DATA_STAGEIN done... $(($duration / 3600)) seconds and $(($duration % 3600)) milliseconds elapsed."
    # mpirun -n $STAGE_PROCS $HERMES_INSTALL_DIR/bin/stage_in $HERMES_SCRIPT/ALL.chr1.250000.vcf 0 0 MinimizeIoTime
}
hostname;date;
set -x
rm -rf $HERMES_SCRIPT/chr1n-*
mpirun -np $NODE_COUNT -ppn 1 -host $hostlist killall hermes_daemon
mpirun -np $NODE_COUNT -ppn 1 -host $hostlist -genv HERMES_CONF=$HERMES_CONF $HERMES_INSTALL_DIR/bin/hermes_daemon &
sleep 10
ls -la /state/partition1/tang584/hermes_slabs/
(
    start_time=$SECONDS
    START_INDIVIDUALS
    wait
    duration=$(($SECONDS - $start_time))
    echo "INDIVIDUALS done... $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
)
STOP_DAEMON
ls -lh $HERMES_SCRIPT | grep "chr1n-"
set +x
hostname;date;
sacct -j $SLURM_JOB_ID -o jobid,submit,start,end,state
rm -rf core.*
