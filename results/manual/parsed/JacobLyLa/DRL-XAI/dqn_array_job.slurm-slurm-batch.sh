#!/bin/bash
#SBATCH --job-name=dqn_array_job_8cores
#SBATCH --account=ie-idi
#SBATCH --output=out/dqn_job_%A_%a.txt
#SBATCH --mail-user=jacob.LLarsen@hotmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4G
#SBATCH --time=01:00:00
#SBATCH --partition=CPUQ
#SBATCH --array=1-10

module purge
module load PyTorch/2.0.1-foss-2022a
module list
python -m src.DRL.train_qrunner
