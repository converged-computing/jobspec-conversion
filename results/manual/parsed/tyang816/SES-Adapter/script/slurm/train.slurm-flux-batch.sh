#!/bin/bash
#FLUX: --job-name=phat-squidward-4419
#FLUX: -c=16
#FLUX: -t=15552000
#FLUX: --urgency=16

export NCCL_IB_DISABLE='0'
export NCCL_DEBUG='INFO'
export OMP_PROC_BIND='false'

source ~/.bashrc
conda activate protssn
cd /public/home/tanyang/workspace/SES-Adapter
export NCCL_IB_DISABLE=0
export NCCL_DEBUG=INFO
export OMP_PROC_BIND=false
python train.py \
    --plm_model ckpt/$plm_model \
    --num_attention_heads 8 \
    --pooling_method $pooling_method \
    --pooling_dropout 0.1 \
    --dataset_config dataset/$dataset/"$dataset"_"$pdb_type".json \
    --lr 5e-4 \
    --num_workers 4 \
    --gradient_accumulation_steps 1 \
    --max_train_epochs 50 \
    --max_batch_token 120000 \
    --patience 5 \
    --use_foldseek \
    --use_ss8 \
    --ckpt_root result \
    --ckpt_dir $plm_model/$dataset \
    --model_name "$pdb_type"_"$pooling_method"_5e-4.pt \
    --wandb \
    --wandb_entity ty_ang \
    --wandb_project adapter \
    --wandb_run_name "$plm_model"_"$pdb_type"_"$pooling_method"_5e-4
