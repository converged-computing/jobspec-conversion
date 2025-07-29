#!/bin/bash
#SBATCH --job-name=Socrat
#SBATCH --output=slurm_output_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=02:00:00
#SBATCH --partition=gpu_titanrtx_shared_course

module purge
module load 2021
module load Anaconda3/2021.05
source activate socrat
srun python -u main.py --data_dir $TMPDIR/ --lm 'google/flan-t5-xl'
