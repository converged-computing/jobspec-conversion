#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=4
#FLUX: --queue=gpu-a40
#FLUX: -t=39600
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/situatedqa/evaluation/t5_baseline_yearly.json--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_182048-kf9l30s0
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run baseline_2018-
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/kf9l30s0
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/situatedqabaseline_2018- exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
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
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': None, 'adapter_hidden_size': None, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=None, adapter_list=None, check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/situatedqabaseline_2018-/epoch=70-f1_score=0.975-em_score=0.962.ckpt', dataset='situatedqa', dataset_version='2018-', early_stop_callback=False, eval_batch_size=64, freeze_embeds=False, freeze_encoder=False, freeze_level=0, learning_rate=1e-05, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='baseline', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=80, num_workers=4, opt_level='O1', output_dir='outputs/situatedqabaseline_2018-', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=64, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2018-', wandb_log=True, warmup_steps=0, weight_decay=0.0)
Not freezing any parameters!
split is 0
Length of dataset retrieving is.. 1683
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/27 [00:00<?, ?it/s]
Validating:   4%|▎         | 1/27 [00:02<01:07,  2.61s/it]
Validating:   7%|▋         | 2/27 [00:03<00:46,  1.87s/it]
Validating:  11%|█         | 3/27 [00:05<00:38,  1.59s/it]
Validating:  15%|█▍        | 4/27 [00:06<00:32,  1.40s/it]
Validating:  19%|█▊        | 5/27 [00:07<00:28,  1.31s/it]
Validating:  22%|██▏       | 6/27 [00:08<00:26,  1.27s/it]
Validating:  26%|██▌       | 7/27 [00:10<00:26,  1.30s/it]
Validating:  30%|██▉       | 8/27 [00:11<00:24,  1.28s/it]
Validating:  33%|███▎      | 9/27 [00:12<00:21,  1.22s/it]
Validating:  37%|███▋      | 10/27 [00:13<00:20,  1.19s/it]
Validating:  41%|████      | 11/27 [00:14<00:18,  1.19s/it]
Validating:  44%|████▍     | 12/27 [00:16<00:18,  1.25s/it]
Validating:  48%|████▊     | 13/27 [00:17<00:17,  1.22s/it]
Validating:  52%|█████▏    | 14/27 [00:18<00:15,  1.18s/it]
Validating:  56%|█████▌    | 15/27 [00:19<00:14,  1.18s/it]
Validating:  59%|█████▉    | 16/27 [00:20<00:13,  1.24s/it]
Validating:  63%|██████▎   | 17/27 [00:22<00:12,  1.22s/it]
Validating:  67%|██████▋   | 18/27 [00:23<00:10,  1.20s/it]
Validating:  70%|███████   | 19/27 [00:24<00:09,  1.21s/it]
Validating:  74%|███████▍  | 20/27 [00:25<00:08,  1.20s/it]
Validating:  78%|███████▊  | 21/27 [00:26<00:07,  1.21s/it]
Validating:  81%|████████▏ | 22/27 [00:28<00:06,  1.23s/it]
Validating:  85%|████████▌ | 23/27 [00:29<00:04,  1.25s/it]
Validating:  89%|████████▉ | 24/27 [00:30<00:03,  1.23s/it]
Validating:  93%|█████████▎| 25/27 [00:31<00:02,  1.21s/it]
Validating:  96%|█████████▋| 26/27 [00:32<00:01,  1.20s/it]
Validating: 100%|██████████| 27/27 [00:33<00:00,  1.05it/s]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.17944146692752838, 'f1_score': 0.21311511099338531}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.191 MB of 0.380 MB uploaded (0.000 MB deduped)
wandb: \ 0.380 MB of 0.380 MB uploaded (0.000 MB deduped)
wandb: | 0.380 MB of 0.380 MB uploaded (0.000 MB deduped)
wandb: / 0.380 MB of 0.392 MB uploaded (0.000 MB deduped)
wandb: - 0.381 MB of 0.392 MB uploaded (0.000 MB deduped)
wandb: \ 0.392 MB of 0.392 MB uploaded (0.000 MB deduped)
wandb: | 0.392 MB of 0.392 MB uploaded (0.000 MB deduped)
wandb: / 0.392 MB of 0.392 MB uploaded (0.000 MB deduped)
wandb: - 0.392 MB of 0.392 MB uploaded (0.000 MB deduped)
wandb: \ 0.392 MB of 0.392 MB uploaded (0.000 MB deduped)
wandb: | 0.392 MB of 0.392 MB uploaded (0.000 MB deduped)
wandb: / 0.392 MB of 0.392 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: 
wandb: Run history:
wandb:            em_score ▁
wandb:               epoch ▁
wandb:            f1_score ▁
wandb: trainer/global_step ▁
wandb: 
wandb: Run summary:
wandb:               epoch 0
wandb: trainer/global_step 0
wandb: 
wandb: Synced baseline_2018-: https://wandb.ai/tjung2/temporal_questions/runs/kf9l30s0
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_182048-kf9l30s0/logs
