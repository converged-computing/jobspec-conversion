#!/bin/bash
#FLUX: --job-name=video2tator
#FLUX: -c=32
#FLUX: --queue=compute
#FLUX: -t=21600
#FLUX: --urgency=16

echo "Job ID: $SLURM_JOB_ID, JobName: $SLURM_JOB_NAME"
hostname; pwd; date
module load ffmpeg
module load gcc/8.5.0
source venv/bin/activate
umask 000  # newly created files have all-open permissions ok. 
echo "Environment... loaded"
set -eux  # exit on error, including unset vars
VIDEO_FILE="$1"
echo "TATOR-PY..."
TOKEN=$(cat tator_token.txt)  # hpc-user access token
HOST=https://tator.whoi.edu
PROJ_ID=1   # ISIIS
MEDIA_ID=1  # shadowgraph video
FOLDER="$(basename $VIDEO_FILE | cut -f2 -d'_')"
time python3 -m tator.transcode "$VIDEO_FILE" \
    --host $HOST \
    --token $TOKEN \
    --project $PROJ_ID \
    --type $MEDIA_ID \
    --section "$FOLDER" \
    --work_dir "tator_transcode_workspace" \
    --cleanup
echo 
TZ=UTC0 printf '%(%H:%M:%S)T\n' $SECONDS
