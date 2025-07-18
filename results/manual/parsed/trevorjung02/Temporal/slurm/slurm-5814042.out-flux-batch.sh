#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=8
#FLUX: --queue=gpu-a40
#FLUX: -t=17940
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/templama/training/t5_kadapters_debug.json
--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapter.0.layer.0.SelfAttention.k.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.1.layer.1.layer_norm.weight', 'kadapter.adapter.1.layer.0.SelfAttention.v.weight', 'kadapter.adapter.1.layer.0.SelfAttention.q.weight', 'kadapter.adapter.0.layer.0.SelfAttention.q.weight', 'kadapter.adapter.0.layer.0.SelfAttention.o.weight', 'kadapter.adapter.1.layer.0.SelfAttention.o.weight', 'kadapter.adapter.0.layer.0.layer_norm.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wo.weight', 'kadapter.layer_norm.weight', 'kadapter.adapter.1.layer.0.SelfAttention.k.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.0.layer.1.layer_norm.weight', 'kadapter.adapter.0.layer.0.SelfAttention.v.weight', 'kadapter.adapter.1.layer.0.layer_norm.weight', 'kadapter.adapter.0.layer.0.SelfAttention.relative_attention_bias.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Set SLURM handle signals.
  | Name  | Type                       | Params
-----------------------------------------------------
0 | model | T5ForConditionalGeneration | 81.7 M
-----------------------------------------------------
46.3 M    Trainable params
35.3 M    Non-trainable params
81.7 M    Total params
326.730   Total estimated model params size (MB)
Restored states from the checkpoint file at outputs/T5_small_templama(debug)_lr.001_adapters/epoch=15-step=47.ckpt
split is 0
Length of dataset retrieving is.. 49
Validation sanity check: 0it [00:00, ?it/s]
                                           /mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/data_loading.py:354: UserWarning: One of given dataloaders is None and it will be skipped.
  rank_zero_warn("One of given dataloaders is None and it will be skipped.")
