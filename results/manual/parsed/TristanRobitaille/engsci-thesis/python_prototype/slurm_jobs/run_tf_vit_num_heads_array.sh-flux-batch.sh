#!/bin/bash
#FLUX: --job-name=buttery-itch-2790
#FLUX: -c=6
#FLUX: -t=419
#FLUX: --urgency=16

module load cuda cudnn 
module load python/3
source ~/tensorflow/bin/activate
python3 /home/tristanr/projects/def-xilinliu/tristanr/engsci-thesis/python_prototype/main_vision_transformer.py \
--batch_size=16 \
--learning_rate=1e-3 \
--patch_length=256 \
--num_epochs=125 \
--input_channel='EEG Cz-LER' \
--num_clips=115000 \
--embedding_depth=64 \
--num_layers=2 \
--num_heads=$SLURM_ARRAY_TASK_ID \
--mlp_dim=32 \
--mlp_head_num_dense=1 \
--historical_lookback_DNN_depth=32 \
--dropout_rate_percent=30 \
--class_weights 1 1 1 1.2 1 \
--input_dataset="/home/tristanr/projects/def-xilinliu/tristanr/engsci-thesis/python_prototype/data/SS3_EDF_Tensorized_both_light_deep_combine-stg_30-0s_256Hz" \
--dataset_resample_algo="ADASYN" \
--training_set_target_count 4600 4600 4600 4600 4600 \
--save_model \
--enable_dataset_resample_replacement \
--use_class_embedding \
--enable_positional_embedding \
--enable_input_rescale \
--k_fold_val_set=-1 \
--num_out_filter=3 \
--out_filter_type="pre_argmax" \
--filter_self_reset_threshold=-1 \
--k_fold_val_results_fp="/home/tristanr/projects/def-xilinliu/tristanr/engsci-thesis/python_prototype/results/k_fold_val_results/val_1" \
--num_runs=6 \
--note="Number of heads study"
