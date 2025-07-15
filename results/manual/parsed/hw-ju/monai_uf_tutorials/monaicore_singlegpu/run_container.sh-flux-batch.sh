#!/bin/bash
#FLUX: --job-name=joyous-snack-3381
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

date;hostname;pwd
module load singularity
singularity exec --nv /blue/vendor-nvidia/hju/monaicore0.9.1 python3 -c "import torch; print(torch.cuda.is_available())"
singularity exec --nv /blue/vendor-nvidia/hju/monaicore0.9.1 python3 /home/hju/tutorials/2d_segmentation/torch/unet_training_array.py
