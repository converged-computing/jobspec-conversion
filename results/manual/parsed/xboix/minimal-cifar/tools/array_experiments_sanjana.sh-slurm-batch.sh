#!/bin/bash
#SBATCH --job-name=minimal
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:titan-x:1
#SBATCH --mem-per-cpu=16GB
#SBATCH --time=10:00:00
#SBATCH --qos=cbmm
#SBATCH --chdir=./log/
#SBATCH --array=11-16

cd /om/user/sanjanas/minimal-cifar/
/om2/user/jakubk/miniconda3/envs/torch/bin/python -c 'import torch; print(torch.rand(2,3).cuda())'
singularity exec -B /om:/om --nv /om/user/xboix/share/localtensorflow.img \
python /om/user/sanjanas/minimal-cifar/main.py ${SLURM_ARRAY_TASK_ID}
