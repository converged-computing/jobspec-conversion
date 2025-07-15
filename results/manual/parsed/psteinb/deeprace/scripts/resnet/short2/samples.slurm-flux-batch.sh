#!/bin/bash
#FLUX: --job-name=joyous-lamp-9094
#FLUX: -t=60
#FLUX: --urgency=16

module load singularity/2.4.2
hostname
nvidia-smi
/home/steinba/development/nvidia-samples/9.0.176/1_Utilities/deviceQuery/deviceQuery
singularity exec --nv /scratch/steinba/tf1.5.simg /home/steinba/development/nvidia-samples/9.0.176/1_Utilities/deviceQuery/deviceQuery
