#!/bin/bash
#FLUX: --job-name=OE_AAE
#FLUX: -t=172800
#FLUX: --urgency=16

export SLURM_ID='$SLURM_ARRAY_TASK_ID'
export HOST_NAME='$SLURM_SUBMIT_HOST'

export  SLURM_ID=$SLURM_ARRAY_TASK_ID
export HOST_NAME=$SLURM_SUBMIT_HOST
if [[ $HOST_NAME == *atlas* ]]
then
    # TRAINING ON LPS
    if   [[ -d "/nvme1" ]]
    then
	PATHS=/lcg,/opt,/nvme1
    else
	PATHS=/lcg,/opt
    fi
    SIF=/opt/tmp/godin/sing_images/tf-2.1.0-gpu-py3_sing-2.6.sif
    singularity shell --nv --bind $PATHS $SIF train.sh $SLURM_ID $HOST_NAME
else
    # TRAINING ON BELUGA
    module load singularity/3.7
    PATHS=/project/def-arguinj
    SIF=/project/def-arguinj/shared/sing_images/tf-2.1.0-gpu-py3_sing-2.6.sif
    singularity shell --nv --bind $PATHS $SIF < train.sh $SLURM_ID $HOST_NAME
fi
mkdir -p outputs/log_files
mv *.out outputs/log_files 2>/dev/null
