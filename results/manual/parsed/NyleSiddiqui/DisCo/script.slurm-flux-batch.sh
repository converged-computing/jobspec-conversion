#!/bin/bash
#FLUX: --job-name=NTU-six-actions
#FLUX: --queue=gpu
#FLUX: --urgency=16

source activate /home/siddiqui/.conda/envs/diffusion
AZFUSE_USE_FUSE=0 NCCL_ASYNC_ERROR_HANDLING=0 python finetune_sdm_yaml.py --cf config/ref_attn_clip_combine_controlnet/tiktok_S256L16_xformers_tsv.py --do_train --root_dir /home/siddiqui/DisCo/ --local_train_batch_size 64  --local_eval_batch_size 64  --log_dir exp/NTU-six-actions --epochs 500 --deepspeed --eval_step 5000 --save_step 5000 --gradient_accumulate_steps 1 --learning_rate 2e-4 --fix_dist_seed --loss_target "noise" --train_yaml ../TSV_dataset/composite_offset/train_TiktokDance-poses-masks.yaml --val_yaml ../TSV_dataset/composite_offset/new10val_TiktokDance-poses-masks.yaml --unet_unfreeze_type "all" --refer_sdvae --ref_null_caption False --combine_clip_local --combine_use_mask --conds "poses" "masks" --num_workers 10 --eval_before_train False --pretrained_model "/home/siddiqui/DisCo/tiktok_ft_model.pt"
