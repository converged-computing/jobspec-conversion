#!/bin/bash
#SBATCH --job-name=bmix_mtanveer
#SBATCH --output=/scratch/mtanveer/output/bmix_output%j
#SBATCH --error=/scratch/mtanveer/output/bmix_error%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=01:00:00
#SBATCH --array=0-75

module load anaconda
python -c "import bluemix;bluemix.process_bluehive()"
