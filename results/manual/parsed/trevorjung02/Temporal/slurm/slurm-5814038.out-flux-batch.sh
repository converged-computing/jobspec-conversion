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
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapter.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.1.layer.0.SelfAttention.k.weight', 'kadapter.adapter.0.layer.1.layer_norm.weight', 'kadapter.adapter.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapter.0.layer.0.layer_norm.weight', 'kadapter.layer_norm.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.0.layer.0.SelfAttention.v.weight', 'kadapter.adapter.1.layer.0.SelfAttention.v.weight', 'kadapter.adapter.0.layer.0.SelfAttention.o.weight', 'kadapter.adapter.1.layer.0.SelfAttention.q.weight', 'kadapter.adapter.0.layer.0.SelfAttention.q.weight', 'kadapter.adapter.1.layer.0.SelfAttention.o.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.1.layer.0.layer_norm.weight', 'kadapter.adapter.1.layer.1.layer_norm.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.0.layer.0.SelfAttention.k.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi_0.weight']
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
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220805_022723-2judcway
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run T5_small_templama(debug)_lr.001_adapters
wandb: ⭐️ View project at https://wandb.ai/tjung2/continual_learning_3
wandb: 🚀 View run at https://wandb.ai/tjung2/continual_learning_3/runs/2judcway
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
split is 0
Length of dataset retrieving is.. 49
Training: 0it [00:00, ?it/s]/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/data_loading.py:354: UserWarning: One of given dataloaders is None and it will be skipped.
  rank_zero_warn("One of given dataloaders is None and it will be skipped.")
