#!/bin/bash
#SBATCH --job-name=features3
#SBATCH --output=log.pipeline.features3
#SBATCH --mail-user=$USER@case.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30G
#SBATCH --time=10:00:00

module swap intel gcc
module load python/3.7.0
module load matlab
cd /mnt/rstor/CSE_BME_AXM788/home/axa1399/til_biomarker_ovarian_cancer/code/
time matlab -nodisplay -r main_3
