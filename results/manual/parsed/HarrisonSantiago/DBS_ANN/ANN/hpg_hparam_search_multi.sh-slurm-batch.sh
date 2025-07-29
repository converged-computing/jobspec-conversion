#!/bin/bash
#SBATCH --job-name=ANNRP_hparam_search
#SBATCH --output=logs/hparam_search.%A_%a.log
#SBATCH --mail-user=jgolabek1@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=7000mb
#SBATCH --time=20:00:00
#SBATCH --array=1-500%40

pwd; hostname; date
module load tensorflow/2.4.1
module list
python --version
param_csv=$1
array_id=$SLURM_ARRAY_TASK_ID
offset=$2
index=$((SLURM_ARRAY_TASK_ID + offset))
python hparam_search_multi.py $param_csv $index
