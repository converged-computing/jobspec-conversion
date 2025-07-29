#!/bin/bash
#SBATCH --job-name=ABCDdua
#SBATCH --account=smnelson
#SBATCH --output=output_logs/ABCCdua_%A_%a.out
#SBATCH --error=output_logs/ABCCdua_%A_%a.err
#SBATCH --mail-user=<YOUR-EMAIL>@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30gb
#SBATCH --time=00:30:00

cd run_files.dua
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
