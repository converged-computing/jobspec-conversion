#!/bin/bash
#SBATCH --job-name=DEAPderiv
#SBATCH --account=miran045
#SBATCH --output=output_logs/DEAPderiv_%A_%a.out
#SBATCH --error=output_logs/DEAPderiv_%A_%a.err
#SBATCH --mail-user=<YOUR-EMAIL>@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10gb
#SBATCH --time=00:30:00

cd run_files.DEAPderiv
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
