#!/bin/bash
#FLUX: --job-name=go
#FLUX: -c=2
#FLUX: --queue=rtx6000,t4v2
#FLUX: --priority=16

echo `date`: Job $SLURM_JOB_ID is allocated resource
echo "Starting task $SLURM_ARRAY_TASK_ID"
eval "$(conda shell.bash hook)"
conda activate rna_contrast_2
python ../contrastive_rna_representation/go_train.py \
--note "10.0_sml_frz_k2_e300" \
--rand_seed ${SLURM_ARRAY_TASK_ID} \
--resnet "less_dilated_small2" \
--global_batch_size 128 \
--dropout_prob 0.3 \
--number_of_epochs 150 \
--lr 0.0035 \
--norm_type "batchnorm_small_momentum" \
--clipnorm 0.5 \
--n_tracks 4 \
--l2_scale_weight_decay 0 \
--kernel_size 2 \
--single_transcript=true \
--high_evidence=false \
--num_classes 10 \
--train_full_model=false \
--fc_head='linear_sigmoid' \
--contrastive_checkpoint_epoch 500 \
--contrastive_run_dir /scratch/hdd001/home/phil/rna_contrast/runs/rna_contrast_5-9.1_adamw_wd1e-6_4trck-pool_avgpool-DCLdev_4-d_0.1-seed_0-bs_1536-less_dilated_small2-lr_0.01-e_500
