#!/bin/bash
#SBATCH --job-name=relgan-tf-no-gpu
#SBATCH --account=def-amw8
#SBATCH --output=/home/jcoblin/projects/def-amw8/jcoblin/RelGAN/logs/%x-output-no-gpu-%j.log
#SBATCH --error=/home/jcoblin/projects/def-amw8/jcoblin/RelGAN/logs/%x-error-no-gpu-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=1G
#SBATCH --time=00:24:00

source .venv/relgan/bin/activate
module load python/3.7
cd oracle/experiments
echo "Current working directory: `pwd`"
echo "Running main.py"
python oracle_relgan.py $SLURM_ARRAY_TASK_ID -1
