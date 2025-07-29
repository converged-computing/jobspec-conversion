#!/bin/bash
#SBATCH --job-name=trainingCycleGAN
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=48GB
#SBATCH --time=9-14:00:00

module load nvidia/cudasdk/10.1
module load singularity/3.2.1
singularity exec -s /bin/bash --nv maio9.img bash -c 'python ./CycleNLPGAN/train.py --name translation --dataroot data --batch_size 8 --task translation'
