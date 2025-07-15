#!/bin/bash
#FLUX: --job-name=muffled-kitty-3553
#FLUX: --priority=16

ml unload xalt
ml tacc-singularity
module list
pwd
date
WORK_DIR=$SCRATCH/mspass/workdir
MSPASS_CONTAINER=$WORK2/mspass/mspass_latest.sif
DB_PATH='scratch'
HOSTNAME_BASE='stampede2.tacc.utexas.edu'
DB_SHARDING=true
SHARD_DATABASE="usarraytest"
SHARD_COLLECTIONS=(
    "arrival:_id"
)
SING_COM="singularity run $MSPASS_CONTAINER"
NODE_HOSTNAME=`hostname -s`
echo "primary node $NODE_HOSTNAME"
LOGIN_PORT=`echo $NODE_HOSTNAME | perl -ne 'print (($2+1).$3.$1) if /c\d(\d\d)-(\d)(\d\d)/;'`
STATUS_PORT=`echo "$LOGIN_PORT + 1" | bc -l`
echo "got login node port $LOGIN_PORT"
for i in `seq 4`; do
    ssh -q -f -g -N -R $LOGIN_PORT:$NODE_HOSTNAME:8888 login$i
    ssh -q -f -g -N -R $STATUS_PORT:$NODE_HOSTNAME:8787 login$i
done
echo "Created reverse ports on Stampede2 logins"
mkdir -p $WORK_DIR
cd $WORK_DIR
SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
SINGULARITYENV_MSPASS_ROLE=scheduler $SING_COM &
WORKER_LIST=`scontrol show hostname ${SLURM_NODELIST} | \
             awk -vORS=, -v hostvar="$NODE_HOSTNAME" '{ if ($0!=hostvar) print $0 }' | \
             sed 's/,$/\n/'`
