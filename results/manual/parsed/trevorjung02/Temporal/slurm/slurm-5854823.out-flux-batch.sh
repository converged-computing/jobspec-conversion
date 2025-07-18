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
Validation sanity check:  50%|█████     | 1/2 [00:00<00:00,  2.44it/s]em = 0.0
f1 = 0.02222222222222222
split is 0
Length of dataset retrieving is.. 49
Training: 0it [00:00, ?it/s]
Training:   0%|          | 0/91 [00:00<?, ?it/s]
Epoch 0:   0%|          | 0/91 [00:00<?, ?it/s] 
Epoch 0:   1%|          | 1/91 [00:00<00:44,  2.04it/s]
Epoch 0:   1%|          | 1/91 [00:00<00:44,  2.03it/s, loss=nan]
Epoch 0:   2%|▏         | 2/91 [00:00<00:24,  3.62it/s, loss=nan][W reducer.cpp:1158] Warning: find_unused_parameters=True was specified in DDP constructor, but did not find any unused parameters in the forward pass. This flag results in an extra traversal of the autograd graph every iteration,  which can adversely affect performance. If your model indeed never has any unused parameters in the forward pass, consider turning this flag off. Note that this warning may be a false positive if your model has flow control causing later iterations to have unused parameters. (function operator())
Epoch 0:   3%|▎         | 3/91 [00:00<00:19,  4.43it/s, loss=nan]
Epoch 0:   3%|▎         | 3/91 [00:00<00:19,  4.43it/s, loss=7.39]
Epoch 0:   4%|▍         | 4/91 [00:00<00:15,  5.49it/s, loss=7.39]
Epoch 0:   5%|▌         | 5/91 [00:00<00:13,  6.44it/s, loss=7.39]
Epoch 0:   7%|▋         | 6/91 [00:00<00:12,  6.72it/s, loss=7.39]
Epoch 0:   7%|▋         | 6/91 [00:00<00:12,  6.72it/s, loss=6.98]
Epoch 0:   8%|▊         | 7/91 [00:00<00:11,  7.39it/s, loss=6.98]
Epoch 0:   9%|▉         | 8/91 [00:00<00:10,  8.04it/s, loss=6.98]
Epoch 0:  10%|▉         | 9/91 [00:01<00:10,  7.77it/s, loss=6.98]
Epoch 0:  10%|▉         | 9/91 [00:01<00:10,  7.76it/s, loss=7.12]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:31,  2.59it/s][A
Epoch 0:  13%|█▎        | 12/91 [00:01<00:10,  7.72it/s, loss=7.12]
Validating:  76%|███████▌  | 62/82 [00:00<00:00, 166.67it/s][A
Epoch 0:  82%|████████▏ | 75/91 [00:01<00:00, 45.30it/s, loss=7.12]em = 0.012195121951219513
f1 = 0.048987611304684466
Epoch 0: 100%|██████████| 91/91 [00:10<00:00,  8.74it/s, loss=7.12]
                                                            [A
Epoch 0:   0%|          | 0/91 [00:00<?, ?it/s, loss=7.12]         
Epoch 1:   0%|          | 0/91 [00:00<?, ?it/s, loss=7.12]
Epoch 1:   1%|          | 1/91 [00:00<00:40,  2.21it/s, loss=7.12]
Epoch 1:   2%|▏         | 2/91 [00:00<00:22,  3.94it/s, loss=7.12]
Epoch 1:   3%|▎         | 3/91 [00:00<00:18,  4.86it/s, loss=7.04]
Epoch 1:   4%|▍         | 4/91 [00:00<00:14,  5.99it/s, loss=7.04]
Epoch 1:   5%|▌         | 5/91 [00:00<00:12,  6.97it/s, loss=7.04]
Epoch 1:   7%|▋         | 6/91 [00:00<00:11,  7.16it/s, loss=6.93]
Epoch 1:   8%|▊         | 7/91 [00:00<00:10,  7.85it/s, loss=6.93]
Epoch 1:   9%|▉         | 8/91 [00:00<00:09,  8.51it/s, loss=6.93]
Epoch 1:  10%|▉         | 9/91 [00:01<00:10,  8.09it/s, loss=6.79]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:30,  2.65it/s][A
Epoch 1:  69%|██████▉   | 63/91 [00:01<00:00, 39.65it/s, loss=6.79]
Validating:  71%|███████   | 58/82 [00:00<00:00, 157.79it/s][Aem = 0.00975609756097561
f1 = 0.07860451201914612
Epoch 1: 100%|██████████| 91/91 [00:12<00:00,  7.38it/s, loss=6.79]
                                                            [A
Epoch 1:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.79]         
Epoch 2:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.79]
Epoch 2:   1%|          | 1/91 [00:00<00:40,  2.20it/s, loss=6.79]
Epoch 2:   2%|▏         | 2/91 [00:00<00:22,  3.92it/s, loss=6.79]
Epoch 2:   3%|▎         | 3/91 [00:00<00:18,  4.86it/s, loss=6.63]
Epoch 2:   4%|▍         | 4/91 [00:00<00:14,  5.97it/s, loss=6.63]
Epoch 2:   5%|▌         | 5/91 [00:00<00:12,  6.95it/s, loss=6.63]
Epoch 2:   7%|▋         | 6/91 [00:00<00:11,  7.26it/s, loss=6.43]
Epoch 2:   8%|▊         | 7/91 [00:00<00:10,  7.86it/s, loss=6.43]
Epoch 2:   9%|▉         | 8/91 [00:00<00:09,  8.49it/s, loss=6.43]
Epoch 2:  10%|▉         | 9/91 [00:01<00:10,  8.14it/s, loss=6.21]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:32,  2.46it/s][A
Epoch 2:  69%|██████▉   | 63/91 [00:01<00:00, 39.41it/s, loss=6.21]
Validating:  79%|███████▉  | 65/82 [00:00<00:00, 168.15it/s][Aem = 0.0024390243902439024
f1 = 0.07453389428999184
Epoch 2: 100%|██████████| 91/91 [00:12<00:00,  7.47it/s, loss=6.21]
                                                            [A
Epoch 2:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.21]         
Epoch 3:   0%|          | 0/91 [00:00<?, ?it/s, loss=6.21]
Epoch 3:   1%|          | 1/91 [00:00<00:41,  2.19it/s, loss=6.21]
Epoch 3:   2%|▏         | 2/91 [00:00<00:22,  3.95it/s, loss=6.21]
Epoch 3:   3%|▎         | 3/91 [00:00<00:17,  4.89it/s, loss=5.96]
Epoch 3:   4%|▍         | 4/91 [00:00<00:14,  5.91it/s, loss=5.96]
Epoch 3:   5%|▌         | 5/91 [00:00<00:12,  6.87it/s, loss=5.96]
Epoch 3:   7%|▋         | 6/91 [00:00<00:11,  7.22it/s, loss=5.82]
Epoch 3:   8%|▊         | 7/91 [00:00<00:10,  7.92it/s, loss=5.82]
Epoch 3:   9%|▉         | 8/91 [00:00<00:09,  8.56it/s, loss=5.82]
Epoch 3:  10%|▉         | 9/91 [00:01<00:10,  8.16it/s, loss=5.61]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:31,  2.61it/s][A
Epoch 3:  69%|██████▉   | 63/91 [00:01<00:00, 39.91it/s, loss=5.61]
Validating:  76%|███████▌  | 62/82 [00:00<00:00, 167.11it/s][Aem = 0.007317073170731708
f1 = 0.06807646283256037
Epoch 3: 100%|██████████| 91/91 [00:10<00:00,  8.35it/s, loss=5.61]
                                                            [A
Epoch 3:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.61]         
Epoch 4:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.61]
Epoch 4:   1%|          | 1/91 [00:00<00:39,  2.27it/s, loss=5.61]
Epoch 4:   2%|▏         | 2/91 [00:00<00:21,  4.10it/s, loss=5.61]
Epoch 4:   3%|▎         | 3/91 [00:00<00:17,  4.96it/s, loss=5.39]
Epoch 4:   4%|▍         | 4/91 [00:00<00:14,  6.09it/s, loss=5.39]
Epoch 4:   5%|▌         | 5/91 [00:00<00:12,  7.09it/s, loss=5.39]
Epoch 4:   7%|▋         | 6/91 [00:00<00:11,  7.42it/s, loss=5.2] 
Epoch 4:   8%|▊         | 7/91 [00:00<00:10,  8.12it/s, loss=5.2]
Epoch 4:   9%|▉         | 8/91 [00:00<00:09,  8.78it/s, loss=5.2]
Epoch 4:  10%|▉         | 9/91 [00:01<00:09,  8.36it/s, loss=5.07]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:32,  2.48it/s][A
Epoch 4:  69%|██████▉   | 63/91 [00:01<00:00, 40.12it/s, loss=5.07]
Validating:  77%|███████▋  | 63/82 [00:00<00:00, 163.77it/s][Aem = 0.0024390243902439024
f1 = 0.06847240835045712
Epoch 4: 100%|██████████| 91/91 [00:10<00:00,  9.04it/s, loss=5.07]
                                                            [A
Epoch 4:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.07]         
Epoch 5:   0%|          | 0/91 [00:00<?, ?it/s, loss=5.07]
Epoch 5:   1%|          | 1/91 [00:00<00:42,  2.10it/s, loss=5.07]
Epoch 5:   2%|▏         | 2/91 [00:00<00:23,  3.80it/s, loss=5.07]
Epoch 5:   3%|▎         | 3/91 [00:00<00:18,  4.74it/s, loss=4.9] 
Epoch 5:   4%|▍         | 4/91 [00:00<00:14,  5.85it/s, loss=4.9]
Epoch 5:   5%|▌         | 5/91 [00:00<00:12,  6.79it/s, loss=4.9]
Epoch 5:   7%|▋         | 6/91 [00:00<00:12,  7.01it/s, loss=4.76]
Epoch 5:   8%|▊         | 7/91 [00:00<00:10,  7.71it/s, loss=4.76]
Epoch 5:   9%|▉         | 8/91 [00:00<00:09,  8.37it/s, loss=4.76]
Epoch 5:  10%|▉         | 9/91 [00:01<00:10,  7.95it/s, loss=4.6] 
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:30,  2.62it/s][A
Epoch 5:  69%|██████▉   | 63/91 [00:01<00:00, 39.12it/s, loss=4.6]
Validating:  71%|███████   | 58/82 [00:00<00:00, 157.07it/s][Aem = 0.00975609756097561
f1 = 0.10022459924898944
Epoch 5: 100%|██████████| 91/91 [00:10<00:00,  8.41it/s, loss=4.6]
                                                            [A
Epoch 5:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.6]         
Epoch 6:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.6]
Epoch 6:   1%|          | 1/91 [00:00<00:42,  2.10it/s, loss=4.6]
Epoch 6:   2%|▏         | 2/91 [00:00<00:23,  3.80it/s, loss=4.6]
Epoch 6:   3%|▎         | 3/91 [00:00<00:18,  4.71it/s, loss=4.43]
Epoch 6:   4%|▍         | 4/91 [00:00<00:14,  5.81it/s, loss=4.43]
Epoch 6:   5%|▌         | 5/91 [00:00<00:12,  6.78it/s, loss=4.43]
Epoch 6:   7%|▋         | 6/91 [00:00<00:11,  7.09it/s, loss=4.28]
Epoch 6:   8%|▊         | 7/91 [00:00<00:10,  7.74it/s, loss=4.28]
Epoch 6:   9%|▉         | 8/91 [00:00<00:09,  8.39it/s, loss=4.28]
Epoch 6:  10%|▉         | 9/91 [00:01<00:10,  7.96it/s, loss=4.01]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:33,  2.42it/s][A
Epoch 6:  69%|██████▉   | 63/91 [00:01<00:00, 38.57it/s, loss=4.01]
Validating:  79%|███████▉  | 65/82 [00:00<00:00, 165.72it/s][Aem = 0.01951219512195122
f1 = 0.08126825748776964
Epoch 6: 100%|██████████| 91/91 [00:14<00:00,  6.49it/s, loss=4.01]
                                                            [A
Epoch 6:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.01]         
Epoch 7:   0%|          | 0/91 [00:00<?, ?it/s, loss=4.01]
Epoch 7:   1%|          | 1/91 [00:00<00:42,  2.10it/s, loss=4.01]
Epoch 7:   2%|▏         | 2/91 [00:00<00:23,  3.78it/s, loss=4.01]
Epoch 7:   3%|▎         | 3/91 [00:00<00:18,  4.71it/s, loss=3.75]
Epoch 7:   4%|▍         | 4/91 [00:00<00:14,  5.81it/s, loss=3.75]
Epoch 7:   5%|▌         | 5/91 [00:00<00:12,  6.78it/s, loss=3.75]
Epoch 7:   7%|▋         | 6/91 [00:00<00:11,  7.13it/s, loss=3.43]
Epoch 7:   8%|▊         | 7/91 [00:00<00:10,  7.83it/s, loss=3.43]
Epoch 7:   9%|▉         | 8/91 [00:00<00:09,  8.46it/s, loss=3.43]
Epoch 7:  10%|▉         | 9/91 [00:01<00:10,  8.13it/s, loss=3.16]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/82 [00:00<?, ?it/s][A
Validating:   1%|          | 1/82 [00:00<00:31,  2.58it/s][A
Epoch 7:  69%|██████▉   | 63/91 [00:01<00:00, 39.58it/s, loss=3.16]
Validating:  71%|███████   | 58/82 [00:00<00:00, 155.35it/s][Aem = 0.014634146341463415
f1 = 0.09153473897376331
Epoch 7: 100%|██████████| 91/91 [00:12<00:00,  7.15it/s, loss=3.16]
                                                            [A
Epoch 7: 100%|██████████| 91/91 [00:13<00:00,  6.86it/s, loss=3.16]
