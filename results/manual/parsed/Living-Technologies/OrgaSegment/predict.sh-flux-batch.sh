#!/bin/bash
#FLUX: --job-name=nerdy-nunchucks-6775
#FLUX: --queue=gpu
#FLUX: -t=345600
#FLUX: --urgency=16

PREDICT=false
TRACK=false
while getopts :c:f:pt flag
do
    case "${flag}" in
        p) PREDICT=true;;
        t) TRACK=true;;
        c) CONFIG=${OPTARG};;
        f) FOLDER=${OPTARG};;
    esac
done
echo "PREDICT: $PREDICT";
echo "TRACK: $TRACK";
echo "CONFIG: $CONFIG";
echo "FOLDER: $FOLDER";
ENV=OrgaSegment
source ~/.bashrc
cd $SLURM_SUBMIT_DIR
echo $ENV
conda activate $ENV
conda info --envs
nvidia-smi
if [ "$PREDICT" = true ] ; then
    python predict_mrcnn.py $SLURM_JOB_ID $CONFIG $FOLDER
fi
if [ "$TRACK" = true ] ; then
    python track.py $SLURM_JOB_ID $CONFIG $FOLDER
fi
conda deactivate
