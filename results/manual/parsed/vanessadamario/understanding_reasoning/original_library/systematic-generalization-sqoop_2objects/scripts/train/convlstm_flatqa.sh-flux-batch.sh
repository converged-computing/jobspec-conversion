#!/bin/bash
#FLUX: --job-name=ConvLSTM_1lhs
#FLUX: --queue=normal
#FLUX: -t=48000
#FLUX: --urgency=16

python add clustername/singularity/3.4.1
singularity exec -B /om:/om --nv path_singularity_tensorflow2.simg \
  python path_to_folder/path_to_folder/compositionality/scripts/train_model.py \
  --data_dir path_to_folder/path_to_folder/compositionality/sqoop-variety_1-repeats_30000 \
  --feature_dim 3,64,64 \
  --num_val_samples 1000 \
  --checkpoint_every 1000 \
  --record_loss_every 10 \
  \
  --model_type ConvLSTM \
  --num_iterations 200000 \
  \
  --optimizer Adam \
  --batch_size 128 \
  --learning_rate 1e-4 \
  \
  --rnn_num_layers 1 \
  --rnn_wordvec_dim 64 \
  --rnn_hidden_dim 128 \
  \
  --module_stem_num_layers 6 \
  --module_stem_subsample_layers 1,3 \
  --module_stem_batchnorm 1 \
  --stem_dim 64 \
  \
  --module_dim 64 \
  \
  --classifier_fc_dims 1024 \
  --classifier_downsample none \
  $@
  #--module_stem_num_layers 8 \
  #--module_stem_subsample_layers 1,3,5 \
