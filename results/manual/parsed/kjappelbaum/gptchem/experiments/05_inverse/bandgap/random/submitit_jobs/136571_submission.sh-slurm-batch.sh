#!/bin/bash
#SBATCH --job-name=submitit
#SBATCH --output=/home/kevin/gptchem/experiments/05_inverse/bandgap/random/submitit_jobs/%A_%a_0_log.out
#SBATCH --error=/home/kevin/gptchem/experiments/05_inverse/bandgap/random/submitit_jobs/%A_%a_0_log.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --array=0-99%32

export SUBMITIT_EXECUTOR='slurm'

export SUBMITIT_EXECUTOR=slurm
srun --unbuffered --output /home/kevin/gptchem/experiments/05_inverse/bandgap/random/submitit_jobs/%A_%a_%t_log.out --error /home/kevin/gptchem/experiments/05_inverse/bandgap/random/submitit_jobs/%A_%a_%t_log.err /home/kevin/miniconda3/envs/gpt3/bin/python -u -m submitit.core._submit /home/kevin/gptchem/experiments/05_inverse/bandgap/random/submitit_jobs
