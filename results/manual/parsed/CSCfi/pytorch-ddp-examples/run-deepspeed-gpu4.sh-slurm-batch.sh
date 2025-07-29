#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=0
#SBATCH --time=00:15:00

module purge
module load pytorch
srun singularity_wrapper exec deepspeed mnist_deepspeed.py --epochs=100 \
     --deepspeed --deepspeed_config ds_config.json
