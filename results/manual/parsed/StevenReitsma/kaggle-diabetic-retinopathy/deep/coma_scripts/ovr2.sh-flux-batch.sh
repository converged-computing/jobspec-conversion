#!/bin/bash
#FLUX: --job-name=OVR_2
#FLUX: -c=4
#FLUX: --queue=long
#FLUX: -t=259200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/sreitsma/cudnn-6.5-linux-x64-v2:/usr/local/cuda-6.5/lib64:$LD_LIBRARY_PATH'
export PATH='/usr/local/cuda-6.5/bin:$PATH'
export LIBRARY_PATH='/home/sreitsma/cudnn-6.5-linux-x64-v2:/usr/local/cuda-6.5/lib64:$LIBRARY_PATH'
export CPATH='/home/sreitsma/cudnn-6.5-linux-x64-v2:/usr/local/cuda-6.5/lib64:$CPATH'

REMOTE_DIR=/vol/astro0/external_users/sreitsma
SCRATCH_DIR=/scratch/sreitsma/kaggle-diabetic-retinopathy
SCRIPT_DIR=/home/sreitsma/coma/kaggle-diabetic-retinopathy
mkdir -p $SCRATCH_DIR
mkdir -p $SCRATCH_DIR/models
export LD_LIBRARY_PATH=/home/sreitsma/cudnn-6.5-linux-x64-v2:/usr/local/cuda-6.5/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda-6.5/bin:$PATH
export LIBRARY_PATH=/home/sreitsma/cudnn-6.5-linux-x64-v2:/usr/local/cuda-6.5/lib64:$LIBRARY_PATH
export CPATH=/home/sreitsma/cudnn-6.5-linux-x64-v2:/usr/local/cuda-6.5/lib64:$CPATH
curl --silent -X POST --data-urlencode "payload={\"channel\": \"#coma-status\", \"username\": \"coma-bot\", \"text\": \"Job '$SLURM_JOB_NAME' started on coma (job id: $SLURM_JOB_ID).\", \"icon_emoji\": \":rocket:\"}" https://hooks.slack.com/services/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
echo "Copying files from /vol/astro0 to /scratch"
rsync -a --exclude="processed_512" --exclude="models" $REMOTE_DIR/* $SCRATCH_DIR/
echo "Running script"
stdbuf -oL -eL python $SCRIPT_DIR/deep/train.py $SLURM_JOB_NAME
echo "Copying model from /scratch to /vol/astro0"
cp -R $SCRATCH_DIR/models $REMOTE_DIR/
echo "Removing /scratch folders"
rm -r $SCRATCH_DIR/*
curl --silent -X POST --data-urlencode "payload={\"channel\": \"#coma-status\", \"username\": \"coma-bot\", \"text\": \"Job '$SLURM_JOB_NAME' finished on coma (job id: $SLURM_JOB_ID).\", \"icon_emoji\": \":rocket:\"}" https://hooks.slack.com/services/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
