#!/bin/bash
#FLUX: --job-name=cowy-cattywampus-8415
#FLUX: -t=60
#FLUX: --priority=16

module load singularity/2.4.2
hostname
nvidia-smi
/home/steinba/development/nvidia-samples/9.0.176/1_Utilities/deviceQuery/deviceQuery
singularity exec --nv /scratch/steinba/tf1.5.simg /home/steinba/development/nvidia-samples/9.0.176/1_Utilities/deviceQuery/deviceQuery
