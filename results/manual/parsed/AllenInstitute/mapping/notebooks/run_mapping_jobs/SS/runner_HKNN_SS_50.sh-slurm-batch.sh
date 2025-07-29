#!/bin/bash
#SBATCH --job-name=HKNN_SS_50_job
#SBATCH --output=logfiles/HKNN_SS_50_job_%j.log
#SBATCH --mail-user=clare.morris@alleninstitute.org
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500gb
#SBATCH --time=10-00:00:00

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/SS_HKNN_50.R > logfiles/HKNN_SS_50_logfile
