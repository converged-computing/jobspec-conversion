#!/bin/bash
#SBATCH --job-name=whole
#SBATCH --account=faird
#SBATCH --output=output_logs/syncTM_%A_%a.out
#SBATCH --error=output_logs/syncTM_%A_%a.err
#SBATCH --mail-user=<YOUR-EMAIL>@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=180G
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

cd run_files.syncTM
module load matlab
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
