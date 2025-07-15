#!/bin/bash
#FLUX: --job-name=sort
#FLUX: --queue=amd-hdr100
#FLUX: -t=540000
#FLUX: --priority=16

module load BCFtools/1.12-GCC-10.2.0
n=$SLURM_ARRAY_TASK_ID # number of jobs in the array
FILES=(/data/project/worthey_lab/projects/experimental_pipelines/tarun/DITTO/data/processed/sorted/*)
gene=${FILES[$SLURM_ARRAY_TASK_ID]}
echo "${gene##*/}"
sort -t$'\t' -k1,1 -k2,2n -T $USER_SCRATCH /data/project/worthey_lab/projects/experimental_pipelines/tarun/DITTO/data/processed/all_snv/${gene##*/} >/data/project/worthey_lab/projects/experimental_pipelines/tarun/DITTO/data/processed/sorted/${gene##*/}
bgzip ${gene##*/}
