#!/bin/bash
#FLUX: --job-name=HPML_Project_efficientnet_b1_dataparallel
#FLUX: -c=16
#FLUX: -t=64800
#FLUX: --urgency=16

module purge
cd /scratch/sd5023/HPML/Course_Project/
singularity exec --nv \
      --overlay /scratch/sd5023/video_vpr/overlay-15GB-500K.ext3:ro \
     /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif /bin/bash -c "source /ext3/env.sh; python train.py --seed 42 --arch efficientnet_b1"
