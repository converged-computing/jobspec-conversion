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
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapter.1.layer.0.SelfAttention.o.weight', 'kadapter.adapter.0.layer.0.SelfAttention.o.weight', 'kadapter.adapter.0.layer.0.layer_norm.weight', 'kadapter.adapter.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapter.1.layer.1.layer_norm.weight', 'kadapter.adapter.1.layer.0.SelfAttention.v.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.1.layer.0.layer_norm.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapter.0.layer.0.SelfAttention.k.weight', 'kadapter.adapter.0.layer.1.layer_norm.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi_0.weight', 'kadapter.layer_norm.weight', 'kadapter.adapter.1.layer.0.SelfAttention.q.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.0.layer.0.SelfAttention.v.weight', 'kadapter.adapter.0.layer.0.SelfAttention.q.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.1.layer.0.SelfAttention.k.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
split is 0
Length of dataset retrieving is.. 49
wandb: wandb version 0.13.0 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.12.21
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220805_021008-1s1i6vmt
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run T5_small_templama(debug)_lr.001_adapters
wandb: ⭐️ View project at https://wandb.ai/tjung2/continual_learning_3
wandb: 🚀 View run at https://wandb.ai/tjung2/continual_learning_3/runs/1s1i6vmt
Set SLURM handle signals.
  | Name  | Type                       | Params
-----------------------------------------------------
0 | model | T5ForConditionalGeneration | 81.7 M
-----------------------------------------------------
46.3 M    Trainable params
35.3 M    Non-trainable params
81.7 M    Total params
326.730   Total estimated model params size (MB)
Validation sanity check: 0it [00:00, ?it/s]
                                           /mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/data_loading.py:354: UserWarning: One of given dataloaders is None and it will be skipped.
  rank_zero_warn("One of given dataloaders is None and it will be skipped.")
