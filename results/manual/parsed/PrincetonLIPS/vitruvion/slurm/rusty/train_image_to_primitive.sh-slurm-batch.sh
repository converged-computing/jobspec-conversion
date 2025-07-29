#!/bin/bash
#SBATCH --job-name=train_image_to_primitive
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=4
#SBATCH --mem=200GB
#SBATCH --time=08:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=v100-32gb

set -u
set -e
ulimit -Sn $(ulimit -Hn)
OUTPUT_DIR=/mnt/ceph/users/wzhou/projects/gencad/train/visual_transformer/$SLURM_JOB_ID/
mkdir -p $OUTPUT_DIR
module load singularity
singularity run --cleanenv --containall --nv -B /mnt/ceph/users/wzhou -B $PWD -B $HOME/.ssh --no-home --writable-tmpfs /mnt/ceph/users/wzhou/images/sketchgraphs.sif \
    bash -c "cd $PWD && pip install -e . && python -um img2cad.train_image_to_primitive +cluster=rusty +compute=4xv100 batch_size=2048 hydra.run.dir=$OUTPUT_DIR"
