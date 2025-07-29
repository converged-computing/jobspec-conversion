#!/bin/bash
#SBATCH --job-name=dilation
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:GEFORCEGTX1080TI:1
#SBATCH --mem=12GB
#SBATCH --time=20:00:00
#SBATCH --qos=cbmm
#SBATCH --chdir=./log/
#SBATCH --array=0-3

cd /om/user/xboix/src/insideness/
hostname
/om2/user/jakubk/miniconda3/envs/torch/bin/python -c 'import torch; print(torch.rand(2,3).cuda())'
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow.simg \
python /om/user/xboix/src/insideness/main.py \
--experiment_index=$((${SLURM_ARRAY_TASK_ID} + 0)) \
--host_filesystem=om \
--network=multi_lstm_init \
--run=train \
--error_correction
