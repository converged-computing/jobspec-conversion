#!/bin/bash
#SBATCH --job-name=alteredHKNN_lists_job
#SBATCH --output=logfiles/altered_HKNNlists_job_%j.log
#SBATCH --mail-user=clare.morris@alleninstitute.org
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=50
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=500gb
#SBATCH --time=15-00:00:00

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/example_run_mapping_hknn.R > logfiles/alteredHKNN_lists_logfile
