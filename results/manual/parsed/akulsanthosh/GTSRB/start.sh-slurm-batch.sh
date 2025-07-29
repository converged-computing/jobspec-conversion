#!/bin/bash
#SBATCH --job-name=CVHW1
#SBATCH --output=wordcounts_%A_%a.out
#SBATCH --error=wordcounts_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=1GB
#SBATCH --time=00:05:00

module purge
module load python/intel/3.8.6
cd /scratch/$USER/myjarraytest
python wordcount.py sample-$SLURM_ARRAY_TASK_ID.txt
