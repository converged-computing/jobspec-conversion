#!/bin/bash
#FLUX: --job-name=psm
#FLUX: -t=259200
#FLUX: --priority=16

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
