#!/bin/bash
#SBATCH --job-name=train_primitives_raw
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=4
#SBATCH --mem=200GB
#SBATCH --time=08:00:00
#SBATCH --constraint=v100-32gb

set -u
set -e
ulimit -Sn $(ulimit -Hn)
IMAGE=${IMAGE:-/mnt/ceph/users/wzhou/images/gencad.sif}
OUTPUT_DIR=/mnt/ceph/users/wzhou/projects/gencad/train/primitives_raw/$SLURM_JOB_ID/
mkdir -p $OUTPUT_DIR
module load singularity
singularity run --cleanenv --containall --nv -B /mnt/ceph/users/wzhou -B $PWD -B $HOME/.ssh --no-home --writable-tmpfs $IMAGE \
    bash -c "cd $PWD && pip install -e . && python -um img2cad.train_primitives_raw +cluster=rusty +compute=4xv100 batch_size=4096 hydra.run.dir=$OUTPUT_DIR"
