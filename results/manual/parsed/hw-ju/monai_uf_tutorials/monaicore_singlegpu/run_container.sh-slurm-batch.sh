#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=a100:1
#SBATCH --mem=64gb
#SBATCH --time=01:00:00

date;hostname;pwd
module load singularity
singularity exec --nv /blue/vendor-nvidia/hju/monaicore0.9.1 python3 -c "import torch; print(torch.cuda.is_available())"
singularity exec --nv /blue/vendor-nvidia/hju/monaicore0.9.1 python3 /home/hju/tutorials/2d_segmentation/torch/unet_training_array.py
