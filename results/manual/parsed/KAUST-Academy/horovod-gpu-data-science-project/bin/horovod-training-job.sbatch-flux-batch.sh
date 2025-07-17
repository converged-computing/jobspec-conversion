#!/bin/bash
#FLUX: --job-name=scruptious-toaster-0346
#FLUX: -N=2
#FLUX: --gpus-per-task=1
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'

set -eo pipefail
PERSISTENT_LOGGING_DIR=../results/$SLURM_JOB_NAME/logs
PERSISTENT_CHECKPOINTS_DIR=$PERSISTENT_LOGGING_DIR/checkpoints
PERSISTENT_TENSORBOARD_DIR=$PERSISTENT_LOGGING_DIR/tensorboard
mkdir -p $PERSISTENT_CHECKPOINTS_DIR
mkdir -p $PERSISTENT_TENSORBOARD_DIR
LOCAL_LOGGING_DIR=/tmp/$SLURM_JOB_NAME/$SLURM_JOB_ID/logs
LOCAL_CHECKPOINTS_DIR=$LOCAL_LOGGING_DIR/checkpoints
LOCAL_TENSORBOARD_DIR=$LOCAL_LOGGING_DIR/tensorboard
mkdir -p $LOCAL_CHECKPOINTS_DIR
mkdir -p $LOCAL_TENSORBOARD_DIR
module purge
module load cuda/10.1.243
conda activate ../env
NVDASHBOARD_PORT=8000
python -m jupyterlab_nvdashboard.server $NVDASHBOARD_PORT &
NVDASHBOARD_PID=$!
TENSORBOARD_PORT=6006
tensorboard --logdir $LOCAL_TENSORBOARD_DIR --port $TENSORBOARD_PORT --bind_all &
TENSORBOARD_PID=$!
HOSTFILE=$PERSISTENT_LOGGING_DIR/hostfile-$SLURM_JOB_ID.txt
scontrol show hostname $SLURM_JOB_NODELIST | awk -v slots=$SLURM_NTASKS_PER_NODE '{print $1 " slots="slots}' > $HOSTFILE
export NCCL_DEBUG=INFO
mpirun --np $SLURM_NTASKS \
       --hostfile $HOSTFILE \
       --verbose \
       python $TRAINING_SCRIPT \
           --data-dir $DATA_DIR \
           --read-checkpoints-from $PERSISTENT_CHECKPOINTS_DIR \
           --write-checkpoints-to  $LOCAL_CHECKPOINTS_DIR \
           --tensorboard-logging-dir $LOCAL_TENSORBOARD_DIR \
           --batch-size 160 
kill $NVDASHBOARD_PID $TENSORBOARD_PID
rsync -a $LOCAL_CHECKPOINTS_DIR/ $PERSISTENT_CHECKPOINTS_DIR
rsync -a $LOCAL_TENSORBOARD_DIR/ $PERSISTENT_TENSORBOARD_DIR
