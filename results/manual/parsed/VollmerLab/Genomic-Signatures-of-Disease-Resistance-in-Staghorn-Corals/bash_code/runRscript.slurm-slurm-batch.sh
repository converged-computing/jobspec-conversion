#!/bin/bash
#SBATCH --job-name=Rscript
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=100G
#SBATCH --time=1-00:00:00
#SBATCH --partition=short

to_run=$1
echo "${to_run}"
module load singularity/3.5.3
RSTUDIO_IMAGE="/shared/container_repository/rstudio/rocker-geospatial-4.2.1.sif"
singularity run -B "/home:/home,/scratch:/scratch,/work:/work" ${RSTUDIO_IMAGE} Rscript "${to_run}" "${@:2}"
