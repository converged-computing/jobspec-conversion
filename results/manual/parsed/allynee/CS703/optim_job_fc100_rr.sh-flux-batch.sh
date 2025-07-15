#!/bin/bash
#FLUX: --job-name=metalearning_FC100_MetaOptNet_RR
#FLUX: -c=4
#FLUX: --queue=project
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load Anaconda3/2022.05
eval "$(conda shell.bash hook)"
conda activate metalearning
srun whichgpu
srun python test.py --load ./experiments/FC100_MetaOptNet_RR/best_model.pth --episode 1000 \
--way 5 --shot 1 --query 15 --head Ridge --network ResNet --dataset FC100
