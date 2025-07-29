#!/bin/bash
#FLUX: --job-name=joyous-punk-1294
#FLUX: -n=2
#FLUX: --queue=long
#FLUX: --urgency=16

module load apptainer
module load nextflow/23.10.1
nextflow run . -c configs/ceres/ceres.cfg -resume
