#!/bin/bash
#SBATCH --job-name=eval
#SBATCH --output=results/aflow/kfold_Ef/%A-%a.out
#SBATCH --mail-user=<bechtelt@physik.hu-berlin.de>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=23:59:59
#SBATCH --partition=short
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-10%10

module load cuda
python3 scripts/plotting/error_analysis.py \
--file=results/aflow/kfold_Ef/id${SLURM_ARRAY_TASK_ID} \
