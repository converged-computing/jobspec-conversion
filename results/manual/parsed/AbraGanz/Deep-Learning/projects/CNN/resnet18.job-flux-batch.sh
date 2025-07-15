#!/bin/bash
#FLUX: --job-name=ExampleJob
#FLUX: -c=3
#FLUX: --queue=gpu_shared_course
#FLUX: -t=14400
#FLUX: --priority=16

SBATCH --output=resnet_18.out
module purge
module load 2021
module load Anaconda3/2021.05
cd $HOME/...
source activate dl2021
srun python -u main_cnn.py --model_name resnet18
