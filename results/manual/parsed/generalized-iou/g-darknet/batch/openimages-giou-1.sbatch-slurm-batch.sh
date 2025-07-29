#!/bin/bash
#FLUX: --job-name=coco-giou-13
#FLUX: -c=8
#FLUX: --queue=napoli-gpu
#FLUX: -t=864000
#FLUX: --urgency=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
date;hostname;pwd
LD_LIBRARY_PATH=lib ./darknet detector train cfg/openimages-giou-1.data cfg/openimages-giou-1.cfg datasets/voc/darknet53.conv.74
nvidia-smi
echo "Done"
