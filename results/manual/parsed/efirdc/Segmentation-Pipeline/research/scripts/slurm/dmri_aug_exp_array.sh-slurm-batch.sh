#!/bin/bash
#SBATCH --account=def-uofavis-ab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100l:1
#SBATCH --mem=6GB
#SBATCH --time=08:00:00
#SBATCH --array=0-6

export MPLBACKEND='agg'

nvidia-smi
module load python/3.8
source ~/ENV_new/bin/activate
export MPLBACKEND=agg
python research/dmri_hippo/generate_parallel_commands.py | parallel --jobs 3
