#!/bin/bash
#FLUX: --job-name=nemo-curator:example-script
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

export BASE_JOB_DIR='`pwd`/nemo-curator-jobs'
export JOB_DIR='$BASE_JOB_DIR/$SLURM_JOB_ID'
export LOGDIR='$JOB_DIR/logs'
export PROFILESDIR='$JOB_DIR/profiles'
export SCHEDULER_FILE='$LOGDIR/scheduler.json'
export SCHEDULER_LOG='$LOGDIR/scheduler.log'
export DONE_MARKER='$LOGDIR/done.txt'
export DEVICE='cpu'
export SCRIPT_PATH='/path/to/script.py'
export SCRIPT_COMMAND='python $SCRIPT_PATH \'
export CONTAINER_IMAGE='/path/to/container'
export BASE_DIR='`pwd`'
export MOUNTS='${BASE_DIR}:${BASE_DIR}'
export CONTAINER_ENTRYPOINT='$BASE_DIR/examples/slurm/container-entrypoint.sh'
export INTERFACE='eth0'
export PROTOCOL='tcp'
export CPU_WORKER_MEMORY_LIMIT='0'
export RAPIDS_NO_INITIALIZE='1'
export CUDF_SPILL='1'
export RMM_SCHEDULER_POOL_SIZE='1GB'
export RMM_WORKER_POOL_SIZE='72GiB'
export LIBCUDF_CUFILE_POLICY='OFF'

export BASE_JOB_DIR=`pwd`/nemo-curator-jobs
export JOB_DIR=$BASE_JOB_DIR/$SLURM_JOB_ID
export LOGDIR=$JOB_DIR/logs
export PROFILESDIR=$JOB_DIR/profiles
export SCHEDULER_FILE=$LOGDIR/scheduler.json
export SCHEDULER_LOG=$LOGDIR/scheduler.log
export DONE_MARKER=$LOGDIR/done.txt
export DEVICE='cpu'
export SCRIPT_PATH=/path/to/script.py
export SCRIPT_COMMAND="python $SCRIPT_PATH \
    --scheduler-file $SCHEDULER_FILE \
    --device $DEVICE"
export CONTAINER_IMAGE=/path/to/container
export BASE_DIR=`pwd`
export MOUNTS="${BASE_DIR}:${BASE_DIR}"
export CONTAINER_ENTRYPOINT=$BASE_DIR/examples/slurm/container-entrypoint.sh
export INTERFACE=eth0
export PROTOCOL=tcp
export CPU_WORKER_MEMORY_LIMIT=0
export RAPIDS_NO_INITIALIZE="1"
export CUDF_SPILL="1"
export RMM_SCHEDULER_POOL_SIZE="1GB"
export RMM_WORKER_POOL_SIZE="72GiB"
export LIBCUDF_CUFILE_POLICY=OFF
mkdir -p $LOGDIR
mkdir -p $PROFILESDIR
srun \
    --container-mounts=${MOUNTS} \
    --container-image=${CONTAINER_IMAGE} \
    ${CONTAINER_ENTRYPOINT}
