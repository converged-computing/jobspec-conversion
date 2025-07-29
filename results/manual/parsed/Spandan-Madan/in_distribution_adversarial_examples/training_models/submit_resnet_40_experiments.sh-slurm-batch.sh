#!/bin/bash
#SBATCH --job-name=resnet_40_experiments
#SBATCH --output=./slurm_outputs/slurm.%N.%j.out
#SBATCH --error=./slurm_outputs/slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:tesla-k80
#SBATCH --mem=12G
#SBATCH --time=2-02:00:00
#SBATCH --partition=cbmm
#SBATCH --array=0-2

bash resnet_40_experiments.sh ${SLURM_ARRAY_TASK_ID}
