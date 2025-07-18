#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=8
#FLUX: --queue=gpu-a40
#FLUX: -t=3600
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/debug.json
--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.4 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20221011_035423-1eu16hzd
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run baseline_debug
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/1eu16hzd
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/debugbaseline_debug exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
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
Restored states from the checkpoint file at outputs/debugbaseline_debug/epoch=0-f1_score=0.1111-em_score=0.0000-v1.ckpt
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': None, 'adapter_hidden_size': None, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=None, adapter_list=None, check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='templama', dataset_version='debug', early_stop_callback=False, eval_batch_size=1, find_lr=False, freeze_embeds=False, freeze_encoder=False, freeze_level=0, learning_rate=1e-05, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='baseline', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=1, num_workers=4, opt_level='O1', output_dir='outputs/debugbaseline_debug', output_log=None, pool_size=None, prefix=None, resume_from_checkpoint='outputs/debugbaseline_debug/epoch=0-f1_score=0.1111-em_score=0.0000-v1.ckpt', seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=1, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='debug', wandb_log=True, warmup_steps=0, weight_decay=0.0)
Not freezing any parameters!
hparams.learning_rate = 1e-05
split is 0
Length of dataset retrieving is.. 49
Index(['index', 'original', 'date', 'input', 'output'], dtype='object')
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 410
Index(['id', 'original', 'date', 'input', 'output'], dtype='object')
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]
Validation sanity check:  50%|█████     | 1/2 [00:00<00:00,  1.21it/s]
split is 0
Length of dataset retrieving is.. 49
Index(['index', 'original', 'date', 'input', 'output'], dtype='object')
Training: 0it [00:00, ?it/s]wandb: Waiting for W&B process to finish... (success).
wandb: - 0.002 MB of 0.002 MB uploaded (0.000 MB deduped)
wandb: \ 0.002 MB of 0.002 MB uploaded (0.000 MB deduped)
wandb: | 0.002 MB of 0.002 MB uploaded (0.000 MB deduped)
wandb: / 0.002 MB of 0.002 MB uploaded (0.000 MB deduped)
wandb: - 0.002 MB of 0.015 MB uploaded (0.000 MB deduped)
wandb: \ 0.002 MB of 0.015 MB uploaded (0.000 MB deduped)
wandb: | 0.015 MB of 0.015 MB uploaded (0.000 MB deduped)
wandb: / 0.015 MB of 0.015 MB uploaded (0.000 MB deduped)
wandb: - 0.015 MB of 0.015 MB uploaded (0.000 MB deduped)
wandb: \ 0.015 MB of 0.015 MB uploaded (0.000 MB deduped)
wandb: | 0.015 MB of 0.015 MB uploaded (0.000 MB deduped)
wandb: / 0.015 MB of 0.015 MB uploaded (0.000 MB deduped)
wandb: - 0.015 MB of 0.015 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced baseline_debug: https://wandb.ai/tjung2/temporal_questions/runs/1eu16hzd
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20221011_035423-1eu16hzd/logs
