#!/bin/bash
#FLUX: --job-name=mriqc
#FLUX: -c=16
#FLUX: --queue=generic
#FLUX: -t=10800
#FLUX: --urgency=16

export SINGULARITYENV_FS_LICENSE='$FREESURFER_HOME/license.txt'
export PARTICIPANT_LABEL='$(printf "%02d" $SLURM_ARRAY_TASK_ID)'

export SINGULARITYENV_FS_LICENSE=$FREESURFER_HOME/license.txt
export PARTICIPANT_LABEL=$(printf "%02d" $SLURM_ARRAY_TASK_ID)
singularity run --cleanenv /data/gdehol/containers/mriqc-0.16.1.simg /scratch/gdehol/ds-tmsrisk scratch/gdehol/ds-tmsrisk/derivatives/mriqc participant --participant-label $PARTICIPANT_LABEL  --verbose-reports -w /scratch/gdehol/work
