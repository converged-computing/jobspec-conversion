#!/bin/bash
#SBATCH --output=slurm-%x-%j-%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx:1

IMG=/home/software/singularity/pytorch.simg
cd ~/ml-tau-reco
singularity exec -B /scratch/persistent --nv $IMG \
  python3 src/endtoend_simple.py
