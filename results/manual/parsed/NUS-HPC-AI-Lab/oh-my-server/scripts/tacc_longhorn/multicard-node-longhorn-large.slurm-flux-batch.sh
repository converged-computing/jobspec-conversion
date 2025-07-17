#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: -N=2
#FLUX: -n=8
#FLUX: --queue=v100
#FLUX: -t=1800
#FLUX: --urgency=16

pwd
date
cd /scratch/07801/nusbin20/tacc-our
module load conda
conda activate py36pt
scontrol show hostnames $SLURM_NODELIST > /tmp/hostfile
cat /tmp/hostfile
mpiexec -hostfile /tmp/hostfile -N 1 ./cp_imagenet_to_temp_bin.sh
ibrun -np 8 \
python examples/pytorch_imagenet_resnet.py \
--epochs 90 \
--model resnet50
