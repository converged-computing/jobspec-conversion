#!/bin/bash
#SBATCH --job-name=LiH-dissoc-curve
#SBATCH --account=jvandyke_alloc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8gb
#SBATCH --time=5-00:00:00
#SBATCH --partition=normal_q
#SBATCH --array=0-9

source activate chem
python BeH2.py 1.0 1.9 $SLURM_ARRAY_TASK_COUNT $SLURM_ARRAY_TASK_ID
wait
exit 0
