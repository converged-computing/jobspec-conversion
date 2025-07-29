#!/bin/bash
#SBATCH --job-name=ENTER_DESIRED_NAME_job
#SBATCH --output=ENTER_DESIRED_NAME_%j.log
#SBATCH --mail-user=clare.morris@alleninstitute.org
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500gb
#SBATCH --time=10-00:00:00

singularity exec docker://alleninst/mapping_on_hpc Rscript ENTER_R_SCRIPT_NAME.R > ENTER_DESIRED_NAME_logfile