split is 0
Length of dataset retrieving is.. 49
Training: 0it [00:00, ?it/s]
Training:   0%|          | 0/9 [00:00<?, ?it/s]
Epoch 16:   0%|          | 0/9 [00:00<?, ?it/s]
Epoch 16:  11%|█         | 1/9 [00:01<00:15,  1.89s/it]
Epoch 16:  11%|█         | 1/9 [00:01<00:15,  1.89s/it, loss=nan]
Epoch 16:  22%|██▏       | 2/9 [00:01<00:06,  1.03it/s, loss=nan][W reducer.cpp:1158] Warning: find_unused_parameters=True was specified in DDP constructor, but did not find any unused parameters in the forward pass. This flag results in an extra traversal of the autograd graph every iteration,  which can adversely affect performance. If your model indeed never has any unused parameters in the forward pass, consider turning this flag off. Note that this warning may be a false positive if your model has flow control causing later iterations to have unused parameters. (function operator())
Epoch 16:  33%|███▎      | 3/9 [00:02<00:04,  1.48it/s, loss=nan]
Epoch 16:  33%|███▎      | 3/9 [00:02<00:04,  1.48it/s, loss=0.401]
Epoch 16:  44%|████▍     | 4/9 [00:02<00:02,  1.94it/s, loss=0.401]
Epoch 16:  56%|█████▌    | 5/9 [00:02<00:01,  2.38it/s, loss=0.401]
Epoch 16:  67%|██████▋   | 6/9 [00:02<00:01,  2.75it/s, loss=0.401]
Epoch 16:  67%|██████▋   | 6/9 [00:02<00:01,  2.75it/s, loss=0.386]
Epoch 16:  78%|███████▊  | 7/9 [00:02<00:00,  3.15it/s, loss=0.386]
Epoch 16:  89%|████████▉ | 8/9 [00:02<00:00,  3.53it/s, loss=0.386]
Epoch 16: 100%|██████████| 9/9 [00:02<00:00,  3.72it/s, loss=0.386]
Epoch 16: 100%|██████████| 9/9 [00:02<00:00,  3.72it/s, loss=0.378]
Epoch 16: 100%|██████████| 9/9 [00:19<00:00,  2.22s/it, loss=0.378]
Epoch 16:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.378]        
Epoch 17:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.378]
Epoch 17:  11%|█         | 1/9 [00:00<00:03,  2.20it/s, loss=0.378]
Epoch 17:  11%|█         | 1/9 [00:00<00:03,  2.20it/s, loss=0.378]
Epoch 17:  22%|██▏       | 2/9 [00:00<00:01,  4.05it/s, loss=0.378]
Epoch 17:  33%|███▎      | 3/9 [00:00<00:01,  5.25it/s, loss=0.378]
Epoch 17:  33%|███▎      | 3/9 [00:00<00:01,  5.24it/s, loss=0.359]
Epoch 17:  44%|████▍     | 4/9 [00:00<00:00,  6.53it/s, loss=0.359]
Epoch 17:  56%|█████▌    | 5/9 [00:00<00:00,  7.65it/s, loss=0.359]
Epoch 17:  67%|██████▋   | 6/9 [00:00<00:00,  8.19it/s, loss=0.359]
Epoch 17:  67%|██████▋   | 6/9 [00:00<00:00,  8.19it/s, loss=0.364]
Epoch 17:  78%|███████▊  | 7/9 [00:00<00:00,  9.05it/s, loss=0.364]
Epoch 17:  89%|████████▉ | 8/9 [00:00<00:00,  9.84it/s, loss=0.364]
Epoch 17: 100%|██████████| 9/9 [00:00<00:00,  9.46it/s, loss=0.364]
Epoch 17: 100%|██████████| 9/9 [00:00<00:00,  9.45it/s, loss=0.385]
Epoch 17:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.385]        
Epoch 18:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.385]
Epoch 18:  11%|█         | 1/9 [00:00<00:03,  2.18it/s, loss=0.385]
Epoch 18:  22%|██▏       | 2/9 [00:00<00:01,  4.00it/s, loss=0.385]
Epoch 18:  33%|███▎      | 3/9 [00:00<00:01,  5.19it/s, loss=0.385]
Epoch 18:  33%|███▎      | 3/9 [00:00<00:01,  5.19it/s, loss=0.378]
Epoch 18:  44%|████▍     | 4/9 [00:00<00:00,  6.46it/s, loss=0.378]
Epoch 18:  56%|█████▌    | 5/9 [00:00<00:00,  7.58it/s, loss=0.378]
Epoch 18:  67%|██████▋   | 6/9 [00:00<00:00,  8.13it/s, loss=0.378]
Epoch 18:  67%|██████▋   | 6/9 [00:00<00:00,  7.59it/s, loss=0.37] 
Epoch 18:  78%|███████▊  | 7/9 [00:00<00:00,  8.43it/s, loss=0.37]
Epoch 18:  89%|████████▉ | 8/9 [00:00<00:00,  9.19it/s, loss=0.37]
Epoch 18: 100%|██████████| 9/9 [00:01<00:00,  8.87it/s, loss=0.37]
Epoch 18: 100%|██████████| 9/9 [00:01<00:00,  8.87it/s, loss=0.362]
Epoch 18:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.362]        
Epoch 19:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.362]
Epoch 19:  11%|█         | 1/9 [00:00<00:03,  2.21it/s, loss=0.362]
Epoch 19:  22%|██▏       | 2/9 [00:00<00:01,  4.01it/s, loss=0.362]
Epoch 19:  33%|███▎      | 3/9 [00:00<00:01,  5.21it/s, loss=0.362]
Epoch 19:  33%|███▎      | 3/9 [00:00<00:01,  5.20it/s, loss=0.346]
Epoch 19:  44%|████▍     | 4/9 [00:00<00:00,  6.48it/s, loss=0.346]
Epoch 19:  56%|█████▌    | 5/9 [00:00<00:00,  7.61it/s, loss=0.346]
Epoch 19:  67%|██████▋   | 6/9 [00:00<00:00,  8.16it/s, loss=0.346]
Epoch 19:  67%|██████▋   | 6/9 [00:00<00:00,  8.15it/s, loss=0.347]
Epoch 19:  78%|███████▊  | 7/9 [00:00<00:00,  9.01it/s, loss=0.347]
Epoch 19:  89%|████████▉ | 8/9 [00:00<00:00,  9.81it/s, loss=0.347]
Epoch 19: 100%|██████████| 9/9 [00:00<00:00,  9.34it/s, loss=0.347]
Epoch 19: 100%|██████████| 9/9 [00:00<00:00,  9.34it/s, loss=0.342]
Epoch 19: 100%|██████████| 9/9 [00:16<00:00,  1.88s/it, loss=0.342]
Epoch 19:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.342]        
Epoch 20:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.342]
Epoch 20:  11%|█         | 1/9 [00:00<00:03,  2.08it/s, loss=0.342]
Epoch 20:  11%|█         | 1/9 [00:00<00:03,  2.08it/s, loss=0.342]
Epoch 20:  22%|██▏       | 2/9 [00:00<00:01,  3.80it/s, loss=0.342]
Epoch 20:  33%|███▎      | 3/9 [00:00<00:01,  4.97it/s, loss=0.342]
Epoch 20:  33%|███▎      | 3/9 [00:00<00:01,  4.96it/s, loss=0.34] 
Epoch 20:  44%|████▍     | 4/9 [00:00<00:00,  6.20it/s, loss=0.34]
Epoch 20:  56%|█████▌    | 5/9 [00:00<00:00,  7.31it/s, loss=0.34]
Epoch 20:  67%|██████▋   | 6/9 [00:00<00:00,  7.87it/s, loss=0.34]
Epoch 20:  67%|██████▋   | 6/9 [00:00<00:00,  7.86it/s, loss=0.327]
Epoch 20:  78%|███████▊  | 7/9 [00:00<00:00,  8.71it/s, loss=0.327]
Epoch 20:  89%|████████▉ | 8/9 [00:00<00:00,  9.49it/s, loss=0.327]
Epoch 20: 100%|██████████| 9/9 [00:01<00:00,  8.96it/s, loss=0.327]
Epoch 20: 100%|██████████| 9/9 [00:01<00:00,  8.96it/s, loss=0.322]
Epoch 20:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.322]        
Epoch 21:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.322]
Epoch 21:  11%|█         | 1/9 [00:00<00:03,  2.28it/s, loss=0.322]
Epoch 21:  22%|██▏       | 2/9 [00:00<00:01,  4.13it/s, loss=0.322]
Epoch 21:  33%|███▎      | 3/9 [00:00<00:01,  5.27it/s, loss=0.322]
Epoch 21:  33%|███▎      | 3/9 [00:00<00:01,  5.27it/s, loss=0.313]
Epoch 21:  44%|████▍     | 4/9 [00:00<00:00,  6.55it/s, loss=0.313]
Epoch 21:  56%|█████▌    | 5/9 [00:00<00:00,  7.68it/s, loss=0.313]
Epoch 21:  67%|██████▋   | 6/9 [00:00<00:00,  8.23it/s, loss=0.313]
Epoch 21:  67%|██████▋   | 6/9 [00:00<00:00,  8.22it/s, loss=0.303]
Epoch 21:  78%|███████▊  | 7/9 [00:00<00:00,  9.06it/s, loss=0.303]
Epoch 21:  89%|████████▉ | 8/9 [00:00<00:00,  9.84it/s, loss=0.303]
Epoch 21: 100%|██████████| 9/9 [00:00<00:00,  9.46it/s, loss=0.303]
Epoch 21: 100%|██████████| 9/9 [00:00<00:00,  9.45it/s, loss=0.302]
Epoch 21:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.302]        
Epoch 22:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.302]
Epoch 22:  11%|█         | 1/9 [00:00<00:03,  2.31it/s, loss=0.302]
Epoch 22:  22%|██▏       | 2/9 [00:00<00:01,  4.19it/s, loss=0.302]
Epoch 22:  33%|███▎      | 3/9 [00:00<00:01,  5.36it/s, loss=0.302]
Epoch 22:  33%|███▎      | 3/9 [00:00<00:01,  5.36it/s, loss=0.3]  
Epoch 22:  44%|████▍     | 4/9 [00:00<00:00,  6.66it/s, loss=0.3]
Epoch 22:  56%|█████▌    | 5/9 [00:00<00:00,  7.81it/s, loss=0.3]
Epoch 22:  67%|██████▋   | 6/9 [00:00<00:00,  8.37it/s, loss=0.3]
Epoch 22:  67%|██████▋   | 6/9 [00:00<00:00,  8.36it/s, loss=0.298]
Epoch 22:  78%|███████▊  | 7/9 [00:00<00:00,  9.21it/s, loss=0.298]
Epoch 22:  89%|████████▉ | 8/9 [00:00<00:00, 10.00it/s, loss=0.298]
Epoch 22: 100%|██████████| 9/9 [00:00<00:00,  9.63it/s, loss=0.298]
Epoch 22: 100%|██████████| 9/9 [00:00<00:00,  9.63it/s, loss=0.288]
Epoch 22:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.288]        
Epoch 23:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.288]
Epoch 23:  11%|█         | 1/9 [00:00<00:03,  2.36it/s, loss=0.288]
Epoch 23:  22%|██▏       | 2/9 [00:00<00:01,  4.28it/s, loss=0.288]
Epoch 23:  33%|███▎      | 3/9 [00:00<00:01,  5.46it/s, loss=0.288]
Epoch 23:  33%|███▎      | 3/9 [00:00<00:01,  5.45it/s, loss=0.275]
Epoch 23:  44%|████▍     | 4/9 [00:00<00:00,  6.77it/s, loss=0.275]
Epoch 23:  56%|█████▌    | 5/9 [00:00<00:00,  7.94it/s, loss=0.275]
Epoch 23:  67%|██████▋   | 6/9 [00:00<00:00,  8.49it/s, loss=0.275]
Epoch 23:  67%|██████▋   | 6/9 [00:00<00:00,  8.48it/s, loss=0.267]
Epoch 23:  78%|███████▊  | 7/9 [00:00<00:00,  9.33it/s, loss=0.267]
Epoch 23:  89%|████████▉ | 8/9 [00:00<00:00, 10.14it/s, loss=0.267]
Epoch 23: 100%|██████████| 9/9 [00:00<00:00,  9.35it/s, loss=0.267]
Epoch 23: 100%|██████████| 9/9 [00:00<00:00,  9.35it/s, loss=0.259]
Epoch 23:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.259]        
Epoch 24:   0%|          | 0/9 [00:00<?, ?it/s, loss=0.259]
Epoch 24:  11%|█         | 1/9 [00:00<00:03,  2.12it/s, loss=0.259]
Epoch 24:  22%|██▏       | 2/9 [00:00<00:01,  3.89it/s, loss=0.259]
Epoch 24:  33%|███▎      | 3/9 [00:00<00:01,  5.04it/s, loss=0.259]
Epoch 24:  33%|███▎      | 3/9 [00:00<00:01,  5.04it/s, loss=0.243]
Epoch 24:  44%|████▍     | 4/9 [00:00<00:00,  6.30it/s, loss=0.243]
Epoch 24:  56%|█████▌    | 5/9 [00:00<00:00,  7.41it/s, loss=0.243]
Epoch 24:  67%|██████▋   | 6/9 [00:00<00:00,  7.98it/s, loss=0.243]
Epoch 24:  67%|██████▋   | 6/9 [00:00<00:00,  7.98it/s, loss=0.229]
Epoch 24:  78%|███████▊  | 7/9 [00:00<00:00,  8.81it/s, loss=0.229]
Epoch 24:  89%|████████▉ | 8/9 [00:00<00:00,  9.59it/s, loss=0.229]
Epoch 24: 100%|██████████| 9/9 [00:00<00:00,  9.25it/s, loss=0.229]
Epoch 24: 100%|██████████| 9/9 [00:00<00:00,  9.24it/s, loss=0.223]
Epoch 24: 100%|██████████| 9/9 [00:01<00:00,  4.81it/s, loss=0.223]
