#!/bin/bash
#FLUX: --job-name=d_eori
#FLUX: -c=5
#FLUX: --queue=ava_m.p
#FLUX: -t=604800
#FLUX: --urgency=16

pairs=("l2 cosine")
item=${pairs[$SLURM_ARRAY_TASK_ID]}
lt="${item% *}"
vs="${item#* }"
/home/ruihay1/miniconda3/envs/exp_pytorch/bin/python train.py --iteration_step 8193 \
    --device 0 --loss_type $lt --var_schedule $vs --pred_mode "noise" --beta 0.000001 \
    --aux_weight 0 --reverse_context_dim_mults 4 3 2 1 --ae_path "" --embd_type "01" --load_model --load_step
