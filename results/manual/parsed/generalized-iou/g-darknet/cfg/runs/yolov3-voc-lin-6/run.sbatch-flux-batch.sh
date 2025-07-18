#!/bin/bash
#FLUX: --job-name=yolov3-voc-lin-6
#FLUX: -c=16
#FLUX: --queue=dgx
#FLUX: -t=604800
#FLUX: --urgency=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
date;hostname;pwd
nvidia-smi
LD_LIBRARY_PATH=lib ./darknet detector train cfg/runs/yolov3-voc-lin-6/data cfg/runs/yolov3-voc-lin-6/cfg backup/yolov3-voc-lin-6/cfg.backup -gpus 0,1
echo "Done"
