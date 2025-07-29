#!/bin/bash
#FLUX: --job-name=batch_idwe
#FLUX: --queue=bigmem
#FLUX: -t=604800
#FLUX: --urgency=16

module load gnu10/10.3.0
module load openmpi
module load netcdf-c
module load r/4.1.2-dx
cd /projects/HAQ_LAB/mrasel/R/exposure-tracer-study/R/
Rscript ./inverse_distance.R   
