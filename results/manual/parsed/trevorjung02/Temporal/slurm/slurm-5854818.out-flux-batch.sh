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
python run.py --config configs/templama/training/t5_baseline_debug.json
--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
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
0 | model | T5ForConditionalGeneration | 77.0 M
-----------------------------------------------------
77.0 M    Trainable params
0         Non-trainable params
77.0 M    Total params
307.845   Total estimated model params size (MB)
Not freezing any parameters!
split is 0
Length of dataset retrieving is.. 49
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 410
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]
Validation sanity check:  50%|█████     | 1/2 [00:00<00:00,  2.54it/s]
split is 0
Length of dataset retrieving is.. 49
Training: 0it [00:00, ?it/s]
Training:   0%|          | 0/91 [00:00<?, ?it/s]
Epoch 0:   0%|          | 0/91 [00:00<?, ?it/s] 
Epoch 0:   1%|          | 1/91 [00:00<00:40,  2.20it/s]
Epoch 0:   1%|          | 1/91 [00:00<00:41,  2.19it/s, loss=nan]
Epoch 0:   2%|▏         | 2/91 [00:00<00:23,  3.85it/s, loss=nan][W reducer.cpp:1158] Warning: find_unused_parameters=True was specified in DDP constructor, but did not find any unused parameters in the forward pass. This flag results in an extra traversal of the autograd graph every iteration,  which can adversely affect performance. If your model indeed never has any unused parameters in the forward pass, consider turning this flag off. Note that this warning may be a false positive if your model has flow control causing later iterations to have unused parameters. (function operator())
Epoch 0:   3%|▎         | 3/91 [00:00<00:18,  4.68it/s, loss=nan]
Epoch 0:   3%|▎         | 3/91 [00:00<00:18,  4.68it/s, loss=7.39]
Epoch 0:   4%|▍         | 4/91 [00:00<00:15,  5.77it/s, loss=7.39]
Epoch 0:   5%|▌         | 5/91 [00:00<00:12,  6.73it/s, loss=7.39]
Epoch 0:   5%|▌         | 5/91 [00:00<00:12,  6.72it/s, loss=7.39]
Epoch 0:   7%|▋         | 6/91 [00:00<00:12,  7.08it/s, loss=6.98]
Epoch 0:   8%|▊         | 7/91 [00:00<00:10,  7.78it/s, loss=6.98]
Epoch 0:   8%|▊         | 7/91 [00:00<00:10,  7.78it/s, loss=6.98]
Epoch 0:   9%|▉         | 8/91 [00:00<00:09,  8.43it/s, loss=6.98]
Epoch 0:  10%|▉         | 9/91 [00:01<00:10,  8.12it/s, loss=6.98]
Epoch 0:  10%|▉         | 9/91 [00:01<00:10,  8.12it/s, loss=7.12]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:27,  2.97it/s][A
Epoch 0:  12%|█▏        | 11/91 [00:01<00:10,  7.58it/s, loss=7.12]
Validating:  40%|████      | 33/82 [00:00<00:00, 97.31it/s][A
Epoch 0:  47%|████▋     | 43/91 [00:01<00:01, 27.73it/s, loss=7.12]
Epoch 0: 100%|██████████| 91/91 [00:10<00:00,  8.70it/s, loss=7.12]
                                                           [A
Epoch 0:   0%|          | 0/91 [00:00<?, ?it/s, loss=7.12]         
Epoch 1:   0%|          | 0/91 [00:00<?, ?it/s, loss=7.12]
Epoch 1:   1%|          | 1/91 [00:00<00:42,  2.12it/s, loss=7.12]
Epoch 1:   2%|▏         | 2/91 [00:00<00:23,  3.78it/s, loss=7.12]
Epoch 1:   3%|▎         | 3/91 [00:00<00:18,  4.69it/s, loss=7.04]
Epoch 1:   4%|▍         | 4/91 [00:00<00:15,  5.79it/s, loss=7.04]
Epoch 1:   5%|▌         | 5/91 [00:00<00:12,  6.75it/s, loss=7.04]
Epoch 1:   7%|▋         | 6/91 [00:00<00:12,  6.98it/s, loss=6.93]
Epoch 1:   8%|▊         | 7/91 [00:00<00:10,  7.68it/s, loss=6.93]
Epoch 1:   9%|▉         | 8/91 [00:00<00:09,  8.33it/s, loss=6.93]
Epoch 1:  10%|▉         | 9/91 [00:01<00:10,  8.00it/s, loss=6.79]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:31,  2.55it/s][A
Epoch 1:  35%|███▌      | 32/91 [00:01<00:02, 20.39it/s, loss=6.79]
Validating:  66%|██████▌   | 54/82 [00:00<00:00, 142.62it/s][A
Epoch 1:  99%|█████████▉| 90/91 [00:01<00:00, 53.90it/s, loss=6.79]
Epoch 1: 100%|██████████| 91/91 [00:12<00:00,  7.44it/s, loss=6.79]
                                                            [A
Epoch 1:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.79]         
Epoch 2:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.79]
Epoch 2:   1%|          | 1/91 [00:00<00:41,  2.17it/s, loss=6.79]
Epoch 2:   2%|▏         | 2/91 [00:00<00:22,  3.91it/s, loss=6.79]
Epoch 2:   3%|▎         | 3/91 [00:00<00:18,  4.84it/s, loss=6.63]
Epoch 2:   4%|▍         | 4/91 [00:00<00:14,  5.96it/s, loss=6.63]
Epoch 2:   5%|▌         | 5/91 [00:00<00:12,  6.94it/s, loss=6.63]
Epoch 2:   7%|▋         | 6/91 [00:00<00:11,  7.29it/s, loss=6.43]
Epoch 2:   8%|▊         | 7/91 [00:00<00:10,  8.01it/s, loss=6.43]
Epoch 2:   9%|▉         | 8/91 [00:00<00:09,  8.58it/s, loss=6.43]
Epoch 2:  10%|▉         | 9/91 [00:01<00:09,  8.26it/s, loss=6.21]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:31,  2.58it/s][A
Epoch 2:  64%|██████▎   | 58/91 [00:01<00:00, 37.07it/s, loss=6.21]
Validating:  73%|███████▎  | 60/82 [00:00<00:00, 160.36it/s][A
Epoch 2: 100%|██████████| 91/91 [00:12<00:00,  7.51it/s, loss=6.21]
                                                            [A
Epoch 2:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.21]         
Epoch 3:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.21]
Epoch 3:   1%|          | 1/91 [00:00<00:39,  2.25it/s, loss=6.21]
Epoch 3:   2%|▏         | 2/91 [00:00<00:22,  4.04it/s, loss=6.21]
Epoch 3:   3%|▎         | 3/91 [00:00<00:17,  4.95it/s, loss=5.96]
Epoch 3:   4%|▍         | 4/91 [00:00<00:14,  6.10it/s, loss=5.96]
Epoch 3:   5%|▌         | 5/91 [00:00<00:12,  7.05it/s, loss=5.96]
Epoch 3:   7%|▋         | 6/91 [00:00<00:11,  7.30it/s, loss=5.82]
Epoch 3:   8%|▊         | 7/91 [00:00<00:10,  8.01it/s, loss=5.82]
Epoch 3:   9%|▉         | 8/91 [00:00<00:09,  8.67it/s, loss=5.82]
Epoch 3:  10%|▉         | 9/91 [00:01<00:10,  8.20it/s, loss=5.61]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:21,  3.78it/s][A
Validating:   4%|▎         | 3/82 [00:00<00:08,  9.12it/s][A
Epoch 3:  64%|██████▎   | 58/91 [00:01<00:00, 37.31it/s, loss=5.61]
Validating:  78%|███████▊  | 64/82 [00:00<00:00, 203.99it/s][A
Epoch 3: 100%|██████████| 91/91 [00:10<00:00,  8.27it/s, loss=5.61]
                                                            [A
Epoch 3:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.61]         
Epoch 4:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.61]
Epoch 4:   1%|          | 1/91 [00:00<00:39,  2.25it/s, loss=5.61]
Epoch 4:   2%|▏         | 2/91 [00:00<00:21,  4.05it/s, loss=5.61]
Epoch 4:   3%|▎         | 3/91 [00:00<00:18,  4.89it/s, loss=5.39]
Epoch 4:   4%|▍         | 4/91 [00:00<00:14,  6.02it/s, loss=5.39]
Epoch 4:   5%|▌         | 5/91 [00:00<00:12,  7.01it/s, loss=5.39]
Epoch 4:   7%|▋         | 6/91 [00:00<00:11,  7.35it/s, loss=5.2] 
Epoch 4:   8%|▊         | 7/91 [00:00<00:10,  8.05it/s, loss=5.2]
Epoch 4:   9%|▉         | 8/91 [00:00<00:09,  8.72it/s, loss=5.2]
Epoch 4:  10%|▉         | 9/91 [00:01<00:09,  8.38it/s, loss=5.07]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:26,  3.02it/s][A
Validating:  46%|████▋     | 38/82 [00:00<00:00, 113.50it/s][A
Epoch 4:  64%|██████▎   | 58/91 [00:01<00:00, 37.97it/s, loss=5.07]
Epoch 4: 100%|██████████| 91/91 [00:09<00:00,  9.18it/s, loss=5.07]
                                                            [A
Epoch 4:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.07]         
Epoch 5:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.07]
Epoch 5:   1%|          | 1/91 [00:00<00:42,  2.12it/s, loss=5.07]
Epoch 5:   2%|▏         | 2/91 [00:00<00:23,  3.84it/s, loss=5.07]
Epoch 5:   3%|▎         | 3/91 [00:00<00:18,  4.72it/s, loss=4.9] 
Epoch 5:   4%|▍         | 4/91 [00:00<00:14,  5.80it/s, loss=4.9]
Epoch 5:   5%|▌         | 5/91 [00:00<00:12,  6.77it/s, loss=4.9]
Epoch 5:   7%|▋         | 6/91 [00:00<00:11,  7.13it/s, loss=4.76]
Epoch 5:   8%|▊         | 7/91 [00:00<00:10,  7.82it/s, loss=4.76]
Epoch 5:   9%|▉         | 8/91 [00:00<00:09,  8.47it/s, loss=4.76]
Epoch 5:  10%|▉         | 9/91 [00:01<00:10,  8.15it/s, loss=4.6] 
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:30,  2.67it/s][A
Epoch 5:  64%|██████▎   | 58/91 [00:01<00:00, 36.94it/s, loss=4.6]
Validating:  71%|███████   | 58/82 [00:00<00:00, 158.66it/s][A
Epoch 5: 100%|██████████| 91/91 [00:10<00:00,  8.43it/s, loss=4.6]
                                                            [A
Epoch 5:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.6]         
Epoch 6:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.6]
Epoch 6:   1%|          | 1/91 [00:00<00:42,  2.11it/s, loss=4.6]
Epoch 6:   2%|▏         | 2/91 [00:00<00:23,  3.80it/s, loss=4.6]
Epoch 6:   3%|▎         | 3/91 [00:00<00:18,  4.66it/s, loss=4.43]
Epoch 6:   4%|▍         | 4/91 [00:00<00:15,  5.75it/s, loss=4.43]
Epoch 6:   5%|▌         | 5/91 [00:00<00:12,  6.72it/s, loss=4.43]
Epoch 6:   7%|▋         | 6/91 [00:00<00:11,  7.09it/s, loss=4.28]
Epoch 6:   8%|▊         | 7/91 [00:00<00:10,  7.79it/s, loss=4.28]
Epoch 6:   9%|▉         | 8/91 [00:00<00:09,  8.44it/s, loss=4.28]
Epoch 6:  10%|▉         | 9/91 [00:01<00:10,  8.03it/s, loss=4.01]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:26,  3.05it/s][A
Validating:  26%|██▌       | 21/82 [00:00<00:00, 62.72it/s][A
Epoch 6:  64%|██████▎   | 58/91 [00:01<00:00, 36.28it/s, loss=4.01]
Epoch 6: 100%|██████████| 91/91 [00:13<00:00,  6.50it/s, loss=4.01]
                                                           [A
Epoch 6:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.01]         
Epoch 7:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.01]
Epoch 7:   1%|          | 1/91 [00:00<00:40,  2.22it/s, loss=4.01]
Epoch 7:   2%|▏         | 2/91 [00:00<00:22,  3.92it/s, loss=4.01]
Epoch 7:   3%|▎         | 3/91 [00:00<00:18,  4.79it/s, loss=3.75]
Epoch 7:   4%|▍         | 4/91 [00:00<00:14,  5.91it/s, loss=3.75]
Epoch 7:   5%|▌         | 5/91 [00:00<00:12,  6.89it/s, loss=3.75]
Epoch 7:   7%|▋         | 6/91 [00:00<00:11,  7.21it/s, loss=3.43]
Epoch 7:   8%|▊         | 7/91 [00:00<00:10,  7.92it/s, loss=3.43]
Epoch 7:   9%|▉         | 8/91 [00:00<00:09,  8.58it/s, loss=3.43]
Epoch 7:  10%|▉         | 9/91 [00:01<00:09,  8.23it/s, loss=3.16]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:30,  2.67it/s][A
Epoch 7:  64%|██████▎   | 58/91 [00:01<00:00, 37.45it/s, loss=3.16]
Validating:  78%|███████▊  | 64/82 [00:00<00:00, 175.09it/s][A
Epoch 7: 100%|██████████| 91/91 [00:12<00:00,  7.08it/s, loss=3.16]
                                                            [A
Epoch 7: 100%|██████████| 91/91 [00:13<00:00,  6.78it/s, loss=3.16]
