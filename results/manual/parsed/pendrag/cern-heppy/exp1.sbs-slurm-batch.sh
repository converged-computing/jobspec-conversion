#!/bin/bash
#SBATCH --job-name=heppy
#SBATCH --output=/mnt/beegfs/sinai-cern/heppy/cern-heppy/slurm-output/exp1_%A_%a.out
#SBATCH --error=/mnt/beegfs/sinai-cern/heppy/cern-heppy/slurm-output/exp1_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --partition=normal

module purge
spack load --dependencies miniconda3
spack load --dependencies cuda@11.1
source /mnt/beegfs/sinai-cern/heppy/cern-heppy/venv/bin/activate
srun python $1
