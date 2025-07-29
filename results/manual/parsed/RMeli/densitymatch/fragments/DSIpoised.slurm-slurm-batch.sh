#!/bin/bash
#FLUX: --job-name=DSIpoised
#FLUX: --queue=short
#FLUX: -t=300
#FLUX: --urgency=16

DM="/data/biggin/lina3015/densitymatch/"
DEV="${DM}/development"
echo ${SLURM_ARRAY_JOB_ID} ${SLURM_ARRAY_TASK_ID}
frag="DSIpoised/fragment_${SLURM_ARRAY_TASK_ID}.sdf"
outname=$(echo ${frag} | sed "s/.sdf/.pcd/g")
time singularity run --nv -B ${DM}:${DM} --app python ${DEV}/ligan.sif \
    ${DM}/molgrid_to_pcd.py ${frag} --ligmap ${DM}/files/ligmap -o ${outname}
