#!/bin/bash
#SBATCH --job-name=array-job
#SBATCH --account=pi-cdonnat
#SBATCH --output=logs/array_%A_%a.out
#SBATCH --error=logs/array_%A_%a.err
#SBATCH --mail-user=ilgee@uchicago.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=1-11:00:00
#SBATCH --partition=caslake

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module load python
module load pytorch 
cd $SCRATCH/$USER/SelfGCon
echo $1
echo $2
python3 Ours/hyperparameter.py --result_file $SLURM_ARRAY_TASK_ID
~
~
