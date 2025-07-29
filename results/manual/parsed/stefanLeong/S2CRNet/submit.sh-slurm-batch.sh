#!/bin/bash
#SBATCH --job-name=torch
#SBATCH --output=torch.%j.out
#SBATCH --error=torch.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=3-00:00:00
#SBATCH --constraint=GTX1080
#SBATCH --nodelist=compute-9-10

source /etc/profile
source /etc/profile.d/modules.sh
module add singularity/2.6.1
module add cuda/10.0.130
ulimit -s unlimited
singularity exec --nv --bind /data:/data /share/apps/singularity/simg/pytorch/miniconda3-pytorch bash -c "bash ./train.sh"
