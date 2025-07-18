#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=4
#FLUX: --queue=gpu-rtx6k
#FLUX: -t=39600
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/templama/evaluation/t5_kadapters_soft_full.json -val_data 2010
python run.py --config configs/templama/evaluation/t5_kadapters_soft_full.json -val_data 2011
python run.py --config configs/templama/evaluation/t5_kadapters_soft_full.json -val_data 2012
python run.py --config configs/templama/evaluation/t5_kadapters_soft_full.json -val_data 2013
python run.py --config configs/templama/evaluation/t5_kadapters_soft_full.json -val_data 2014
python run.py --config configs/templama/evaluation/t5_kadapters_soft_full.json -val_data 2015
python run.py --config configs/templama/evaluation/t5_kadapters_soft_full.json -val_data 2016
python run.py --config configs/templama/evaluation/t5_kadapters_soft_full.json -val_data 2017
python run.py --config configs/templama/evaluation/t5_kadapters_soft_full.json -val_data 2018
--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_040819-1avg87oy
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/1avg87oy
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_soft_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.down_project.bias', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.up_project.bias', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.5.up_project.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.8.down_project.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.pool.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.pool.bias', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.down_project.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.0.down_project.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/kadapter_soft_full_2freeze_158_128/epoch=15-f1_score=0.171-em_score=0.072.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=256, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=256, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2010', wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 128,
  "adapter_list": [
    1,
    5,
    8
  ],
  "architectures": [
    "T5ForConditionalGeneration"
  ],
  "d_ff": 1024,
  "d_kv": 64,
  "d_model": 512,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "gated-gelu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 8,
  "num_heads": 6,
  "num_layers": 8,
  "output_past": true,
  "pad_token_id": 0,
  "pool_size": 3,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 410
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/2 [00:00<?, ?it/s]
Validating:  50%|█████     | 1/2 [00:06<00:06,  6.60s/it]
Validating: 100%|██████████| 2/2 [00:10<00:00,  4.87s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.053658537566661835, 'f1_score': 0.167252779006958}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.047 MB of 0.092 MB uploaded (0.000 MB deduped)
wandb: \ 0.092 MB of 0.092 MB uploaded (0.000 MB deduped)
wandb: | 0.092 MB of 0.092 MB uploaded (0.000 MB deduped)
wandb: / 0.092 MB of 0.112 MB uploaded (0.000 MB deduped)
wandb: - 0.092 MB of 0.112 MB uploaded (0.000 MB deduped)
wandb: \ 0.112 MB of 0.112 MB uploaded (0.000 MB deduped)
wandb: | 0.112 MB of 0.112 MB uploaded (0.000 MB deduped)
wandb: / 0.112 MB of 0.112 MB uploaded (0.000 MB deduped)
wandb: - 0.112 MB of 0.112 MB uploaded (0.000 MB deduped)
wandb: \ 0.112 MB of 0.112 MB uploaded (0.000 MB deduped)
wandb: | 0.112 MB of 0.112 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/1avg87oy
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_040819-1avg87oy/logs
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_040955-1bpgwpem
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/1bpgwpem
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_soft_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.8.up_project.bias', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.up_project.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.pool.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.down_project.bias', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.pool.bias', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.down_project.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/kadapter_soft_full_2freeze_158_128/epoch=15-f1_score=0.171-em_score=0.072.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=256, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=256, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2011', wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 128,
  "adapter_list": [
    1,
    5,
    8
  ],
  "architectures": [
    "T5ForConditionalGeneration"
  ],
  "d_ff": 1024,
  "d_kv": 64,
  "d_model": 512,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "gated-gelu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 8,
  "num_heads": 6,
  "num_layers": 8,
  "output_past": true,
  "pad_token_id": 0,
  "pool_size": 3,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 431
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/2 [00:00<?, ?it/s]
Validating:  50%|█████     | 1/2 [00:06<00:06,  6.73s/it]
Validating: 100%|██████████| 2/2 [00:10<00:00,  5.11s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.05800464004278183, 'f1_score': 0.1624497026205063}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.049 MB of 0.096 MB uploaded (0.000 MB deduped)
wandb: \ 0.096 MB of 0.096 MB uploaded (0.000 MB deduped)
wandb: | 0.096 MB of 0.096 MB uploaded (0.000 MB deduped)
wandb: / 0.096 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: - 0.099 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: \ 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: | 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: / 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: - 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: \ 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: | 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/1bpgwpem
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_040955-1bpgwpem/logs
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_041119-127p00r8
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/127p00r8
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_soft_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.0.up_project.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.8.down_project.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.pool.weight', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.up_project.bias', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.pool.bias', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.0.down_project.bias', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.5.up_project.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/kadapter_soft_full_2freeze_158_128/epoch=15-f1_score=0.171-em_score=0.072.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=256, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=256, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2012', wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 128,
  "adapter_list": [
    1,
    5,
    8
  ],
  "architectures": [
    "T5ForConditionalGeneration"
  ],
  "d_ff": 1024,
  "d_kv": 64,
  "d_model": 512,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "gated-gelu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 8,
  "num_heads": 6,
  "num_layers": 8,
  "output_past": true,
  "pad_token_id": 0,
  "pool_size": 3,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 446
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/2 [00:00<?, ?it/s]
Validating:  50%|█████     | 1/2 [00:06<00:06,  6.87s/it]
Validating: 100%|██████████| 2/2 [00:11<00:00,  5.33s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.04932735487818718, 'f1_score': 0.1541154682636261}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.049 MB of 0.097 MB uploaded (0.000 MB deduped)
wandb: \ 0.097 MB of 0.097 MB uploaded (0.000 MB deduped)
wandb: | 0.097 MB of 0.097 MB uploaded (0.000 MB deduped)
wandb: / 0.097 MB of 0.097 MB uploaded (0.000 MB deduped)
wandb: - 0.097 MB of 0.117 MB uploaded (0.000 MB deduped)
wandb: \ 0.117 MB of 0.117 MB uploaded (0.000 MB deduped)
wandb: | 0.117 MB of 0.117 MB uploaded (0.000 MB deduped)
wandb: / 0.117 MB of 0.117 MB uploaded (0.000 MB deduped)
wandb: - 0.117 MB of 0.117 MB uploaded (0.000 MB deduped)
wandb: \ 0.117 MB of 0.117 MB uploaded (0.000 MB deduped)
wandb: | 0.117 MB of 0.117 MB uploaded (0.000 MB deduped)
wandb: / 0.117 MB of 0.117 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/127p00r8
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_041119-127p00r8/logs
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_041239-mo0b46rz
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/mo0b46rz
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_soft_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.up_project.weight', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.pool.bias', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.up_project.bias', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.down_project.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.down_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.up_project.bias', 'kadapter.pool.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/kadapter_soft_full_2freeze_158_128/epoch=15-f1_score=0.171-em_score=0.072.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=256, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=256, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2013', wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 128,
  "adapter_list": [
    1,
    5,
    8
  ],
  "architectures": [
    "T5ForConditionalGeneration"
  ],
  "d_ff": 1024,
  "d_kv": 64,
  "d_model": 512,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "gated-gelu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 8,
  "num_heads": 6,
  "num_layers": 8,
  "output_past": true,
  "pad_token_id": 0,
  "pool_size": 3,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 455
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/2 [00:00<?, ?it/s]
Validating:  50%|█████     | 1/2 [00:06<00:06,  6.96s/it]
Validating: 100%|██████████| 2/2 [00:11<00:00,  5.66s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.048351649194955826, 'f1_score': 0.14416734874248505}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.050 MB of 0.098 MB uploaded (0.000 MB deduped)
wandb: \ 0.050 MB of 0.098 MB uploaded (0.000 MB deduped)
wandb: | 0.098 MB of 0.098 MB uploaded (0.000 MB deduped)
wandb: / 0.098 MB of 0.098 MB uploaded (0.000 MB deduped)
wandb: - 0.098 MB of 0.118 MB uploaded (0.000 MB deduped)
wandb: \ 0.098 MB of 0.118 MB uploaded (0.000 MB deduped)
wandb: | 0.118 MB of 0.118 MB uploaded (0.000 MB deduped)
wandb: / 0.118 MB of 0.118 MB uploaded (0.000 MB deduped)
wandb: - 0.118 MB of 0.118 MB uploaded (0.000 MB deduped)
wandb: \ 0.118 MB of 0.118 MB uploaded (0.000 MB deduped)
wandb: | 0.118 MB of 0.118 MB uploaded (0.000 MB deduped)
wandb: / 0.118 MB of 0.118 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/mo0b46rz
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_041239-mo0b46rz/logs
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_041409-19uqy8v4
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/19uqy8v4
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_soft_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.pool.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.8.up_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.down_project.bias', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.pool.bias', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.up_project.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.down_project.bias', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.3.down_project.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.down_project.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/kadapter_soft_full_2freeze_158_128/epoch=15-f1_score=0.171-em_score=0.072.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=256, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=256, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2014', wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 128,
  "adapter_list": [
    1,
    5,
    8
  ],
  "architectures": [
    "T5ForConditionalGeneration"
  ],
  "d_ff": 1024,
  "d_kv": 64,
  "d_model": 512,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "gated-gelu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 8,
  "num_heads": 6,
  "num_layers": 8,
  "output_past": true,
  "pad_token_id": 0,
  "pool_size": 3,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 469
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/2 [00:00<?, ?it/s]
Validating:  50%|█████     | 1/2 [00:06<00:06,  6.37s/it]
Validating: 100%|██████████| 2/2 [00:11<00:00,  5.57s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.04051172733306885, 'f1_score': 0.13593709468841553}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.051 MB of 0.101 MB uploaded (0.000 MB deduped)
wandb: \ 0.101 MB of 0.101 MB uploaded (0.000 MB deduped)
wandb: | 0.101 MB of 0.101 MB uploaded (0.000 MB deduped)
wandb: / 0.101 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: - 0.101 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: \ 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: | 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: / 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: - 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: \ 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: | 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: / 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: - 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: \ 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: | 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: / 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: - 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: \ 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: | 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: / 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: - 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/19uqy8v4
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_041409-19uqy8v4/logs
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_041531-1rd4je9z
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/1rd4je9z
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_soft_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.pool.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.0.down_project.bias', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.pool.bias', 'kadapter.adapters.8.up_project.bias', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.down_project.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.up_project.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.7.up_project.bias']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/kadapter_soft_full_2freeze_158_128/epoch=15-f1_score=0.171-em_score=0.072.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=256, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=256, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2015', wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 128,
  "adapter_list": [
    1,
    5,
    8
  ],
  "architectures": [
    "T5ForConditionalGeneration"
  ],
  "d_ff": 1024,
  "d_kv": 64,
  "d_model": 512,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "gated-gelu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 8,
  "num_heads": 6,
  "num_layers": 8,
  "output_past": true,
  "pad_token_id": 0,
  "pool_size": 3,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 479
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/2 [00:00<?, ?it/s]
Validating:  50%|█████     | 1/2 [00:06<00:06,  6.54s/it]
Validating: 100%|██████████| 2/2 [00:11<00:00,  5.82s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.04384133592247963, 'f1_score': 0.13423243165016174}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.052 MB of 0.102 MB uploaded (0.000 MB deduped)
wandb: \ 0.102 MB of 0.102 MB uploaded (0.000 MB deduped)
wandb: | 0.102 MB of 0.102 MB uploaded (0.000 MB deduped)
wandb: / 0.102 MB of 0.112 MB uploaded (0.000 MB deduped)
wandb: - 0.120 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: \ 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: | 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: / 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: - 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: \ 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: | 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/1rd4je9z
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_041531-1rd4je9z/logs
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_041651-1s852i2r
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/1s852i2r
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_soft_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.pool.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.up_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.8.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.pool.bias', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.8.up_project.bias', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.down_project.bias']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/kadapter_soft_full_2freeze_158_128/epoch=15-f1_score=0.171-em_score=0.072.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=256, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=256, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2016', wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 128,
  "adapter_list": [
    1,
    5,
    8
  ],
  "architectures": [
    "T5ForConditionalGeneration"
  ],
  "d_ff": 1024,
  "d_kv": 64,
  "d_model": 512,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "gated-gelu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 8,
  "num_heads": 6,
  "num_layers": 8,
  "output_past": true,
  "pad_token_id": 0,
  "pool_size": 3,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 480
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/2 [00:00<?, ?it/s]
Validating:  50%|█████     | 1/2 [00:06<00:06,  6.30s/it]
Validating: 100%|██████████| 2/2 [00:11<00:00,  5.69s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.04791666567325592, 'f1_score': 0.13662391901016235}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.051 MB of 0.101 MB uploaded (0.000 MB deduped)
wandb: \ 0.101 MB of 0.101 MB uploaded (0.000 MB deduped)
wandb: | 0.101 MB of 0.101 MB uploaded (0.000 MB deduped)
wandb: / 0.101 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: - 0.105 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: \ 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: | 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: / 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: - 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: \ 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: | 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
wandb: / 0.121 MB of 0.121 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/1s852i2r
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_041651-1s852i2r/logs
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_041817-1nrh5bek
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/1nrh5bek
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_soft_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.4.down_project.bias', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.8.down_project.weight', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.pool.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.0.down_project.bias', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.8.up_project.bias', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.pool.bias', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.up_project.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/kadapter_soft_full_2freeze_158_128/epoch=15-f1_score=0.171-em_score=0.072.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=256, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=256, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2017', wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 128,
  "adapter_list": [
    1,
    5,
    8
  ],
  "architectures": [
    "T5ForConditionalGeneration"
  ],
  "d_ff": 1024,
  "d_kv": 64,
  "d_model": 512,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "gated-gelu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 8,
  "num_heads": 6,
  "num_layers": 8,
  "output_past": true,
  "pad_token_id": 0,
  "pool_size": 3,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 481
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/2 [00:00<?, ?it/s]
Validating:  50%|█████     | 1/2 [00:07<00:07,  7.04s/it]
Validating: 100%|██████████| 2/2 [00:12<00:00,  6.05s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.04781704768538475, 'f1_score': 0.1408212035894394}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.052 MB of 0.102 MB uploaded (0.000 MB deduped)
wandb: \ 0.102 MB of 0.102 MB uploaded (0.000 MB deduped)
wandb: | 0.102 MB of 0.102 MB uploaded (0.000 MB deduped)
wandb: / 0.102 MB of 0.111 MB uploaded (0.000 MB deduped)
wandb: - 0.106 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: \ 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: | 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: / 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: - 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: \ 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
wandb: | 0.122 MB of 0.122 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/1nrh5bek
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_041817-1nrh5bek/logs
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_041940-38ffq7m8
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/38ffq7m8
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_soft_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.6.down_project.bias', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.year_embeds.2.weight', 'kadapter.pool.bias', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.8.down_project.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.pool.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.2.up_project.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.0.down_project.bias', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.5.up_project.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.2.down_project.bias', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.8.up_project.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.8.up_project.bias', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/kadapter_soft_full_2freeze_158_128/epoch=15-f1_score=0.171-em_score=0.072.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=256, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=256, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2018', wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 128,
  "adapter_list": [
    1,
    5,
    8
  ],
  "architectures": [
    "T5ForConditionalGeneration"
  ],
  "d_ff": 1024,
  "d_kv": 64,
  "d_model": 512,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "gated-gelu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 8,
  "num_heads": 6,
  "num_layers": 8,
  "output_past": true,
  "pad_token_id": 0,
  "pool_size": 3,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 473
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/2 [00:00<?, ?it/s]
Validating:  50%|█████     | 1/2 [00:07<00:07,  7.17s/it]
Validating: 100%|██████████| 2/2 [00:12<00:00,  6.00s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.05285412445664406, 'f1_score': 0.14013051986694336}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.050 MB of 0.099 MB uploaded (0.000 MB deduped)
wandb: \ 0.050 MB of 0.099 MB uploaded (0.000 MB deduped)
wandb: | 0.099 MB of 0.099 MB uploaded (0.000 MB deduped)
wandb: / 0.099 MB of 0.099 MB uploaded (0.000 MB deduped)
wandb: - 0.099 MB of 0.119 MB uploaded (0.000 MB deduped)
wandb: \ 0.110 MB of 0.119 MB uploaded (0.000 MB deduped)
wandb: | 0.119 MB of 0.119 MB uploaded (0.000 MB deduped)
wandb: / 0.119 MB of 0.119 MB uploaded (0.000 MB deduped)
wandb: - 0.119 MB of 0.119 MB uploaded (0.000 MB deduped)
wandb: \ 0.119 MB of 0.119 MB uploaded (0.000 MB deduped)
wandb: | 0.119 MB of 0.119 MB uploaded (0.000 MB deduped)
wandb: / 0.119 MB of 0.119 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/38ffq7m8
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_041940-38ffq7m8/logs
