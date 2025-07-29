#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=32G
#SBATCH --time=03:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=h100
#SBATCH --array=1-4

export MODULEPATH='/mnt/home/gkrawezik/modules/rocky8:$MODULEPATH'

module purge
export MODULEPATH=/mnt/home/gkrawezik/modules/rocky8:$MODULEPATH
module load openmpi python-mpi
module load modules/2.1 cuda/12.0 cudnn/cuda12-8.8.0
source ~/envs/score_pytorch_h100/bin/activate
python sample.py $SLURM_ARRAY_TASK_ID fiducial/
