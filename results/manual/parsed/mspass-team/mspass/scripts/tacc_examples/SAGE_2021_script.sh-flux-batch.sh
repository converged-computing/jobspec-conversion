#!/bin/bash
#FLUX: --job-name=mspass
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --urgency=16

WORK_DIR=$SCRATCH/SAGE_2021
MSPASS_CONTAINER=$WORK/mspass/mspass_latest.sif
SING_COM="singularity run $MSPASS_CONTAINER"
ml unload xalt
ml tacc-singularity
module list
pwd
date
NODE_HOSTNAME=`hostname -s`
echo "primary node $NODE_HOSTNAME"
LOGIN_PORT=`echo $NODE_HOSTNAME | perl -ne 'print (($2+1).$3.$1) if /c\d(\d\d)-(\d)(\d\d)/;'`
echo "got login node port $LOGIN_PORT"
for i in `seq 4`; do
    ssh -q -f -g -N -R $LOGIN_PORT:$NODE_HOSTNAME:8888 login$i
done
echo "Created reverse ports on Stampede2 logins"
SLEEP_TIME=15
mkdir -p $WORK_DIR
cd $WORK_DIR
SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
SINGULARITYENV_MSPASS_ROLE=scheduler $SING_COM &
WORKER_LIST=`scontrol show hostname ${SLURM_NODELIST} | \
             awk -vORS=, -v hostvar="$NODE_HOSTNAME" '{ if ($0!=hostvar) print $0 }' | \
             sed 's/,$/\n/'`
echo $WORKER_LIST
SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
SINGULARITYENV_MSPASS_TMP_DATA_DIR='/tmp/data_files' \
SINGULARITYENV_MSPASS_SCRATCH_DATA_DIR=$WORK_DIR/data_files \
SINGULARITYENV_MSPASS_SCHEDULER_ADDRESS=$NODE_HOSTNAME \
SINGULARITYENV_MSPASS_WORKER_ARG="--nprocs 48 --nthreads 1" \
SINGULARITYENV_MSPASS_ROLE=worker \
mpiexec.hydra -n $((SLURM_NNODES-1)) -ppn 1 -hosts $WORKER_LIST $SING_COM &
SINGULARITYENV_MSPASS_DB_PATH='tmp' \
SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
SINGULARITYENV_MSPASS_TMP_DATA_DIR='/tmp/data_files' \
SINGULARITYENV_MSPASS_SCRATCH_DATA_DIR=$WORK_DIR/data_files \
SINGULARITYENV_MSPASS_ROLE=db $SING_COM &
sleep 10
SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
SINGULARITYENV_MSPASS_SCHEDULER_ADDRESS=$NODE_HOSTNAME \
SINGULARITYENV_MSPASS_DB_ADDRESS=$NODE_HOSTNAME \
SINGULARITYENV_MSPASS_SLEEP_TIME=$SLEEP_TIME \
SINGULARITYENV_MSPASS_ROLE=frontend $SING_COM
