#!/bin/bash
#FLUX: --job-name=cont_9.1
#FLUX: -c=7
#FLUX: --queue=a40
#FLUX: --urgency=16

echo `date`: Job $SLURM_JOB_ID is allocated resource
echo "Starting task $SLURM_ARRAY_TASK_ID"
eval "$(conda shell.bash hook)"
conda activate rna_contrast_2
python ../contrastive_rna_representation/contrastive_model.py \
--rand_seed ${SLURM_ARRAY_TASK_ID} \
--resnet "less_dilated_medium" \
--global_batch_size 768 \
--note "9.1_adamw_wd1e-6" \
--mixed_precision=true \
--lr 0.005 \
--number_epochs 500 \
--proportion_to_mask 0.15 \
--mask_single_transcript=false \
--norm_type syncbatchnorm_small_momentum \
--n_tracks 6 \
--temperature .1 \
--l2_scale_weight_decay 0 \
--kernel_size 2 \
--weight_decay 1e-6 \
--projection_head_size 512 \
--projection_body 2048 \
--contrastive_loss_name DCL \
--pooling_layer avgpool \
--dropout_prob 0.1 \
--optimizer='adamw' \
--clipnorm 1.0 \
--always_different_transcripts=true \
--train_weighted="by_transcript_0.4" \
--dataset_path "$HOME/Documents/01_projects/rna_half_life_branch/contrastive_rna_representation/data_new/10_genome_homologene"
