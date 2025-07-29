#!/bin/bash
#SBATCH --job-name=ALT_HKNN_v3_5_job
#SBATCH --output=logfiles/ALT_HKNN_v3_5_job_%j.log
#SBATCH --mail-user=clare.morris@alleninstitute.org
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500gb
#SBATCH --time=10-00:00:00

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/v3_HKNN_5_ALT.R > logfiles/v3_HKNN_5_ALT_logfile
