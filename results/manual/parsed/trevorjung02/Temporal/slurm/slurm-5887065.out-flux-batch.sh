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
python run.py --config configs/templama/training/t5_baseline_2010_prefixed_test.json
--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220818_181853-3o93ldhj
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run T5_small_templama(2010)_lr.0001_baseline_prefixed
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions_1
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions_1/runs/3o93ldhj
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/T5_small_templama(2010)_lr.0001_baseline_prefixed exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
{'output_dir': 'outputs/T5_small_templama(2010)_lr.0001_baseline_prefixed', 'dataset': 'templama', 'dataset_version': '2010', 'prefix': True, 'split_num': 1, 'split': 0, 'model_name_or_path': 'google/t5-small-ssm', 'method': 'baseline', 'freeze_level': 0, 'mode': 'pretrain', 'tokenizer_name_or_path': 'google/t5-small-ssm', 'max_input_length': 50, 'max_output_length': 25, 'freeze_encoder': False, 'freeze_embeds': False, 'learning_rate': 0.0001, 'weight_decay': 0.0, 'adam_epsilon': 1e-08, 'warmup_steps': 0, 'train_batch_size': 64, 'eval_batch_size': 64, 'num_train_epochs': 30, 'n_gpu': 1, 'num_workers': 4, 'resume_from_checkpoint': None, 'use_lr_scheduling': True, 'val_check_interval': 1.0, 'n_val': -1, 'n_train': -1, 'n_test': -1, 'early_stop_callback': False, 'use_deepspeed': False, 'opt_level': 'O1', 'max_grad_norm': 0.5, 'seed': 42, 'check_validation_only': False, 'checkpoint_path': '', 'accelerator': 'ddp', 'output_log': None}
wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.000 MB of 0.000 MB uploaded (0.000 MB deduped)
wandb: \ 0.000 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: - 0.001 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.005 MB of 0.010 MB uploaded (0.000 MB deduped)
wandb: | 0.010 MB of 0.010 MB uploaded (0.000 MB deduped)
wandb: / 0.010 MB of 0.010 MB uploaded (0.000 MB deduped)
wandb: - 0.010 MB of 0.010 MB uploaded (0.000 MB deduped)
wandb: \ 0.010 MB of 0.010 MB uploaded (0.000 MB deduped)
wandb: | 0.010 MB of 0.010 MB uploaded (0.000 MB deduped)
wandb: / 0.010 MB of 0.010 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced T5_small_templama(2010)_lr.0001_baseline_prefixed: https://wandb.ai/tjung2/temporal_questions_1/runs/3o93ldhj
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220818_181853-3o93ldhj/logs
Traceback (most recent call last):
  File "run.py", line 166, in <module>
    model = Model(args)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 37, in __init__
    if hparams.method=='modular':
AttributeError: 'dict' object has no attribute 'method'
