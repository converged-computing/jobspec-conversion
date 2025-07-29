#!/bin/bash
#SBATCH --job-name=fMRI_ABCD-HCP
#SBATCH --account=miran045
#SBATCH --output=output_logs/fMRI_%A_%a.out
#SBATCH --error=output_logs/fMRI_%A_%a.err
#SBATCH --mail-user=<YOUR-EMAIL>@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15gb
#SBATCH --time=12:00:00
#SBATCH --partition=small,amdsmall
#SBATCH --constraint=ntasks-per-node=6

cd run_files.fMRI
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
