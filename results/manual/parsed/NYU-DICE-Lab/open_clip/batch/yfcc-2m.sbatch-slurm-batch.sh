#!/bin/bash
#SBATCH --job-name=yfcc-2m
#SBATCH --output=yfcc-2m-%j.log
#SBATCH --mail-user=bf996@nyu.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --mem=192GB
#SBATCH --time=1-23:59:00
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --dependency=24469882

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
