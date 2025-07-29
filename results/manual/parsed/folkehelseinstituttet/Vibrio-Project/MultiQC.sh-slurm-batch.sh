#!/bin/bash
#SBATCH --job-name=AsmQC
#SBATCH --account=nn9305k
#SBATCH --mail-user=ajkarloss@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --array=1-6

source /cluster/bin/jobsetup
module load Miniconda3/4.4.10
source activate MultiQC
time python MultiQC.py
source deactivate MultiQC
