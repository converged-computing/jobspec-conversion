#!/bin/bash
#SBATCH --job-name=robustness
#SBATCH --account=vuw03073
#SBATCH --output=slurmOut/robustness.%j.txt
#SBATCH --mail-user=calquigs@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=150MB
#SBATCH --time=00:15:00
#SBATCH --array=0-143

export SLURM_EXPORT_ENV='ALL'

export SLURM_EXPORT_ENV=ALL
module purge
files=(reinga_var/*)
file=${files[$SLURM_ARRAY_TASK_ID]}
module load Miniconda3
source activate opendrift_simon
python /nesi/project/vuw03073/opendriftxmoana/postprocessing/nparticle_robustness.py ${file}
