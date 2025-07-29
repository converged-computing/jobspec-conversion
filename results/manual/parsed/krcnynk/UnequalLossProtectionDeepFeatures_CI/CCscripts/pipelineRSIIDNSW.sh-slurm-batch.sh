#!/bin/bash
#SBATCH --account=def-ibajic
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-11

module restore uneq
cd ..
mkdir -p ./Korcan/Plots/resnet/FEC\ \(IID\)\ NS\ Weighted/
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 20 30 70
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))+30)) 20 30 70
