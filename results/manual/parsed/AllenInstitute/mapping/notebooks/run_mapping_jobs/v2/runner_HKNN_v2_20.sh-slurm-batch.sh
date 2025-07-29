#!/bin/bash
#SBATCH --job-name=HKNN_v2_20_job
#SBATCH --output=logfiles/HKNN_v2_20_job_%j.log
#SBATCH --mail-user=clare.morris@alleninstitute.org
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500gb
#SBATCH --time=10-00:00:00

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/v2_HKNN_20.R > logfiles/HKNN_v2_20_logfile
