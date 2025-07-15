#!/bin/bash
#FLUX: --job-name=ornery-kerfuffle-3988
#FLUX: --urgency=16

module load spack/spack-0.18.1
spack load r@4.2.1 r-sf
spack load openjdk@11.0.15_10
Rscript \
2.spatial.fst.stability.R \
${SLURM_ARRAY_TASK_ID} \
0
if [ ${SLURM_ARRAY_TASK_ID} -le 436 ]
then
echo "shift activated!"
Rscript \
2.spatial.fst.stability.R \
${SLURM_ARRAY_TASK_ID} \
999
fi
echo "done"
date
