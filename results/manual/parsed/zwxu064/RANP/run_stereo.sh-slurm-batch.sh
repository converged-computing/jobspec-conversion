#!/bin/bash
#SBATCH --job-name=psm
#SBATCH --output=./logs/train_psm.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=17GB
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=4

python train_stereo.py \
--dataset='SceneFlow' \
--maxdisp 192 \
--datapath ./datasets/SceneFlow/ \
--epochs 15 \
--savemodel ./trained/ \
--neuron_sparsity=0.462 \
--resource_list_type "grad_flops" \
--resource_list_lambda=100 \
--batch=12 \
--PSM_mode="max" \
--acc_mode="sum" \
--enable_raw_grad \
