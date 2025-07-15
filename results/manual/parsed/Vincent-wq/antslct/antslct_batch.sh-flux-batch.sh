#!/bin/bash
#FLUX: --job-name=conspicuous-parrot-2959
#FLUX: -t=604800
#FLUX: --urgency=16

module purge
module load singularity
DATADIR=/home/${USER}/project/${USER}/data
OUTDIR=${DATADIR}/derivatives/antslct
SCRATCHDIR=/scratch/${USER}/antslct
SUBJ=sub-${SLURM_ARRAY_TASK_ID}
mkdir -p ${SCRATCHDIR}/data ${SCRATCHDIR}/output
rsync -rlu ${DATADIR}/${SUBJ} ${SCRATCHDIR}/data
singularity run -B ${SCRATCHDIR}/data:/data                                   \
                -B ${SCRATCHDIR}/output:/output                               \
                ${DATADIR}/code/antslct.simg                                  \
                -s ${SUBJ} -o /output -c 1 -t 1 -m
rsync -rlu ${SCRATCHDIR}/output/${SUBJ} ${OUTDIR}
rsync -rlu ${SCRATCHDIR}/output/reports/${SUBJ}.html ${OUTDIR}/reports
rm -fr ${SCRATCHDIR}/data/${SUBJ} ${SCRATCHDIR}/output/${SUBJ}
rm -rf ${SCRATCHDIR}/output/reports/${SUBJ}.html
