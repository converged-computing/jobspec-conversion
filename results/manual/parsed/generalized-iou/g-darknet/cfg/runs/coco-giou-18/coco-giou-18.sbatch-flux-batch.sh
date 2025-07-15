#!/bin/bash
#FLUX: --job-name="coco-giou-18"
#FLUX: -c=16
#FLUX: --queue=dgx --qos=normal
#FLUX: -t=864000
#FLUX: --priority=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
date;hostname;pwd
LD_LIBRARY_PATH=lib ./darknet detector train cfg/coco-giou-18.data cfg/yolov3.coco-giou-18.cfg backup/coco-giou-18/yolov3.backup -gpus  0,1,2,3
echo "Done"