split is 0
Length of dataset retrieving is.. 49
Training: 0it [00:00, ?it/s]
Training:   0% 0/9 [00:00<?, ?it/s]
Epoch 0:   0% 0/9 [00:00<?, ?it/s] 
Epoch 0:  11% 1/9 [00:01<00:15,  1.96s/it]
Epoch 0:  11% 1/9 [00:01<00:15,  1.96s/it, loss=nan, v_num=6vmt]
Epoch 0:  22% 2/9 [00:02<00:07,  1.01s/it, loss=nan, v_num=6vmt][W reducer.cpp:1158] Warning: find_unused_parameters=True was specified in DDP constructor, but did not find any unused parameters in the forward pass. This flag results in an extra traversal of the autograd graph every iteration,  which can adversely affect performance. If your model indeed never has any unused parameters in the forward pass, consider turning this flag off. Note that this warning may be a false positive if your model has flow control causing later iterations to have unused parameters. (function operator())
Epoch 0:  33% 3/9 [00:02<00:04,  1.43it/s, loss=nan, v_num=6vmt]
Epoch 0:  33% 3/9 [00:02<00:04,  1.43it/s, loss=8, v_num=6vmt]  
Epoch 0:  44% 4/9 [00:02<00:02,  1.86it/s, loss=8, v_num=6vmt]
Epoch 0:  56% 5/9 [00:02<00:01,  2.29it/s, loss=8, v_num=6vmt]
Epoch 0:  67% 6/9 [00:02<00:01,  2.65it/s, loss=8, v_num=6vmt]
Epoch 0:  67% 6/9 [00:02<00:01,  2.65it/s, loss=7.65, v_num=6vmt]
Epoch 0:  78% 7/9 [00:02<00:00,  3.03it/s, loss=7.65, v_num=6vmt]
Epoch 0:  89% 8/9 [00:02<00:00,  3.41it/s, loss=7.65, v_num=6vmt]
Epoch 0: 100% 9/9 [00:02<00:00,  3.59it/s, loss=7.65, v_num=6vmt]
Epoch 0: 100% 9/9 [00:02<00:00,  3.59it/s, loss=7.75, v_num=6vmt]
Epoch 0:   0% 0/9 [00:00<?, ?it/s, loss=7.75, v_num=6vmt]        
Epoch 1:   0% 0/9 [00:00<?, ?it/s, loss=7.75, v_num=6vmt]
Epoch 1:  11% 1/9 [00:00<00:03,  2.29it/s, loss=7.75, v_num=6vmt]
Epoch 1:  22% 2/9 [00:00<00:01,  4.15it/s, loss=7.75, v_num=6vmt]
Epoch 1:  33% 3/9 [00:00<00:01,  5.31it/s, loss=7.75, v_num=6vmt]
Epoch 1:  33% 3/9 [00:00<00:01,  5.31it/s, loss=7.64, v_num=6vmt]
Epoch 1:  44% 4/9 [00:00<00:00,  6.60it/s, loss=7.64, v_num=6vmt]
Epoch 1:  56% 5/9 [00:00<00:00,  7.73it/s, loss=7.64, v_num=6vmt]
Epoch 1:  67% 6/9 [00:00<00:00,  8.27it/s, loss=7.64, v_num=6vmt]
Epoch 1:  67% 6/9 [00:00<00:00,  8.27it/s, loss=7.51, v_num=6vmt]
Epoch 1:  78% 7/9 [00:00<00:00,  9.11it/s, loss=7.51, v_num=6vmt]
Epoch 1:  89% 8/9 [00:00<00:00,  9.88it/s, loss=7.51, v_num=6vmt]
Epoch 1: 100% 9/9 [00:00<00:00,  9.54it/s, loss=7.51, v_num=6vmt]
Epoch 1: 100% 9/9 [00:00<00:00,  9.54it/s, loss=7.3, v_num=6vmt] 
Epoch 1:   0% 0/9 [00:00<?, ?it/s, loss=7.3, v_num=6vmt]        
Epoch 2:   0% 0/9 [00:00<?, ?it/s, loss=7.3, v_num=6vmt]
Epoch 2:  11% 1/9 [00:00<00:03,  2.22it/s, loss=7.3, v_num=6vmt]
Epoch 2:  22% 2/9 [00:00<00:01,  4.04it/s, loss=7.3, v_num=6vmt]
Epoch 2:  33% 3/9 [00:00<00:01,  5.21it/s, loss=7.3, v_num=6vmt]
Epoch 2:  33% 3/9 [00:00<00:01,  5.20it/s, loss=7.13, v_num=6vmt]
Epoch 2:  44% 4/9 [00:00<00:00,  6.46it/s, loss=7.13, v_num=6vmt]
Epoch 2:  56% 5/9 [00:00<00:00,  7.58it/s, loss=7.13, v_num=6vmt]
Epoch 2:  67% 6/9 [00:00<00:00,  8.09it/s, loss=7.13, v_num=6vmt]
Epoch 2:  67% 6/9 [00:00<00:00,  8.08it/s, loss=6.89, v_num=6vmt]
Epoch 2:  78% 7/9 [00:00<00:00,  8.91it/s, loss=6.89, v_num=6vmt]
Epoch 2:  89% 8/9 [00:00<00:00,  9.68it/s, loss=6.89, v_num=6vmt]
Epoch 2: 100% 9/9 [00:00<00:00,  9.34it/s, loss=6.89, v_num=6vmt]
Epoch 2: 100% 9/9 [00:00<00:00,  9.33it/s, loss=6.68, v_num=6vmt]
Epoch 2:   0% 0/9 [00:00<?, ?it/s, loss=6.68, v_num=6vmt]        
Epoch 3:   0% 0/9 [00:00<?, ?it/s, loss=6.68, v_num=6vmt]
Epoch 3:  11% 1/9 [00:00<00:03,  2.37it/s, loss=6.68, v_num=6vmt]
Epoch 3:  22% 2/9 [00:00<00:01,  4.27it/s, loss=6.68, v_num=6vmt]
Epoch 3:  33% 3/9 [00:00<00:01,  5.46it/s, loss=6.68, v_num=6vmt]
Epoch 3:  33% 3/9 [00:00<00:01,  5.45it/s, loss=6.43, v_num=6vmt]
Epoch 3:  44% 4/9 [00:00<00:00,  6.76it/s, loss=6.43, v_num=6vmt]
Epoch 3:  56% 5/9 [00:00<00:00,  7.90it/s, loss=6.43, v_num=6vmt]
Epoch 3:  67% 6/9 [00:00<00:00,  8.41it/s, loss=6.43, v_num=6vmt]
Epoch 3:  67% 6/9 [00:00<00:00,  8.40it/s, loss=6.21, v_num=6vmt]
Epoch 3:  78% 7/9 [00:00<00:00,  9.25it/s, loss=6.21, v_num=6vmt]
Epoch 3:  89% 8/9 [00:00<00:00, 10.03it/s, loss=6.21, v_num=6vmt]
Epoch 3: 100% 9/9 [00:00<00:00,  9.64it/s, loss=6.21, v_num=6vmt]
Epoch 3: 100% 9/9 [00:00<00:00,  9.63it/s, loss=5.98, v_num=6vmt]
Epoch 3:   0% 0/9 [00:00<?, ?it/s, loss=5.98, v_num=6vmt]        
Epoch 4:   0% 0/9 [00:00<?, ?it/s, loss=5.98, v_num=6vmt]
Epoch 4:  11% 1/9 [00:00<00:03,  2.17it/s, loss=5.98, v_num=6vmt]
Epoch 4:  22% 2/9 [00:00<00:01,  3.93it/s, loss=5.98, v_num=6vmt]
Epoch 4:  33% 3/9 [00:00<00:01,  5.10it/s, loss=5.98, v_num=6vmt]
Epoch 4:  33% 3/9 [00:00<00:01,  5.09it/s, loss=5.75, v_num=6vmt]
Epoch 4:  44% 4/9 [00:00<00:00,  6.35it/s, loss=5.75, v_num=6vmt]
Epoch 4:  56% 5/9 [00:00<00:00,  7.46it/s, loss=5.75, v_num=6vmt]
Epoch 4:  67% 6/9 [00:00<00:00,  7.98it/s, loss=5.75, v_num=6vmt]
Epoch 4:  67% 6/9 [00:00<00:00,  7.97it/s, loss=5.55, v_num=6vmt]
Epoch 4:  78% 7/9 [00:00<00:00,  8.82it/s, loss=5.55, v_num=6vmt]
Epoch 4:  89% 8/9 [00:00<00:00,  9.59it/s, loss=5.55, v_num=6vmt]
Epoch 4: 100% 9/9 [00:00<00:00,  9.27it/s, loss=5.55, v_num=6vmt]
Epoch 4: 100% 9/9 [00:00<00:00,  9.27it/s, loss=5.39, v_num=6vmt]
Epoch 4:   0% 0/9 [00:00<?, ?it/s, loss=5.39, v_num=6vmt]        
Epoch 5:   0% 0/9 [00:00<?, ?it/s, loss=5.39, v_num=6vmt]
Epoch 5:  11% 1/9 [00:00<00:03,  2.20it/s, loss=5.39, v_num=6vmt]
Epoch 5:  22% 2/9 [00:00<00:01,  4.00it/s, loss=5.39, v_num=6vmt]
Epoch 5:  33% 3/9 [00:00<00:01,  5.15it/s, loss=5.39, v_num=6vmt]
Epoch 5:  33% 3/9 [00:00<00:01,  5.14it/s, loss=5.21, v_num=6vmt]
Epoch 5:  44% 4/9 [00:00<00:00,  6.40it/s, loss=5.21, v_num=6vmt]
Epoch 5:  56% 5/9 [00:00<00:00,  7.52it/s, loss=5.21, v_num=6vmt]
Epoch 5:  67% 6/9 [00:00<00:00,  8.07it/s, loss=5.21, v_num=6vmt]
Epoch 5:  67% 6/9 [00:00<00:00,  8.07it/s, loss=5.03, v_num=6vmt]
Epoch 5:  78% 7/9 [00:00<00:00,  8.90it/s, loss=5.03, v_num=6vmt]
Epoch 5:  89% 8/9 [00:00<00:00,  9.68it/s, loss=5.03, v_num=6vmt]
Epoch 5: 100% 9/9 [00:00<00:00,  9.36it/s, loss=5.03, v_num=6vmt]
Epoch 5: 100% 9/9 [00:00<00:00,  9.36it/s, loss=4.86, v_num=6vmt]
Epoch 5:   0% 0/9 [00:00<?, ?it/s, loss=4.86, v_num=6vmt]        
Epoch 6:   0% 0/9 [00:00<?, ?it/s, loss=4.86, v_num=6vmt]
Epoch 6:  11% 1/9 [00:00<00:03,  2.33it/s, loss=4.86, v_num=6vmt]
Epoch 6:  22% 2/9 [00:00<00:01,  4.20it/s, loss=4.86, v_num=6vmt]
Epoch 6:  33% 3/9 [00:00<00:01,  5.37it/s, loss=4.86, v_num=6vmt]
Epoch 6:  33% 3/9 [00:00<00:01,  5.37it/s, loss=4.7, v_num=6vmt] 
Epoch 6:  44% 4/9 [00:00<00:00,  6.65it/s, loss=4.7, v_num=6vmt]
Epoch 6:  56% 5/9 [00:00<00:00,  7.79it/s, loss=4.7, v_num=6vmt]
Epoch 6:  67% 6/9 [00:00<00:00,  8.33it/s, loss=4.7, v_num=6vmt]
Epoch 6:  67% 6/9 [00:00<00:00,  8.33it/s, loss=4.55, v_num=6vmt]
Epoch 6:  78% 7/9 [00:00<00:00,  9.17it/s, loss=4.55, v_num=6vmt]
Epoch 6:  89% 8/9 [00:00<00:00,  9.96it/s, loss=4.55, v_num=6vmt]
Epoch 6: 100% 9/9 [00:00<00:00,  9.50it/s, loss=4.55, v_num=6vmt]
Epoch 6: 100% 9/9 [00:00<00:00,  9.49it/s, loss=4.23, v_num=6vmt]
Epoch 6:   0% 0/9 [00:00<?, ?it/s, loss=4.23, v_num=6vmt]        
Epoch 7:   0% 0/9 [00:00<?, ?it/s, loss=4.23, v_num=6vmt]
Epoch 7:  11% 1/9 [00:00<00:03,  2.31it/s, loss=4.23, v_num=6vmt]
Epoch 7:  22% 2/9 [00:00<00:01,  4.23it/s, loss=4.23, v_num=6vmt]
Epoch 7:  33% 3/9 [00:00<00:01,  5.38it/s, loss=4.23, v_num=6vmt]
Epoch 7:  33% 3/9 [00:00<00:01,  5.38it/s, loss=3.92, v_num=6vmt]
Epoch 7:  44% 4/9 [00:00<00:00,  6.68it/s, loss=3.92, v_num=6vmt]
Epoch 7:  56% 5/9 [00:00<00:00,  7.82it/s, loss=3.92, v_num=6vmt]
Epoch 7:  67% 6/9 [00:00<00:00,  8.36it/s, loss=3.92, v_num=6vmt]
Epoch 7:  67% 6/9 [00:00<00:00,  8.36it/s, loss=3.58, v_num=6vmt]
Epoch 7:  78% 7/9 [00:00<00:00,  9.20it/s, loss=3.58, v_num=6vmt]
Epoch 7:  89% 8/9 [00:00<00:00,  9.98it/s, loss=3.58, v_num=6vmt]
Epoch 7: 100% 9/9 [00:00<00:00,  9.42it/s, loss=3.58, v_num=6vmt]
Epoch 7: 100% 9/9 [00:00<00:00,  9.41it/s, loss=3.27, v_num=6vmt]
Epoch 7: 100% 9/9 [00:17<00:00,  2.00s/it, loss=3.27, v_num=6vmt]
Epoch 7: 100% 9/9 [03:58<00:00, 26.46s/it, loss=3.27, v_num=6vmt]
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.007 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced T5_small_templama(debug)_lr.001_adapters: https://wandb.ai/tjung2/continual_learning_3/runs/1s1i6vmt
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220805_021008-1s1i6vmt/logs
