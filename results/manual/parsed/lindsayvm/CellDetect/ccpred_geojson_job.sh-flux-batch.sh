#!/bin/bash
#FLUX: --job-name=celldetect
#FLUX: -c=16
#FLUX: --queue=a6000
#FLUX: -t=36000
#FLUX: --urgency=16

JOBS_SOURCE="/home/l.leek/src/CellDetect/"
SINGULARITYIMAGE="/home/l.leek/docker_singularity_images/u20c114s.sif"
COMMAND="python3 export_ccpred_geojson.py"
singularity exec --nv \
--no-home \
--bind "$JOBS_SOURCE" \
--bind "$SCRATCH" \
--pwd "$JOBS_SOURCE" \
$SINGULARITYIMAGE \
$COMMAND 
echo "Job finished succesfully"
