#!/bin/bash
#SBATCH --job-name=demo
#SBATCH --output=demo.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=6GB
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=2

export SINGULARITY_CACHEDIR='/tmp/$USER'

mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
module load python/intel/3.8.6
singularity exec --nv \
--bind /scratch \
--overlay labeled.sqsh \
/scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
/bin/bash -c "
python demo.py
"
