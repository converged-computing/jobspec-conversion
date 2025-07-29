#!/bin/bash
#SBATCH --job-name=XarmImageReach_norm
#SBATCH --output=./log/xarm_reach_normgoal/%j_%x_%N.out
#SBATCH --error=./log/xarm_reach_normgoal/%j_%x_%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu
#SBATCH --mem=100GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --array=0

srun --mpi=pmi2 -n 1 bash /scratch/$USER/run_singularity_scripts/run_singularity_mpi_torch_2.sh \
     /scratch/$USER/projects/pytorch-visual-learning/config_script.sh
