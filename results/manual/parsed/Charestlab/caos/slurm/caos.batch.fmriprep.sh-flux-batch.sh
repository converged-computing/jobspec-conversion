#!/bin/bash
#FLUX: --job-name=cowy-leg-7077
#FLUX: -n=4
#FLUX: -t=57600
#FLUX: --priority=16

export TMPDIR='${BB_WORKDIR}'

set -e
echo "${SLURM_JOB_ID}: Job ${SLURM_ARRAY_TASK_ID} of ${SLURM_ARRAY_TASK_MAX}"
JOBTAG="${USER}_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
BB_WORKDIR=$(mktemp -d /scratch/${JOBTAG}.XXXXXX)
export TMPDIR=${BB_WORKDIR}
module purge
module load bluebear
module load bear-apps/2018a
module load Singularity/2.5.1-GCC-6.4.0-2.28
df -h /scratch
sleep $[ ( $RANDOM / 100 )  + 1 ]s
./caos.fmriprep.sh ${SLURM_ARRAY_TASK_ID}
ls ${BB_WORKDIR}
test -d ${BB_WORKDIR} && /bin/rm -rf ${BB_WORKDIR}
