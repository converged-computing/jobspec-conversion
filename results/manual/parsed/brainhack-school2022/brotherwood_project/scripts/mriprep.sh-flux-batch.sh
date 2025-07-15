#!/bin/bash
#FLUX: --job-name=lovable-lemon-9647
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

export SINGULARITYENV_TEMPLATEFLOW_HOME='/templateflow'

set -e
module load singularity/3.8
WKDIR=/home/${USER}/projects/def-charesti/pbro98/brotherwood_project
DATADIR=${WKDIR}/data
FSDIR=${WKDIR}/images
TFDIR=${WKDIR}/images/templateflow
SUB=$(sed -n ${SLURM_ARRAY_TASK_ID}p ${WKDIR}/valid_subjects.txt)
export SINGULARITYENV_TEMPLATEFLOW_HOME=/templateflow
echo -e "\n"
echo "Starting fmriprep.."
echo "subject: $SUB"
echo "working directory: $WKDIR"
echo "data directory: $DATADIR"
echo -e "\n"
singularity run --cleanenv -B $DATADIR:/data -B $TMPDIR:/work -B $TMPDIR:/tmp -B $FSDIR:/fs -B $TFDIR:/templateflow \
    ${WKDIR}/images/fmriprep-21.0.2.simg \
    /data/BIDS/ \
    /data/preprocessed/ \
    participant --participant-label $SUB --skip-bids-validation --work-dir /work/ --fs-license-file /fs/fs-license/license.txt --omp-nthreads $SLURM_CPUS_PER_TASK --nthreads $SLURM_CPUS_PER_TASK --mem-mb 30000 -vv
