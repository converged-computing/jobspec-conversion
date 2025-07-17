#!/bin/bash
#FLUX: --job-name=aldi
#FLUX: -c=64
#FLUX: --queue=vision-beery
#FLUX: -t=43200
#FLUX: --urgency=16

export HOME='/tmp/aldi-$USER'
export TMPDIR='$HOME/.tmp'
export CACHEDIR='$HOME/.cache'
export SINGULARITY_CACHEDIR='$CACHEDIR/singularity'
export LEADER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export WORLD_SIZE='$(($SLURM_JOB_NUM_NODES * $SLURM_NTASKS_PER_NODE))'
export LEADER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'

export HOME=/tmp/aldi-$USER
export TMPDIR=$HOME/.tmp
export CACHEDIR=$HOME/.cache
export SINGULARITY_CACHEDIR=$CACHEDIR/singularity
mkdir -p $HOME
mkdir -p $TMPDIR
mkdir -p $CACHEDIR
mkdir -p $SINGULARITY_CACHEDIR
export LEADER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
export WORLD_SIZE=$(($SLURM_JOB_NUM_NODES * $SLURM_NTASKS_PER_NODE))
export LEADER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
echo "WORLD_SIZE="$WORLD_SIZE
echo "LEADER_ADDR="$LEADER_ADDR
CFG="${1:-configs/cityscapes/Base-RCNN-FPN-Cityscapes_strongaug_ema.yaml}"
srun --nodes=1 bash -c "\
    export HOME=$HOME && \
    export TMPDIR=$TMPDIR && \
    export CACHEDIR=$CACHEDIR && \
    export SINGULARITY_CACHEDIR=$SINGULARITY_CACHEDIR && \
    mkdir -p $HOME && \
    mkdir -p $TMPDIR && \
    mkdir -p $CACHEDIR && \
    mkdir -p $SINGULARITY_CACHEDIR && \
    singularity exec --nv --bind /archive/vision/beery ../aldi.img python tools/download_model_for_config.py --config-file $CFG && \
    nvidia-smi && \
    singularity exec --nv --bind /archive/vision/beery ../aldi.img python tools/train_net.py \
        --machine-rank \$SLURM_PROCID \
        --num-machines $SLURM_JOB_NUM_NODES \
        --num-gpus 8 \
        --dist-url tcp://$LEADER_ADDR:$LEADER_PORT \
        --config-file $CFG ${@:2} SOLVER.IMS_PER_GPU 6"
