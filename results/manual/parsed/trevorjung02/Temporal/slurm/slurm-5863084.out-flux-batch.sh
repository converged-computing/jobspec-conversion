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
python run.py --config configs/templama/evaluation/t5_baseline.json
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
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
Not freezing any parameters!
wandb: wandb version 0.13.1 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.12.21
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220811_183105-3p5q9qb6
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run T5_small_templama(full)_lr.001_baseline
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions_evaluation
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions_evaluation/runs/3p5q9qb6
split is 0
Length of dataset retrieving is.. 5037
Validating: 0it [00:00, ?it/s]
Validating:   0% 0/158 [00:00<?, ?it/s]
Validating:   1% 1/158 [00:00<02:13,  1.17it/s]
Validating:   1% 2/158 [00:01<01:34,  1.64it/s]
Validating:   2% 3/158 [00:01<01:10,  2.19it/s]
Validating:   3% 4/158 [00:01<00:58,  2.63it/s]
Validating:   3% 5/158 [00:02<00:57,  2.67it/s]
Validating:   4% 6/158 [00:02<00:57,  2.65it/s]
Validating:   4% 7/158 [00:02<00:50,  2.98it/s]
Validating:   5% 8/158 [00:03<00:44,  3.36it/s]
Validating:   6% 9/158 [00:03<00:43,  3.44it/s]
Validating:   6% 10/158 [00:03<00:42,  3.46it/s]
Validating:   7% 11/158 [00:03<00:40,  3.61it/s]
Validating:   8% 12/158 [00:04<00:42,  3.42it/s]
Validating:   8% 13/158 [00:04<00:43,  3.32it/s]
Validating:   9% 14/158 [00:04<00:42,  3.36it/s]
Validating:   9% 15/158 [00:05<00:45,  3.13it/s]
Validating:  10% 16/158 [00:05<00:42,  3.33it/s]
Validating:  11% 17/158 [00:05<00:39,  3.60it/s]
Validating:  11% 18/158 [00:05<00:41,  3.39it/s]
Validating:  12% 19/158 [00:06<00:40,  3.47it/s]
Validating:  13% 20/158 [00:06<00:38,  3.55it/s]
Validating:  13% 21/158 [00:06<00:38,  3.58it/s]
Validating:  14% 22/158 [00:07<00:37,  3.63it/s]
Validating:  15% 23/158 [00:07<00:34,  3.91it/s]
Validating:  15% 24/158 [00:07<00:36,  3.72it/s]
Validating:  16% 25/158 [00:07<00:36,  3.67it/s]
Validating:  16% 26/158 [00:08<00:34,  3.78it/s]
Validating:  17% 27/158 [00:08<00:35,  3.69it/s]
Validating:  18% 28/158 [00:08<00:37,  3.50it/s]
Validating:  18% 29/158 [00:09<00:39,  3.26it/s]
Validating:  19% 30/158 [00:09<00:37,  3.40it/s]
Validating:  20% 31/158 [00:09<00:38,  3.27it/s]
Validating:  20% 32/158 [00:09<00:37,  3.33it/s]
Validating:  21% 33/158 [00:10<00:36,  3.45it/s]
Validating:  22% 34/158 [00:10<00:35,  3.54it/s]
Validating:  22% 35/158 [00:10<00:35,  3.42it/s]
Validating:  23% 36/158 [00:11<00:34,  3.54it/s]
Validating:  23% 37/158 [00:11<00:33,  3.66it/s]
Validating:  24% 38/158 [00:11<00:30,  3.92it/s]
Validating:  25% 39/158 [00:11<00:31,  3.75it/s]
Validating:  25% 40/158 [00:12<00:30,  3.81it/s]
Validating:  26% 41/158 [00:12<00:30,  3.84it/s]
Validating:  27% 42/158 [00:12<00:29,  3.98it/s]
Validating:  27% 43/158 [00:12<00:28,  4.11it/s]
Validating:  28% 44/158 [00:13<00:30,  3.74it/s]
Validating:  28% 45/158 [00:13<00:30,  3.75it/s]
Validating:  29% 46/158 [00:13<00:31,  3.54it/s]
Validating:  30% 47/158 [00:14<00:33,  3.36it/s]
Validating:  30% 48/158 [00:14<00:32,  3.41it/s]
Validating:  31% 49/158 [00:14<00:30,  3.52it/s]
Validating:  32% 50/158 [00:14<00:31,  3.42it/s]
Validating:  32% 51/158 [00:15<00:31,  3.37it/s]
Validating:  33% 52/158 [00:15<00:30,  3.43it/s]
Validating:  34% 53/158 [00:15<00:31,  3.36it/s]
Validating:  34% 54/158 [00:16<00:30,  3.37it/s]
Validating:  35% 55/158 [00:16<00:30,  3.41it/s]
Validating:  35% 56/158 [00:16<00:30,  3.29it/s]
Validating:  36% 57/158 [00:16<00:30,  3.29it/s]
Validating:  37% 58/158 [00:17<00:30,  3.26it/s]
Validating:  37% 59/158 [00:17<00:28,  3.48it/s]
Validating:  38% 60/158 [00:17<00:27,  3.56it/s]
Validating:  39% 61/158 [00:18<00:29,  3.26it/s]
Validating:  39% 62/158 [00:18<00:29,  3.31it/s]
Validating:  40% 63/158 [00:18<00:28,  3.31it/s]
Validating:  41% 64/158 [00:19<00:27,  3.37it/s]
Validating:  41% 65/158 [00:19<00:26,  3.46it/s]
Validating:  42% 66/158 [00:19<00:26,  3.46it/s]
Validating:  42% 67/158 [00:19<00:26,  3.39it/s]
Validating:  43% 68/158 [00:20<00:26,  3.36it/s]
Validating:  44% 69/158 [00:20<00:24,  3.58it/s]
Validating:  44% 70/158 [00:20<00:22,  3.84it/s]
Validating:  45% 71/158 [00:21<00:24,  3.52it/s]
Validating:  46% 72/158 [00:21<00:23,  3.65it/s]
Validating:  46% 73/158 [00:21<00:23,  3.66it/s]
Validating:  47% 74/158 [00:21<00:23,  3.64it/s]
Validating:  47% 75/158 [00:22<00:21,  3.88it/s]
Validating:  48% 76/158 [00:22<00:22,  3.68it/s]
Validating:  49% 77/158 [00:22<00:20,  3.98it/s]
Validating:  49% 78/158 [00:22<00:19,  4.10it/s]
Validating:  50% 79/158 [00:23<00:19,  4.09it/s]
Validating:  51% 80/158 [00:23<00:18,  4.14it/s]
Validating:  51% 81/158 [00:23<00:20,  3.82it/s]
Validating:  52% 82/158 [00:23<00:19,  3.86it/s]
Validating:  53% 83/158 [00:24<00:19,  3.78it/s]
Validating:  53% 84/158 [00:24<00:19,  3.77it/s]
Validating:  54% 85/158 [00:24<00:20,  3.60it/s]
Validating:  54% 86/158 [00:24<00:18,  3.89it/s]
Validating:  55% 87/158 [00:25<00:19,  3.72it/s]
Validating:  56% 88/158 [00:25<00:18,  3.87it/s]
Validating:  56% 89/158 [00:25<00:19,  3.59it/s]
Validating:  57% 90/158 [00:25<00:18,  3.76it/s]
Validating:  58% 91/158 [00:26<00:16,  3.96it/s]
Validating:  58% 92/158 [00:26<00:17,  3.72it/s]
Validating:  59% 93/158 [00:26<00:16,  4.01it/s]
Validating:  59% 94/158 [00:26<00:16,  3.79it/s]
Validating:  60% 95/158 [00:27<00:17,  3.66it/s]
Validating:  61% 96/158 [00:27<00:17,  3.52it/s]
Validating:  61% 97/158 [00:27<00:18,  3.39it/s]
Validating:  62% 98/158 [00:28<00:16,  3.58it/s]
Validating:  63% 99/158 [00:28<00:15,  3.70it/s]
Validating:  63% 100/158 [00:28<00:15,  3.65it/s]
Validating:  64% 101/158 [00:28<00:15,  3.64it/s]
Validating:  65% 102/158 [00:29<00:15,  3.72it/s]
Validating:  65% 103/158 [00:29<00:17,  3.23it/s]
Validating:  66% 104/158 [00:29<00:15,  3.38it/s]
Validating:  66% 105/158 [00:30<00:14,  3.57it/s]
Validating:  67% 106/158 [00:30<00:13,  3.77it/s]
Validating:  68% 107/158 [00:30<00:12,  4.04it/s]
Validating:  68% 108/158 [00:30<00:11,  4.21it/s]
Validating:  69% 109/158 [00:31<00:11,  4.28it/s]
Validating:  70% 110/158 [00:31<00:11,  4.08it/s]
Validating:  70% 111/158 [00:31<00:10,  4.28it/s]
Validating:  71% 112/158 [00:31<00:11,  4.01it/s]
Validating:  72% 113/158 [00:32<00:11,  3.95it/s]
Validating:  72% 114/158 [00:32<00:11,  3.99it/s]
Validating:  73% 115/158 [00:32<00:10,  3.98it/s]
Validating:  73% 116/158 [00:32<00:11,  3.69it/s]
Validating:  74% 117/158 [00:33<00:11,  3.51it/s]
Validating:  75% 118/158 [00:33<00:10,  3.65it/s]
Validating:  75% 119/158 [00:33<00:09,  3.90it/s]
Validating:  76% 120/158 [00:33<00:09,  3.83it/s]
Validating:  77% 121/158 [00:34<00:10,  3.51it/s]
Validating:  77% 122/158 [00:34<00:10,  3.36it/s]
Validating:  78% 123/158 [00:34<00:10,  3.26it/s]
Validating:  78% 124/158 [00:35<00:10,  3.35it/s]
Validating:  79% 125/158 [00:35<00:09,  3.39it/s]
Validating:  80% 126/158 [00:35<00:09,  3.54it/s]
Validating:  80% 127/158 [00:35<00:08,  3.66it/s]
Validating:  81% 128/158 [00:36<00:08,  3.74it/s]
Validating:  82% 129/158 [00:36<00:07,  3.86it/s]
Validating:  82% 130/158 [00:36<00:07,  3.99it/s]
Validating:  83% 131/158 [00:36<00:07,  3.85it/s]
Validating:  84% 132/158 [00:37<00:07,  3.49it/s]
Validating:  84% 133/158 [00:37<00:07,  3.51it/s]
Validating:  85% 134/158 [00:37<00:06,  3.62it/s]
Validating:  85% 135/158 [00:38<00:06,  3.65it/s]
Validating:  86% 136/158 [00:38<00:05,  3.68it/s]
Validating:  87% 137/158 [00:38<00:05,  3.61it/s]
Validating:  87% 138/158 [00:38<00:05,  3.80it/s]
Validating:  88% 139/158 [00:39<00:04,  3.92it/s]
Validating:  89% 140/158 [00:39<00:04,  3.89it/s]
Validating:  89% 141/158 [00:39<00:04,  3.52it/s]
Validating:  90% 142/158 [00:40<00:04,  3.59it/s]
Validating:  91% 143/158 [00:40<00:04,  3.66it/s]
Validating:  91% 144/158 [00:40<00:03,  3.54it/s]
Validating:  92% 145/158 [00:40<00:03,  3.44it/s]
Validating:  92% 146/158 [00:41<00:03,  3.53it/s]
Validating:  93% 147/158 [00:41<00:03,  3.50it/s]
Validating:  94% 148/158 [00:41<00:02,  3.60it/s]
Validating:  94% 149/158 [00:41<00:02,  3.68it/s]
Validating:  95% 150/158 [00:42<00:02,  3.63it/s]
Validating:  96% 151/158 [00:42<00:01,  3.52it/s]
Validating:  96% 152/158 [00:42<00:01,  3.85it/s]
Validating:  97% 153/158 [00:43<00:01,  3.66it/s]
Validating:  97% 154/158 [00:43<00:01,  3.73it/s]
Validating:  98% 155/158 [00:43<00:00,  3.79it/s]
Validating:  99% 156/158 [00:43<00:00,  3.84it/s]
Validating:  99% 157/158 [00:44<00:00,  3.76it/s]
Validating: 100% 158/158 [00:44<00:00,  4.24it/s]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.053206272423267365, 'f1_score': 0.16615329682826996}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: 
wandb: Run history:
wandb:            em_score ▁
wandb:               epoch ▁
wandb:            f1_score ▁
wandb: trainer/global_step ▁
wandb: 
wandb: Run summary:
wandb:            em_score 0.05321
wandb:               epoch 0
wandb:            f1_score 0.16615
wandb: trainer/global_step 0
wandb: 
wandb: Synced T5_small_templama(full)_lr.001_baseline: https://wandb.ai/tjung2/temporal_questions_evaluation/runs/3p5q9qb6
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220811_183105-3p5q9qb6/logs
