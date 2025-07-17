#!/bin/bash
#FLUX: --job-name=seasfst
#FLUX: -c=40
#FLUX: --queue=bluemoon
#FLUX: -t=86400
#FLUX: --urgency=16

module load spack/spack-0.18.1
spack load r@4.2.1 r-sf
spack load openjdk@11.0.15_10
Rscript \
1.0.seasonal.fst.revision.R \
${SLURM_ARRAY_TASK_ID} 
echo "done"
date