echo $WORKER_LIST
SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
SINGULARITYENV_MSPASS_SCHEDULER_ADDRESS=$NODE_HOSTNAME \
SINGULARITYENV_MSPASS_ROLE=worker \
mpiexec.hydra -n $((SLURM_NNODES-1)) -ppn 1 -hosts $WORKER_LIST $SING_COM &
if [ "$DB_SHARDING" = true ] ; then
    echo 'Using Sharding MongoDB'
    # extract the hostname of each worker node
    OLD_IFS=$IFS
    IFS=","
    WORKER_LIST_ARR=($WORKER_LIST)
    IFS=$OLD_IFS
    # control the interval between mongo instance and mongo shell execution
    SLEEP_TIME=15
    # start a dbmanager container in the primary node
    username=`whoami`
    for i in ${!WORKER_LIST_ARR[@]}; do
        SHARD_LIST[$i]="rs$i/${WORKER_LIST_ARR[$i]}.${HOSTNAME_BASE}:27017"
        SHARD_ADDRESS[$i]="$username@${WORKER_LIST_ARR[$i]}.${HOSTNAME_BASE}"
        SHARD_DB_PATH[$i]="$username@${WORKER_LIST_ARR[$i]}.${HOSTNAME_BASE}:/tmp/db/data_shard_$i"
        SHARD_LOGS_PATH[$i]="$username@${WORKER_LIST_ARR[$i]}.${HOSTNAME_BASE}:/tmp/logs/mongo_log_shard_$i"
    done
    SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
    SINGULARITYENV_MSPASS_SHARD_DATABASE=${SHARD_DATABASE} \
    SINGULARITYENV_MSPASS_SHARD_COLLECTIONS=${SHARD_COLLECTIONS[@]} \
    SINGULARITYENV_MSPASS_SHARD_LIST=${SHARD_LIST[@]} \
    SINGULARITYENV_MSPASS_SLEEP_TIME=$SLEEP_TIME \
    SINGULARITYENV_MSPASS_ROLE=dbmanager $SING_COM &
    # ensure enough time for dbmanager to finish
    sleep 30
    # start a shard container in each worker node
    # mipexec could be cleaner while ssh would induce more complexity
    for i in ${!WORKER_LIST_ARR[@]}; do
        SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
        SINGULARITYENV_MSPASS_SHARD_ID=$i \
        SINGULARITYENV_MSPASS_DB_PATH=$DB_PATH \
        SINGULARITYENV_MSPASS_SLEEP_TIME=$SLEEP_TIME \
        SINGULARITYENV_MSPASS_CONFIG_SERVER_ADDR="configserver/${NODE_HOSTNAME}.${HOSTNAME_BASE}:27018" \
        SINGULARITYENV_MSPASS_ROLE=shard \
        mpiexec.hydra -n 1 -ppn 1 -hosts ${WORKER_LIST_ARR[i]} $SING_COM &
    done
    # Launch the jupyter notebook frontend in the primary node.
    # Run in batch mode if the script was
    # submitted with a "-b notebook.ipynb"
    if [ $# -eq 0 ]; then
        SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
        SINGULARITYENV_MSPASS_SCHEDULER_ADDRESS=$NODE_HOSTNAME \
        SINGULARITYENV_MSPASS_DB_ADDRESS=$NODE_HOSTNAME \
        SINGULARITYENV_MSPASS_DB_PATH=$DB_PATH \
        SINGULARITYENV_MSPASS_SHARD_ADDRESS=${SHARD_ADDRESS[@]} \
        SINGULARITYENV_MSPASS_SHARD_DB_PATH=${SHARD_DB_PATH[@]} \
        SINGULARITYENV_MSPASS_SHARD_LOGS_PATH=${SHARD_LOGS_PATH[@]} \
        SINGULARITYENV_MSPASS_DB_MODE="shard" \
        SINGULARITYENV_MSPASS_ROLE=frontend $SING_COM
    else
        while getopts "b:" flag
        do
            case "${flag}" in
                b) notebook_file=${OPTARG};
            esac
        done
        SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
        SINGULARITYENV_MSPASS_SCHEDULER_ADDRESS=$NODE_HOSTNAME \
        SINGULARITYENV_MSPASS_DB_ADDRESS=$NODE_HOSTNAME \
        SINGULARITYENV_MSPASS_DB_PATH=$DB_PATH \
        SINGULARITYENV_MSPASS_SHARD_ADDRESS=${SHARD_ADDRESS[@]} \
        SINGULARITYENV_MSPASS_SHARD_DB_PATH=${SHARD_DB_PATH[@]} \
        SINGULARITYENV_MSPASS_SHARD_LOGS_PATH=${SHARD_LOGS_PATH[@]} \
        SINGULARITYENV_MSPASS_DB_MODE="shard" \
        SINGULARITYENV_MSPASS_ROLE=frontend $SING_COM --batch $notebook_file
    fi
else
    echo "Using Single node MongoDB"
    # start a db container in the primary node
    SINGULARITYENV_MSPASS_DB_PATH=$DB_PATH \
    SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
    SINGULARITYENV_MSPASS_ROLE=db $SING_COM &
    # ensure enough time for db instance to finish
    sleep 10
    # Launch the jupyter notebook frontend in the primary node.
    # Run in batch mode if the script was
    # submitted with a "-b notebook.ipynb"
    if [ $# -eq 0 ]; then
        SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
        SINGULARITYENV_MSPASS_SCHEDULER_ADDRESS=$NODE_HOSTNAME \
        SINGULARITYENV_MSPASS_DB_ADDRESS=$NODE_HOSTNAME \
        SINGULARITYENV_MSPASS_SLEEP_TIME=$SLEEP_TIME \
        SINGULARITYENV_MSPASS_ROLE=frontend $SING_COM
    else
        while getopts "b:" flag
        do
            case "${flag}" in
                b) notebook_file=${OPTARG};
            esac
        done
        SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
        SINGULARITYENV_MSPASS_SCHEDULER_ADDRESS=$NODE_HOSTNAME \
        SINGULARITYENV_MSPASS_DB_ADDRESS=$NODE_HOSTNAME \
        SINGULARITYENV_MSPASS_SLEEP_TIME=$SLEEP_TIME \
        SINGULARITYENV_MSPASS_ROLE=frontend $SING_COM --batch $notebook_file
    fi
fi
