#!/bin/bash
#FLUX: --job-name=yolov3-hsr-mse-1
#FLUX: -c=16
#FLUX: --queue=napoli-gpu
#FLUX: -t=9000
#FLUX: --urgency=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
date;hostname;pwd
nvidia-smi
LD_LIBRARY_PATH=lib ./darknet detector train cfg/runs/yolov3-hsr-mse-1/data cfg/runs/yolov3-hsr-mse-1/cfg datasets/voc/darknet53.conv.74
echo "Done"
