#!/bin/bash
#FLUX: --job-name="coco-baseline4"
#FLUX: -c=8
#FLUX: --queue=napoli-gpu --qos=normal
#FLUX: -t=864000
#FLUX: --priority=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
date;hostname;pwd
nvidia-smi
LD_LIBRARY_PATH=lib ./darknet detector train cfg/coco.coco-baseline4.data cfg/yolov3.coco-baseline4.cfg backup/coco-baseline4/yolov3.backup -gpus 0,1,2,3
echo "Done"
