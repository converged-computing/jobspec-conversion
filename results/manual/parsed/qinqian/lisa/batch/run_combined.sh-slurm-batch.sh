#!/bin/bash
#SBATCH --job-name=lisa_GEO
#SBATCH --output=lisa_%A_%a.out
#SBATCH --error=lisa_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10000
#SBATCH --time=00:08:00
#SBATCH --partition=serial_requeue

export PATH='/n/home08/cliffmeyer/Jingyu/miniconda3/bin:$PATH'

export PATH=/n/home08/cliffmeyer/Jingyu/miniconda3/bin:$PATH
source activate lisa_python3_env
cd /n/home08/cliffmeyer/projects/lisa/gene_num_sample_size
python run_combined.py -s "${SLURM_ARRAY_TASK_ID}" -n $1
