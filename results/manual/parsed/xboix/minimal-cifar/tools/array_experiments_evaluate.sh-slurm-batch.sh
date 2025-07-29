#!/bin/bash
#SBATCH --job-name=minimal
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-k80:1
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=01:00:00
#SBATCH --qos=cbmm
#SBATCH --chdir=./log/
#SBATCH --array=1

hostname
cd /om/user/sanjanas/minimal-cifar/
/om2/user/jakubk/miniconda3/envs/torch/bin/python -c 'import torch; print(torch.rand(2,3).cuda())'
singularity exec -B /om:/om --nv /cbcl/cbcl01/xboix/singularity/localtensorflow.img \
python /om/user/sanjanas/minimal-cifar/test_minimal.py ${SLURM_ARRAY_TASK_ID}
