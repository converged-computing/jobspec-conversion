#!/bin/bash
#SBATCH --job-name=QSIprep
#SBATCH --account=faird
#SBATCH --output=output_logs/QSIprep_%A_%a.out
#SBATCH --error=output_logs/QSiprep_%A_%a.err
#SBATCH --mail-user=<YOUR-EMAIL>@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20gb
#SBATCH --time=1-00:00:00
#SBATCH --partition=small,amdsmall
#SBATCH --constraint=ntasks-per-node=8

cd run_files.QSIprep
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
