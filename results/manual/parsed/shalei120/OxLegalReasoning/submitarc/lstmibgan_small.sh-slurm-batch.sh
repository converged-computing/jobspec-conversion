#!/bin/bash
#SBATCH --job-name=LegalReasoning
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=htc

module load gpu/cuda/9.2.148
echo $PWD
python3 main_small.py -m lstmibgan -s small  > slurm-charge_small_model-$SLURM_JOB_ID.out
