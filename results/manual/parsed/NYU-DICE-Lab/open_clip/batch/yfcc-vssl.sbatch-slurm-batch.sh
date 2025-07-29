#!/bin/bash
#FLUX: --job-name=yfcc_vssl_vit
#FLUX: -c=8
#FLUX: -t=172740
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK;'
export MASTER_PORT='$(shuf -i 10000-65500 -n 1)'
export WORLD_SIZE='$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))'
export MASTER_ADDR='$(hostname -s).hpc.nyu.edu'

module purge;
echo $SLURM_JOB_NAME
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK;
export MASTER_PORT=$(shuf -i 10000-65500 -n 1)
export WORLD_SIZE=$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))
echo "WORLD_SIZE="$WORLD_SIZE
export MASTER_ADDR="$(hostname -s).hpc.nyu.edu"
echo "MASTER_ADDR="$MASTER_ADDR
srun --cpu_bind=v --accel-bind=v \
    /bin/bash "/scratch/bf996/open_clip/src/script/run-singularity.bash" \
    /bin/bash -c \
    'export PYTHONPATH="$PYTHONPATH:/scratch/bf996/open_clip/src"; python -u /scratch/bf996/open_clip/src/training/main.py --train-data="/scratch/bf996/datasets/yfcc15m/yfcc-small-metadata.csv" --csv-separator "," --zeroshot-frequency=8 --imagenet-a "/imagenet-a" --imagenet-r "/imagenet-r" --imagenet-val "/imagenet/val/" --imagenet-v2 "/scratch/bf996/datasets" --save-frequency 1 --report-to wandb --warmup 2000 --batch-size=128 --precision=fp32 --norm_gradient_clip=1e5 --epochs=32 --workers=8 --model="resnet50" --dcl=True'
