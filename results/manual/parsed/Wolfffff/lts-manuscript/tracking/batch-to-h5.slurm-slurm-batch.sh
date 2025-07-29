#!/bin/bash
#FLUX: --job-name=bat_inf
#FLUX: -t=3600
#FLUX: --urgency=16

module load conda
conda init bash
conda activate sleap_dev
TARGET_DIR="/Genomics/ayroleslab2/scott/long-timescale-behavior/data/organized_tracks/20220217-lts-cam1"
LIST="1through190-tracked.txt"
LINE_NUMBER=${SLURM_ARRAY_TASK_ID}
FILE=$(sed "${LINE_NUMBER}q;d" ${LIST})
OUTPUT_NAME=${FILE%.slp}
sleap-convert ${FILE} --format analysis
