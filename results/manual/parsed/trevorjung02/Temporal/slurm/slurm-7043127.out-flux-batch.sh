#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=8
#FLUX: --queue=gpu-a40
#FLUX: -t=86400
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/templama/training/t5_kadapters_yearly_large.json -val_data 2010 -checkpoint_path outputs/templamakadapter_full_2freeze_158_128/epoch=22-f1_score=0.179-em_score=0.052.ckpt
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.4 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20221028_142417-2xg8umha
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/2xg8umha
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/templamakadapter_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-large-ssm and are newly initialized: ['enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
checkpoint path = outputs/wmtkadapter_2010_2freeze_11224_128/epoch=0-f1_score=0.2807-em_score=0.2349.ckpt
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir='outputs/wmtkadapter_2010_2freeze_11224_128', checkpoint_path='outputs/templamakadapter_full_2freeze_158_128/epoch=22-f1_score=0.179-em_score=0.052.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=32, find_lr=False, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.003, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter', mode='pretrain', model_name_or_path='google/t5-large-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/templamakadapter_full_2freeze_158_128', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=True, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-large-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=False, val_check_interval=1.0, val_data='2010', wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-large-ssm",
  "architectures": [
    "T5ForConditionalGeneration"
  ],
  "d_ff": 4096,
  "d_kv": 64,
  "d_model": 1024,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "relu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 24,
  "num_heads": 16,
  "num_layers": 24,
  "output_past": true,
  "pad_token_id": 0,
  "relative_attention_num_buckets": 32,
  "transformers_version": "4.12.3",
  "use_cache": true,
  "vocab_size": 32128
}
T5Config {
  "_name_or_path": "google/t5-large-ssm",
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
  "d_ff": 4096,
  "d_kv": 64,
  "d_model": 1024,
  "decoder_start_token_id": 0,
  "dropout_rate": 0.1,
  "eos_token_id": 1,
  "feed_forward_proj": "relu",
  "initializer_factor": 1.0,
  "is_encoder_decoder": true,
  "layer_norm_epsilon": 1e-06,
  "model_type": "t5",
  "num_decoder_layers": 24,
  "num_heads": 16,
  "num_layers": 24,
  "output_past": true,
  "pad_token_id": 0,
  "pool_size": null,
  "relative_attention_num_buckets": 32,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 416
Index(['id', 'date', 'input', 'output'], dtype='object')
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/13 [00:00<?, ?it/s]
Validating:   8%|▊         | 1/13 [00:02<00:32,  2.72s/it]
Validating:  15%|█▌        | 2/13 [00:03<00:18,  1.72s/it]
Validating:  23%|██▎       | 3/13 [00:04<00:13,  1.38s/it]
Validating:  31%|███       | 4/13 [00:05<00:11,  1.22s/it]
Validating:  38%|███▊      | 5/13 [00:06<00:08,  1.12s/it]
Validating:  46%|████▌     | 6/13 [00:07<00:07,  1.08s/it]
Validating:  54%|█████▍    | 7/13 [00:08<00:06,  1.02s/it]
Validating:  62%|██████▏   | 8/13 [00:09<00:05,  1.02s/it]
Validating:  69%|██████▉   | 9/13 [00:10<00:04,  1.01s/it]
Validating:  77%|███████▋  | 10/13 [00:11<00:03,  1.02s/it]
Validating:  85%|████████▍ | 11/13 [00:12<00:02,  1.01s/it]
Validating:  92%|█████████▏| 12/13 [00:13<00:01,  1.06s/it]
Validating: 100%|██████████| 13/13 [00:14<00:00,  1.06s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.04086538404226303, 'f1_score': 0.18120130896568298}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.098 MB of 0.098 MB uploaded (0.000 MB deduped)
wandb: \ 0.098 MB of 0.098 MB uploaded (0.000 MB deduped)
wandb: | 0.098 MB of 0.098 MB uploaded (0.000 MB deduped)
wandb: / 0.098 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: - 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: \ 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: | 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: / 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: - 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
wandb: \ 0.115 MB of 0.115 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_full: https://wandb.ai/tjung2/temporal_questions/runs/2xg8umha
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20221028_142417-2xg8umha/logs
