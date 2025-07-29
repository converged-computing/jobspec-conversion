#!/bin/bash
#SBATCH --job-name=side_XarmPickandPlace
#SBATCH --output=./log/xarm_pickandplace_fixed_normgoal/%j_%x_%N.out
#SBATCH --error=./log/xarm_pickandplace_fixed_normgoal/%j_%x_%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu
#SBATCH --mem=100GB
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0

srun --mpi=pmi2 -n 1 bash /scratch/$USER/run_singularity_scripts/run_singularity_mpi_torch_3.sh \
     /scratch/$USER/projects/pytorch-visual-learning/config_script_pickandplace.sh
