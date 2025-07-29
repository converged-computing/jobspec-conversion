#!/bin/bash
#SBATCH --job-name=train_constraints
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=4
#SBATCH --mem=200GB
#SBATCH --time=08:00:00
#SBATCH --constraint=a100

set -u
set -e
ulimit -Sn $(ulimit -Hn)
module load singularity
OUTPUT_DIR=/mnt/ceph/users/wzhou/projects/gencad/train/sg_constraints/$SLURM_JOB_ID/
singularity run --nv -B /mnt/ceph/users/wzhou -B $PWD --no-home --writable-tmpfs /mnt/ceph/users/wzhou/images/sketchgraphs.sif \
    bash -c "pip install -e . &&  python -um sketchgraphs_models.autoconstraint.train --dataset_train=/mnt/ceph/users/wzhou/projects/sketchgraphs/data/sg_t16_train.npy --num_workers=16 --batch_size=16384 --world_size=4 --output_dir=${OUTPUT_DIR}"
