#!/bin/bash
#FLUX: --job-name=yfcc-2m
#FLUX: -c=8
#FLUX: -t=172740
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MASTER_PORT='$(shuf -i 10000-65500 -n 1)'
export MASTER_ADDR='$(hostname -s).hpc.nyu.edu'

module purge;
echo $SLURM_JOB_NAME
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MASTER_PORT=$(shuf -i 10000-65500 -n 1)
export MASTER_ADDR="$(hostname -s).hpc.nyu.edu"
srun --cpu_bind=v --accel-bind=v \
    /bin/bash src/script/run-singularity.bash \
    /bin/bash -c \
    'export PYTHONPATH="$PYTHONPATH:$PWD/src"; python src/training/main.py --report-to wandb --train-data="/scratch/bf996/open_clip/yfcc-subsets/yfcc-random-2m.csv" --csv-separator "," --imagenet-a "/imagenet-a" --imagenet-r "/imagenet-r" --imagenet-val "/imagenet/val/" --imagenet-v2 "/scratch/bf996/datasets" --imagenet-s "/imagenet-sketch" --zeroshot-frequency=8 --save-frequency 4 --warmup 2000 --batch-size=256 --epochs=32 --workers=8 --model=RN50 --local-loss --gather-with-grad'
