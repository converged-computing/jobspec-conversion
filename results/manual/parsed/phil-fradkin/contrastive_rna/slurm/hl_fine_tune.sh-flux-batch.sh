#!/bin/bash
#FLUX: --job-name=hl_fine_tune
#FLUX: -c=2
#FLUX: --queue=t4v2,rtx6000,a40
#FLUX: --urgency=16

echo `date`: Job $SLURM_JOB_ID is allocated resource
echo "Starting task $SLURM_ARRAY_TASK_ID"
eval "$(conda shell.bash hook)"
conda activate rna_contrast_2
cd /h/phil/Documents/01_projects/rna_half_life_branch/contrastive_rna_representation/contrastive_rna_representation
python rna_half_life_trainer.py \
--rand_seed ${SLURM_ARRAY_TASK_ID} \
--fraction_of_train 1.0 \
--hl_dataset_parent_dir /scratch/hdd001/home/phil/rna_contrast/datasets/deeplearning/train_wosc/f${SLURM_ARRAY_TASK_ID}_c${SLURM_ARRAY_TASK_ID} \
--resnet less_dilated_small2 \
--global_hl_batch_size 128 \
--dropout_prob 0.3 \
--number_epochs 100 \
--lr 0.01 \
--weight_decay 0 \
--norm_type batchnorm_small_momentum \
--clipnorm 0.5 \
--n_tracks 6 \
--l2_scale_weight_decay 0 \
--lr_decay=false \
--train_full_model=true \
--lr_schedule='exponential' \
--exponential_decay_rate 0.85 \
--kernel_size 2 \
--note 14_wd3-5_9.4_fc \
--fc_head 'fc' \
--save_model=false \
--pooling_layer='avgpool' \
--mixed_precision=true \
--optimizer adam \
--contrastive_checkpoint_epoch 600 \
--contrastive_run_dir /scratch/hdd001/home/phil/rna_contrast/runs/rna_contrast_5-9.4_graft_wd3e-5-pool_avgpool-DCLdev_4-d_0.1-seed_0-bs_1536-less_dilated_small2-lr_0.01-e_600
