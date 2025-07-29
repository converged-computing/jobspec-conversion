#!/bin/bash
#SBATCH --job-name=array-job
#SBATCH --account=pi-cdonnat
#SBATCH --output=logs/array_%A_%a.out
#SBATCH --error=logs/array_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=1-11:00:00
#SBATCH --array=1-100

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module load python
module load pytorch
cd $SCRATCH/$USER/CCA
echo $1
echo $2
python3 experiments/experiment.py --model $1 --epochs 2000 --patience 3 --dataset $2 --lr $3 --normalize $4 --result_file $SLURM_ARRAY_TASK_ID
~
~
