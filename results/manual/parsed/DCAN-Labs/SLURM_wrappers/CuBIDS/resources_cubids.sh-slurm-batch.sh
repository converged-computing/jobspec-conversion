#!/bin/bash
#SBATCH --job-name=cubids-validate
#SBATCH --account=miran045
#SBATCH --output=output_logs/cubids_%A_%a.out
#SBATCH --error=output_logs/cubids_%A_%a.err
#SBATCH --mail-user=<YOUR-EMAIL>@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5gb
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=1

cd run_files.cubids
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
