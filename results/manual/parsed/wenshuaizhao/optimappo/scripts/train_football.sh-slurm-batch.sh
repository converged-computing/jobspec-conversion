#!/bin/bash
#SBATCH --job-name=football
#SBATCH --account=project_462000215
#SBATCH --output=../results/lumi_output/job_%A_%a.out
#SBATCH --error=../results/lumi_output/array_job_err_%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=52
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=2-00:00:00

SLURM_CPUS_PER_TASK=52
srun --cpus-per-task=$SLURM_CPUS_PER_TASK singularity run --cleanenv \
--rocm -B /scratch/project_462000215/mappo:/users/wenshuai/projects/mappo \
--env PYTHONPATH=/users/wenshuai/projects/mappo/prj_env/lib/python3.8/site-packages \
/scratch/project_462000215/docker/gfootball_latest.sif \
/bin/sh /users/wenshuai/projects/mappo/scripts/train_football_scripts/train_football_corner.sh
