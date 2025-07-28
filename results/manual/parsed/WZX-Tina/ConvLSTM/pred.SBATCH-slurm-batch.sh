#!/bin/bash
#FLUX: --job-name=pred
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
singularity exec --nv --overlay /scratch/tw2672/pytorch/torch2cuda8.ext3:ro  /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif  /bin/bash -c 'source /ext3/env.sh;python load_model.py'
