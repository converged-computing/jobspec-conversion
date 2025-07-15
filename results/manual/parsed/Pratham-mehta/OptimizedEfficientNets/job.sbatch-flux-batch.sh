#!/bin/bash
#FLUX: --job-name=HPML_Project_efficientnet_b0_dataparallel_finetune_GPU_1_with_profiler_new_image_size_food
#FLUX: -c=10
#FLUX: -t=14400
#FLUX: --priority=16

module purge
cd /scratch/pm3483/Project1/
singularity exec --nv \
      --overlay /scratch/pm3483/pytorch-example/overlay-25GB-500K.ext3:ro \
     /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif /bin/bash -c "source /ext3/env.sh; python train.py --seed 42 --arch efficientnet_b0 --epochs 4 --dataset food --profile False"
