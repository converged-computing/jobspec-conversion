#!/bin/bash
#FLUX: --job-name=train_lora
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load python/intel/3.8.6
singularity exec --nv --bind /scratch/yg2709 --overlay /scratch/yg2709/ml_project_env/overlay-25GB-500K.ext3:ro /scratch/yg2709/ml_project_env/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif/ /bin/bash -c "
source /ext3/env.sh
pwd
cd /scratch/yg2709/CSCI-SHU-360-Machine-Learning-Final-Project
accelerate launch train_lora_scribble.py
exit
"
