#!/bin/bash
#SBATCH --job-name=dfc645zip
#SBATCH --output=dfc645zip_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=4069
#SBATCH --time=05:00:00
#SBATCH --partition=amd-hdr100

set -e
cd /home/ashovon/newaumri/matfiles/
zip -r dfc_645_normal_original.zip dfc_645_normal_original/
