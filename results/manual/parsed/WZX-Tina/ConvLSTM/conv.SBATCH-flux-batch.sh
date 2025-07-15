#!/bin/bash
#FLUX: --job-name=conv
#FLUX: -t=3600
#FLUX: --priority=16

module purge
singularity exec --nv --overlay /scratch/tw2672/pytorch/torch2cuda8.ext3:ro  /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif  /bin/bash -c 'source /ext3/env.sh;python np_to_png.py'
