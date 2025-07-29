#!/bin/bash
#SBATCH --job-name=ddpg_Walker2D
#SBATCH --account=nesi00272
#SBATCH --output=%A_%a.out
#SBATCH --error=%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4096
#SBATCH --time=12-12:00:00
#SBATCH --chdir=/nesi/project/nesi00272/primal_dual_baseline/baselines/ddpg/
#SBATCH --array=50-80:1

export PATH='/home/yiming.peng/miniconda3/bin/:$PATH'

bash
export PATH=/home/yiming.peng/miniconda3/bin/:$PATH
source activate cmaes_baselines
python main.py --env-id Walker2DBulletEnv-v0 --seed $SLURM_ARRAY_TASK_ID
