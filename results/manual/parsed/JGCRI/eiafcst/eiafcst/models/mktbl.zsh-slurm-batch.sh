#!/bin/bash
#SBATCH --job-name=eiafcst
#SBATCH --account=eiafcst
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=12:00:00
#SBATCH --partition=shared

module purge
module load cuda/9.2.148
module load python/anaconda3
nvidia-smi
tid=$SLURM_ARRAY_TASK_ID
(( end = $tid * 3 ))
files=`head -$end filelist.txt | tail -3`
echo "Running files:"
echo $files
echo $files | xargs python gather_model_stats.py > diagnostic/gdp/rslts-summary$tid.csv
