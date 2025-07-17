#!/bin/bash
#FLUX: --job-name=coco-spp-baseline1
#FLUX: -c=16
#FLUX: --queue=napoli-gpu
#FLUX: -t=864000
#FLUX: --urgency=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
date;hostname;pwd
nvidia-smi
LD_LIBRARY_PATH=lib ./darknet detector train cfg/runs/coco-spp-baseline1/coco-spp-baseline1.data cfg/runs/coco-spp-baseline1/coco-spp-baseline1.cfg backup/coco-spp-baseline1/coco-spp-baseline1.backup -gpus 0,1,2,3
echo "Done"
