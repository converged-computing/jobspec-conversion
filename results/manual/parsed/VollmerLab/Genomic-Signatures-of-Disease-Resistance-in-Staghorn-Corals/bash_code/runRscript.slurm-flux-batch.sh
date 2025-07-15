#!/bin/bash
#FLUX: --job-name=Rscript
#FLUX: -c=24
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --priority=16

to_run=$1
echo "${to_run}"
module load singularity/3.5.3
RSTUDIO_IMAGE="/shared/container_repository/rstudio/rocker-geospatial-4.2.1.sif"
singularity run -B "/home:/home,/scratch:/scratch,/work:/work" ${RSTUDIO_IMAGE} Rscript "${to_run}" "${@:2}"
