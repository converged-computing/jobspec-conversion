#!/bin/bash
#FLUX: --job-name=Resnet50-train-on-clip
#FLUX: -c=16
#FLUX: --queue=gpu-2080ti
#FLUX: --urgency=16

scontrol show job $SLURM_JOB_ID
singularity exec --nv --bind /scratch_local/ docker://lukasschott/ifr:v8 python3 train.py /path/to/dataset/ImageNet2012 -a resnet50 --dist-url 'tcp://127.0.0.1:1405' --dist-backend 'nccl' --multiprocessing-distributed --world-size 1 --rank 0 --workers 8  --label-type soft_labels