Training:   0% 0/9 [00:00<?, ?it/s]
Epoch 0:   0% 0/9 [00:00<?, ?it/s] 
Epoch 0:  11% 1/9 [00:00<00:07,  1.03it/s]
Epoch 0:  11% 1/9 [00:00<00:07,  1.03it/s, loss=nan, v_num=cway]
Epoch 0:  22% 2/9 [00:01<00:03,  1.96it/s, loss=nan, v_num=cway][W reducer.cpp:1158] Warning: find_unused_parameters=True was specified in DDP constructor, but did not find any unused parameters in the forward pass. This flag results in an extra traversal of the autograd graph every iteration,  which can adversely affect performance. If your model indeed never has any unused parameters in the forward pass, consider turning this flag off. Note that this warning may be a false positive if your model has flow control causing later iterations to have unused parameters. (function operator())
Epoch 0:  33% 3/9 [00:01<00:02,  2.70it/s, loss=nan, v_num=cway]
Epoch 0:  33% 3/9 [00:01<00:02,  2.70it/s, loss=8, v_num=cway]  
Epoch 0:  44% 4/9 [00:01<00:01,  3.47it/s, loss=8, v_num=cway]
Epoch 0:  56% 5/9 [00:01<00:00,  4.19it/s, loss=8, v_num=cway]
Epoch 0:  67% 6/9 [00:01<00:00,  4.71it/s, loss=8, v_num=cway]
Epoch 0:  67% 6/9 [00:01<00:00,  4.71it/s, loss=7.65, v_num=cway]
Epoch 0:  78% 7/9 [00:01<00:00,  5.32it/s, loss=7.65, v_num=cway]
Epoch 0:  89% 8/9 [00:01<00:00,  5.90it/s, loss=7.65, v_num=cway]
Epoch 0: 100% 9/9 [00:01<00:00,  5.92it/s, loss=7.65, v_num=cway]
Epoch 0: 100% 9/9 [00:01<00:00,  5.92it/s, loss=7.78, v_num=cway]
Epoch 0:   0% 0/9 [00:00<?, ?it/s, loss=7.78, v_num=cway]        
Epoch 1:   0% 0/9 [00:00<?, ?it/s, loss=7.78, v_num=cway]
Epoch 1:  11% 1/9 [00:00<00:03,  2.30it/s, loss=7.78, v_num=cway]
Epoch 1:  22% 2/9 [00:00<00:01,  4.17it/s, loss=7.78, v_num=cway]
Epoch 1:  33% 3/9 [00:00<00:01,  5.32it/s, loss=7.78, v_num=cway]
Epoch 1:  33% 3/9 [00:00<00:01,  5.31it/s, loss=7.75, v_num=cway]
Epoch 1:  44% 4/9 [00:00<00:00,  6.59it/s, loss=7.75, v_num=cway]
Epoch 1:  56% 5/9 [00:00<00:00,  7.71it/s, loss=7.75, v_num=cway]
Epoch 1:  67% 6/9 [00:00<00:00,  8.22it/s, loss=7.75, v_num=cway]
Epoch 1:  67% 6/9 [00:00<00:00,  8.21it/s, loss=7.71, v_num=cway]
Epoch 1:  78% 7/9 [00:00<00:00,  9.03it/s, loss=7.71, v_num=cway]
Epoch 1:  89% 8/9 [00:00<00:00,  9.77it/s, loss=7.71, v_num=cway]
Epoch 1: 100% 9/9 [00:00<00:00,  9.38it/s, loss=7.71, v_num=cway]
Epoch 1: 100% 9/9 [00:00<00:00,  9.37it/s, loss=7.56, v_num=cway]
Epoch 1:   0% 0/9 [00:00<?, ?it/s, loss=7.56, v_num=cway]        
Epoch 2:   0% 0/9 [00:00<?, ?it/s, loss=7.56, v_num=cway]
Epoch 2:  11% 1/9 [00:00<00:03,  2.10it/s, loss=7.56, v_num=cway]
Epoch 2:  22% 2/9 [00:00<00:01,  3.81it/s, loss=7.56, v_num=cway]
Epoch 2:  33% 3/9 [00:00<00:01,  4.94it/s, loss=7.56, v_num=cway]
Epoch 2:  33% 3/9 [00:00<00:01,  4.94it/s, loss=7.52, v_num=cway]
Epoch 2:  44% 4/9 [00:00<00:00,  6.16it/s, loss=7.52, v_num=cway]
Epoch 2:  56% 5/9 [00:00<00:00,  7.23it/s, loss=7.52, v_num=cway]
Epoch 2:  67% 6/9 [00:00<00:00,  7.76it/s, loss=7.52, v_num=cway]
Epoch 2:  67% 6/9 [00:00<00:00,  7.75it/s, loss=7.35, v_num=cway]
Epoch 2:  78% 7/9 [00:00<00:00,  8.56it/s, loss=7.35, v_num=cway]
Epoch 2:  89% 8/9 [00:00<00:00,  9.30it/s, loss=7.35, v_num=cway]
Epoch 2: 100% 9/9 [00:00<00:00,  9.02it/s, loss=7.35, v_num=cway]
Epoch 2: 100% 9/9 [00:00<00:00,  9.02it/s, loss=7.16, v_num=cway]
Epoch 2: 100% 9/9 [00:13<00:00,  1.53s/it, loss=7.16, v_num=cway]
Epoch 2:   0% 0/9 [00:00<?, ?it/s, loss=7.16, v_num=cway]        
Epoch 3:   0% 0/9 [00:00<?, ?it/s, loss=7.16, v_num=cway]
Epoch 3:  11% 1/9 [00:00<00:03,  2.22it/s, loss=7.16, v_num=cway]
Epoch 3:  11% 1/9 [00:00<00:03,  2.21it/s, loss=7.16, v_num=cway]
Epoch 3:  22% 2/9 [00:00<00:01,  4.04it/s, loss=7.16, v_num=cway]
Epoch 3:  33% 3/9 [00:00<00:01,  5.20it/s, loss=7.16, v_num=cway]
Epoch 3:  33% 3/9 [00:00<00:01,  5.19it/s, loss=6.97, v_num=cway]
Epoch 3:  44% 4/9 [00:00<00:00,  6.47it/s, loss=6.97, v_num=cway]
Epoch 3:  56% 5/9 [00:00<00:00,  7.60it/s, loss=6.97, v_num=cway]
Epoch 3:  67% 6/9 [00:00<00:00,  8.18it/s, loss=6.97, v_num=cway]
Epoch 3:  67% 6/9 [00:00<00:00,  8.17it/s, loss=6.81, v_num=cway]
Epoch 3:  78% 7/9 [00:00<00:00,  9.02it/s, loss=6.81, v_num=cway]
Epoch 3:  89% 8/9 [00:00<00:00,  9.81it/s, loss=6.81, v_num=cway]
Epoch 3: 100% 9/9 [00:00<00:00,  9.41it/s, loss=6.81, v_num=cway]
Epoch 3: 100% 9/9 [00:00<00:00,  9.41it/s, loss=6.63, v_num=cway]
Epoch 3: 100% 9/9 [00:11<00:00,  1.25s/it, loss=6.63, v_num=cway]
Epoch 3:   0% 0/9 [00:00<?, ?it/s, loss=6.63, v_num=cway]        
Epoch 4:   0% 0/9 [00:00<?, ?it/s, loss=6.63, v_num=cway]
Epoch 4:  11% 1/9 [00:00<00:03,  2.44it/s, loss=6.63, v_num=cway]
Epoch 4:  11% 1/9 [00:00<00:03,  2.44it/s, loss=6.63, v_num=cway]
Epoch 4:  22% 2/9 [00:00<00:01,  4.42it/s, loss=6.63, v_num=cway]
Epoch 4:  33% 3/9 [00:00<00:01,  5.56it/s, loss=6.63, v_num=cway]
Epoch 4:  33% 3/9 [00:00<00:01,  5.56it/s, loss=6.42, v_num=cway]
Epoch 4:  44% 4/9 [00:00<00:00,  6.87it/s, loss=6.42, v_num=cway]
Epoch 4:  56% 5/9 [00:00<00:00,  8.03it/s, loss=6.42, v_num=cway]
Epoch 4:  67% 6/9 [00:00<00:00,  8.54it/s, loss=6.42, v_num=cway]
Epoch 4:  67% 6/9 [00:00<00:00,  8.54it/s, loss=6.23, v_num=cway]
Epoch 4:  78% 7/9 [00:00<00:00,  9.38it/s, loss=6.23, v_num=cway]
Epoch 4:  89% 8/9 [00:00<00:00, 10.18it/s, loss=6.23, v_num=cway]
Epoch 4: 100% 9/9 [00:00<00:00,  9.75it/s, loss=6.23, v_num=cway]
Epoch 4: 100% 9/9 [00:00<00:00,  9.74it/s, loss=6.11, v_num=cway]
Epoch 4: 100% 9/9 [00:17<00:00,  1.92s/it, loss=6.11, v_num=cway]
Epoch 4:   0% 0/9 [00:00<?, ?it/s, loss=6.11, v_num=cway]        
Epoch 5:   0% 0/9 [00:00<?, ?it/s, loss=6.11, v_num=cway]
Epoch 5:  11% 1/9 [00:00<00:03,  2.60it/s, loss=6.11, v_num=cway]
Epoch 5:  11% 1/9 [00:00<00:03,  2.59it/s, loss=6.11, v_num=cway]
Epoch 5:  22% 2/9 [00:00<00:01,  4.46it/s, loss=6.11, v_num=cway]
Epoch 5:  33% 3/9 [00:00<00:01,  5.69it/s, loss=6.11, v_num=cway]
Epoch 5:  33% 3/9 [00:00<00:01,  5.69it/s, loss=5.94, v_num=cway]
Epoch 5:  44% 4/9 [00:00<00:00,  7.05it/s, loss=5.94, v_num=cway]
Epoch 5:  56% 5/9 [00:00<00:00,  8.23it/s, loss=5.94, v_num=cway]
Epoch 5:  67% 6/9 [00:00<00:00,  8.73it/s, loss=5.94, v_num=cway]
Epoch 5:  67% 6/9 [00:00<00:00,  8.73it/s, loss=5.75, v_num=cway]
Epoch 5:  78% 7/9 [00:00<00:00,  9.58it/s, loss=5.75, v_num=cway]
Epoch 5:  89% 8/9 [00:00<00:00, 10.38it/s, loss=5.75, v_num=cway]
Epoch 5: 100% 9/9 [00:00<00:00,  9.97it/s, loss=5.75, v_num=cway]
Epoch 5: 100% 9/9 [00:00<00:00,  9.96it/s, loss=5.57, v_num=cway]
Epoch 5: 100% 9/9 [00:15<00:00,  1.70s/it, loss=5.57, v_num=cway]
Epoch 5:   0% 0/9 [00:00<?, ?it/s, loss=5.57, v_num=cway]        
Epoch 6:   0% 0/9 [00:00<?, ?it/s, loss=5.57, v_num=cway]
Epoch 6:  11% 1/9 [00:00<00:03,  2.34it/s, loss=5.57, v_num=cway]
Epoch 6:  11% 1/9 [00:00<00:03,  2.34it/s, loss=5.57, v_num=cway]
Epoch 6:  22% 2/9 [00:00<00:01,  4.24it/s, loss=5.57, v_num=cway]
Epoch 6:  33% 3/9 [00:00<00:01,  5.42it/s, loss=5.57, v_num=cway]
Epoch 6:  33% 3/9 [00:00<00:01,  5.42it/s, loss=5.39, v_num=cway]
Epoch 6:  44% 4/9 [00:00<00:00,  6.73it/s, loss=5.39, v_num=cway]
Epoch 6:  56% 5/9 [00:00<00:00,  7.90it/s, loss=5.39, v_num=cway]
Epoch 6:  67% 6/9 [00:00<00:00,  8.46it/s, loss=5.39, v_num=cway]
Epoch 6:  67% 6/9 [00:00<00:00,  8.46it/s, loss=5.23, v_num=cway]
Epoch 6:  78% 7/9 [00:00<00:00,  9.32it/s, loss=5.23, v_num=cway]
Epoch 6:  89% 8/9 [00:00<00:00, 10.11it/s, loss=5.23, v_num=cway]
Epoch 6: 100% 9/9 [00:00<00:00,  9.72it/s, loss=5.23, v_num=cway]
Epoch 6: 100% 9/9 [00:00<00:00,  9.72it/s, loss=4.94, v_num=cway]
Epoch 6: 100% 9/9 [00:11<00:00,  1.26s/it, loss=4.94, v_num=cway]
Epoch 6:   0% 0/9 [00:00<?, ?it/s, loss=4.94, v_num=cway]        
Epoch 7:   0% 0/9 [00:00<?, ?it/s, loss=4.94, v_num=cway]
Epoch 7:  11% 1/9 [00:00<00:03,  2.21it/s, loss=4.94, v_num=cway]
Epoch 7:  11% 1/9 [00:00<00:03,  2.21it/s, loss=4.94, v_num=cway]
Epoch 7:  22% 2/9 [00:00<00:01,  3.96it/s, loss=4.94, v_num=cway]
Epoch 7:  33% 3/9 [00:00<00:01,  5.01it/s, loss=4.94, v_num=cway]
Epoch 7:  33% 3/9 [00:00<00:01,  5.01it/s, loss=4.65, v_num=cway]
Epoch 7:  44% 4/9 [00:00<00:00,  6.25it/s, loss=4.65, v_num=cway]
Epoch 7:  56% 5/9 [00:00<00:00,  7.34it/s, loss=4.65, v_num=cway]
Epoch 7:  67% 6/9 [00:00<00:00,  7.89it/s, loss=4.65, v_num=cway]
Epoch 7:  67% 6/9 [00:00<00:00,  7.89it/s, loss=4.31, v_num=cway]
Epoch 7:  78% 7/9 [00:00<00:00,  8.69it/s, loss=4.31, v_num=cway]
Epoch 7:  89% 8/9 [00:00<00:00,  9.45it/s, loss=4.31, v_num=cway]
Epoch 7: 100% 9/9 [00:00<00:00,  9.14it/s, loss=4.31, v_num=cway]
Epoch 7: 100% 9/9 [00:00<00:00,  9.14it/s, loss=4.08, v_num=cway]
Epoch 7:   0% 0/9 [00:00<?, ?it/s, loss=4.08, v_num=cway]        
Epoch 8:   0% 0/9 [00:00<?, ?it/s, loss=4.08, v_num=cway]
Epoch 8:  11% 1/9 [00:00<00:03,  2.12it/s, loss=4.08, v_num=cway]
Epoch 8:  22% 2/9 [00:00<00:01,  3.88it/s, loss=4.08, v_num=cway]
Epoch 8:  33% 3/9 [00:00<00:01,  5.01it/s, loss=4.08, v_num=cway]
Epoch 8:  33% 3/9 [00:00<00:01,  5.00it/s, loss=3.77, v_num=cway]
Epoch 8:  44% 4/9 [00:00<00:00,  6.24it/s, loss=3.77, v_num=cway]
Epoch 8:  56% 5/9 [00:00<00:00,  7.35it/s, loss=3.77, v_num=cway]
Epoch 8:  67% 6/9 [00:00<00:00,  7.90it/s, loss=3.77, v_num=cway]
Epoch 8:  67% 6/9 [00:00<00:00,  7.90it/s, loss=3.48, v_num=cway]
Epoch 8:  78% 7/9 [00:00<00:00,  8.72it/s, loss=3.48, v_num=cway]
Epoch 8:  89% 8/9 [00:00<00:00,  9.50it/s, loss=3.48, v_num=cway]
Epoch 8: 100% 9/9 [00:00<00:00,  9.21it/s, loss=3.48, v_num=cway]
Epoch 8: 100% 9/9 [00:00<00:00,  9.21it/s, loss=3.19, v_num=cway]
Epoch 8: 100% 9/9 [00:17<00:00,  1.98s/it, loss=3.19, v_num=cway]
Epoch 8:   0% 0/9 [00:00<?, ?it/s, loss=3.19, v_num=cway]        
Epoch 9:   0% 0/9 [00:00<?, ?it/s, loss=3.19, v_num=cway]
Epoch 9:  11% 1/9 [00:00<00:03,  2.22it/s, loss=3.19, v_num=cway]
Epoch 9:  11% 1/9 [00:00<00:03,  2.21it/s, loss=3.19, v_num=cway]
Epoch 9:  22% 2/9 [00:00<00:01,  4.01it/s, loss=3.19, v_num=cway]
Epoch 9:  33% 3/9 [00:00<00:01,  5.18it/s, loss=3.19, v_num=cway]
Epoch 9:  33% 3/9 [00:00<00:01,  5.17it/s, loss=2.93, v_num=cway]
Epoch 9:  44% 4/9 [00:00<00:00,  6.45it/s, loss=2.93, v_num=cway]
Epoch 9:  56% 5/9 [00:00<00:00,  7.57it/s, loss=2.93, v_num=cway]
Epoch 9:  67% 6/9 [00:00<00:00,  8.16it/s, loss=2.93, v_num=cway]
Epoch 9:  67% 6/9 [00:00<00:00,  8.15it/s, loss=2.69, v_num=cway]
Epoch 9:  78% 7/9 [00:00<00:00,  9.00it/s, loss=2.69, v_num=cway]
Epoch 9:  89% 8/9 [00:00<00:00,  9.80it/s, loss=2.69, v_num=cway]
Epoch 9: 100% 9/9 [00:00<00:00,  9.46it/s, loss=2.69, v_num=cway]
Epoch 9: 100% 9/9 [00:00<00:00,  9.46it/s, loss=2.48, v_num=cway]
Epoch 9:   0% 0/9 [00:00<?, ?it/s, loss=2.48, v_num=cway]        
Epoch 10:   0% 0/9 [00:00<?, ?it/s, loss=2.48, v_num=cway]
Epoch 10:  11% 1/9 [00:00<00:03,  2.08it/s, loss=2.48, v_num=cway]
Epoch 10:  22% 2/9 [00:00<00:01,  3.80it/s, loss=2.48, v_num=cway]
Epoch 10:  33% 3/9 [00:00<00:01,  4.94it/s, loss=2.48, v_num=cway]
Epoch 10:  33% 3/9 [00:00<00:01,  4.93it/s, loss=2.25, v_num=cway]
Epoch 10:  44% 4/9 [00:00<00:00,  6.17it/s, loss=2.25, v_num=cway]
Epoch 10:  56% 5/9 [00:00<00:00,  7.27it/s, loss=2.25, v_num=cway]
Epoch 10:  67% 6/9 [00:00<00:00,  7.85it/s, loss=2.25, v_num=cway]
Epoch 10:  67% 6/9 [00:00<00:00,  7.85it/s, loss=2.07, v_num=cway]
Epoch 10:  78% 7/9 [00:00<00:00,  8.68it/s, loss=2.07, v_num=cway]
Epoch 10:  89% 8/9 [00:00<00:00,  9.46it/s, loss=2.07, v_num=cway]
Epoch 10: 100% 9/9 [00:00<00:00,  9.20it/s, loss=2.07, v_num=cway]
Epoch 10: 100% 9/9 [00:00<00:00,  9.19it/s, loss=1.91, v_num=cway]
Epoch 10: 100% 9/9 [00:13<00:00,  1.47s/it, loss=1.91, v_num=cway]
Epoch 10:   0% 0/9 [00:00<?, ?it/s, loss=1.91, v_num=cway]        
Epoch 11:   0% 0/9 [00:00<?, ?it/s, loss=1.91, v_num=cway]
Epoch 11:  11% 1/9 [00:00<00:03,  2.30it/s, loss=1.91, v_num=cway]
Epoch 11:  11% 1/9 [00:00<00:03,  2.30it/s, loss=1.91, v_num=cway]
Epoch 11:  22% 2/9 [00:00<00:01,  4.17it/s, loss=1.91, v_num=cway]
Epoch 11:  33% 3/9 [00:00<00:01,  5.34it/s, loss=1.91, v_num=cway]
Epoch 11:  33% 3/9 [00:00<00:01,  5.34it/s, loss=1.76, v_num=cway]
Epoch 11:  44% 4/9 [00:00<00:00,  6.63it/s, loss=1.76, v_num=cway]
Epoch 11:  56% 5/9 [00:00<00:00,  7.75it/s, loss=1.76, v_num=cway]
Epoch 11:  67% 6/9 [00:00<00:00,  8.28it/s, loss=1.76, v_num=cway]
Epoch 11:  67% 6/9 [00:00<00:00,  8.28it/s, loss=1.57, v_num=cway]
Epoch 11:  78% 7/9 [00:00<00:00,  9.11it/s, loss=1.57, v_num=cway]
Epoch 11:  89% 8/9 [00:00<00:00,  9.89it/s, loss=1.57, v_num=cway]
Epoch 11: 100% 9/9 [00:00<00:00,  9.55it/s, loss=1.57, v_num=cway]
Epoch 11: 100% 9/9 [00:00<00:00,  9.55it/s, loss=1.43, v_num=cway]
Epoch 11:   0% 0/9 [00:00<?, ?it/s, loss=1.43, v_num=cway]        
Epoch 12:   0% 0/9 [00:00<?, ?it/s, loss=1.43, v_num=cway]
Epoch 12:  11% 1/9 [00:00<00:03,  2.31it/s, loss=1.43, v_num=cway]
Epoch 12:  22% 2/9 [00:00<00:01,  4.17it/s, loss=1.43, v_num=cway]
Epoch 12:  33% 3/9 [00:00<00:01,  5.36it/s, loss=1.43, v_num=cway]
Epoch 12:  33% 3/9 [00:00<00:01,  5.36it/s, loss=1.33, v_num=cway]
Epoch 12:  44% 4/9 [00:00<00:00,  6.66it/s, loss=1.33, v_num=cway]
Epoch 12:  56% 5/9 [00:00<00:00,  7.80it/s, loss=1.33, v_num=cway]
Epoch 12:  67% 6/9 [00:00<00:00,  8.32it/s, loss=1.33, v_num=cway]
Epoch 12:  67% 6/9 [00:00<00:00,  8.32it/s, loss=1.23, v_num=cway]
Epoch 12:  78% 7/9 [00:00<00:00,  9.16it/s, loss=1.23, v_num=cway]
Epoch 12:  89% 8/9 [00:00<00:00,  9.95it/s, loss=1.23, v_num=cway]
Epoch 12: 100% 9/9 [00:00<00:00,  9.51it/s, loss=1.23, v_num=cway]
Epoch 12: 100% 9/9 [00:00<00:00,  9.51it/s, loss=1.15, v_num=cway]
Epoch 12: 100% 9/9 [00:13<00:00,  1.54s/it, loss=1.15, v_num=cway]
Epoch 12:   0% 0/9 [00:00<?, ?it/s, loss=1.15, v_num=cway]        
Epoch 13:   0% 0/9 [00:00<?, ?it/s, loss=1.15, v_num=cway]
Epoch 13:  11% 1/9 [00:00<00:03,  2.41it/s, loss=1.15, v_num=cway]
Epoch 13:  11% 1/9 [00:00<00:03,  2.40it/s, loss=1.15, v_num=cway]
Epoch 13:  22% 2/9 [00:00<00:01,  4.34it/s, loss=1.15, v_num=cway]
Epoch 13:  33% 3/9 [00:00<00:01,  5.52it/s, loss=1.15, v_num=cway]
Epoch 13:  33% 3/9 [00:00<00:01,  5.52it/s, loss=1.08, v_num=cway]
Epoch 13:  44% 4/9 [00:00<00:00,  6.84it/s, loss=1.08, v_num=cway]
Epoch 13:  56% 5/9 [00:00<00:00,  7.99it/s, loss=1.08, v_num=cway]
Epoch 13:  67% 6/9 [00:00<00:00,  8.52it/s, loss=1.08, v_num=cway]
Epoch 13:  67% 6/9 [00:00<00:00,  8.52it/s, loss=0.988, v_num=cway]
Epoch 13:  78% 7/9 [00:00<00:00,  9.37it/s, loss=0.988, v_num=cway]
Epoch 13:  89% 8/9 [00:00<00:00, 10.15it/s, loss=0.988, v_num=cway]
Epoch 13: 100% 9/9 [00:00<00:00,  9.50it/s, loss=0.988, v_num=cway]
Epoch 13: 100% 9/9 [00:00<00:00,  9.49it/s, loss=0.941, v_num=cway]
Epoch 13:   0% 0/9 [00:00<?, ?it/s, loss=0.941, v_num=cway]        
Epoch 14:   0% 0/9 [00:00<?, ?it/s, loss=0.941, v_num=cway]
Epoch 14:  11% 1/9 [00:00<00:03,  2.23it/s, loss=0.941, v_num=cway]
Epoch 14:  22% 2/9 [00:00<00:01,  4.05it/s, loss=0.941, v_num=cway]
Epoch 14:  33% 3/9 [00:00<00:01,  5.22it/s, loss=0.941, v_num=cway]
Epoch 14:  33% 3/9 [00:00<00:01,  5.22it/s, loss=0.897, v_num=cway]
Epoch 14:  44% 4/9 [00:00<00:00,  6.50it/s, loss=0.897, v_num=cway]
Epoch 14:  56% 5/9 [00:00<00:00,  7.63it/s, loss=0.897, v_num=cway]
Epoch 14:  67% 6/9 [00:00<00:00,  8.14it/s, loss=0.897, v_num=cway]
Epoch 14:  67% 6/9 [00:00<00:00,  8.14it/s, loss=0.769, v_num=cway]
Epoch 14:  78% 7/9 [00:00<00:00,  8.99it/s, loss=0.769, v_num=cway]
Epoch 14:  89% 8/9 [00:00<00:00,  9.78it/s, loss=0.769, v_num=cway]
Epoch 14: 100% 9/9 [00:00<00:00,  9.44it/s, loss=0.769, v_num=cway]
Epoch 14: 100% 9/9 [00:00<00:00,  9.44it/s, loss=0.727, v_num=cway]
Epoch 14: 100% 9/9 [00:15<00:00,  1.70s/it, loss=0.727, v_num=cway]
Epoch 14:   0% 0/9 [00:00<?, ?it/s, loss=0.727, v_num=cway]        
Epoch 15:   0% 0/9 [00:00<?, ?it/s, loss=0.727, v_num=cway]
Epoch 15:  11% 1/9 [00:00<00:03,  2.29it/s, loss=0.727, v_num=cway]
Epoch 15:  11% 1/9 [00:00<00:03,  2.29it/s, loss=0.727, v_num=cway]
Epoch 15:  22% 2/9 [00:00<00:01,  4.18it/s, loss=0.727, v_num=cway]
Epoch 15:  33% 3/9 [00:00<00:01,  5.34it/s, loss=0.727, v_num=cway]
Epoch 15:  33% 3/9 [00:00<00:01,  5.33it/s, loss=0.702, v_num=cway]
Epoch 15:  44% 4/9 [00:00<00:00,  6.63it/s, loss=0.702, v_num=cway]
Epoch 15:  56% 5/9 [00:00<00:00,  7.74it/s, loss=0.702, v_num=cway]
Epoch 15:  67% 6/9 [00:00<00:00,  8.28it/s, loss=0.702, v_num=cway]
Epoch 15:  67% 6/9 [00:00<00:00,  8.28it/s, loss=0.653, v_num=cway]
Epoch 15:  78% 7/9 [00:00<00:00,  9.11it/s, loss=0.653, v_num=cway]
Epoch 15:  89% 8/9 [00:00<00:00,  9.90it/s, loss=0.653, v_num=cway]
Epoch 15: 100% 9/9 [00:00<00:00,  9.54it/s, loss=0.653, v_num=cway]
Epoch 15: 100% 9/9 [00:00<00:00,  9.54it/s, loss=0.619, v_num=cway]
Epoch 15: 100% 9/9 [00:17<00:00,  1.93s/it, loss=0.619, v_num=cway]
Epoch 15: 100% 9/9 [00:28<00:00,  3.12s/it, loss=0.619, v_num=cway]
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced T5_small_templama(debug)_lr.001_adapters: https://wandb.ai/tjung2/continual_learning_3/runs/2judcway
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220805_022723-2judcway/logs
