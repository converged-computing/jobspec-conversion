#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=8
#FLUX: --queue=gpu-rtx6k
#FLUX: -t=43200
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/templama/evaluation/t5_kadapters_soft_full.json
--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220923_124719-1xgs102q
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/1xgs102q
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_soft_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.pool.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.down_project.bias', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.up_project.weight', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.pool.bias', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.8.up_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.8.down_project.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=True, checkpoint_dir=None, checkpoint_path='outputs/kadapter_soft_full_2freeze_158_128/epoch=13-f1_score=0.180-em_score=0.047.ckpt', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=128, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=128, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='full', wandb_log=True, warmup_steps=0, weight_decay=0.0)
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
Length of dataset retrieving is.. 4124
Index(['id', 'date', 'input', 'output'], dtype='object')
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/33 [00:00<?, ?it/s]
Validating:   3%|▎         | 1/33 [00:03<01:51,  3.50s/it]
Validating:   6%|▌         | 2/33 [00:06<01:45,  3.39s/it]
Validating:   9%|▉         | 3/33 [00:09<01:35,  3.18s/it]
Validating:  12%|█▏        | 4/33 [00:12<01:26,  2.98s/it]
Validating:  15%|█▌        | 5/33 [00:15<01:24,  3.03s/it]
Validating:  18%|█▊        | 6/33 [00:18<01:21,  3.02s/it]
Validating:  21%|██        | 7/33 [00:21<01:17,  2.96s/it]
Validating:  24%|██▍       | 8/33 [00:24<01:12,  2.91s/it]
Validating:  27%|██▋       | 9/33 [00:27<01:11,  2.97s/it]
Validating:  30%|███       | 10/33 [00:30<01:12,  3.13s/it]
Validating:  33%|███▎      | 11/33 [00:33<01:07,  3.08s/it]
Validating:  36%|███▋      | 12/33 [00:36<01:03,  3.05s/it]
Validating:  39%|███▉      | 13/33 [00:39<00:58,  2.91s/it]
Validating:  42%|████▏     | 14/33 [00:42<00:56,  2.97s/it]
Validating:  45%|████▌     | 15/33 [00:45<00:54,  3.02s/it]
Validating:  48%|████▊     | 16/33 [00:48<00:50,  2.98s/it]
Validating:  52%|█████▏    | 17/33 [00:51<00:47,  2.97s/it]
Validating:  55%|█████▍    | 18/33 [00:54<00:45,  3.00s/it]
Validating:  58%|█████▊    | 19/33 [00:57<00:42,  3.03s/it]
Validating:  61%|██████    | 20/33 [01:00<00:38,  2.96s/it]
Validating:  64%|██████▎   | 21/33 [01:03<00:35,  2.93s/it]
Validating:  67%|██████▋   | 22/33 [01:05<00:31,  2.84s/it]
Validating:  70%|██████▉   | 23/33 [01:08<00:29,  2.90s/it]
Validating:  73%|███████▎  | 24/33 [01:12<00:27,  3.08s/it]
Validating:  76%|███████▌  | 25/33 [01:15<00:25,  3.21s/it]
Validating:  79%|███████▉  | 26/33 [01:18<00:22,  3.14s/it]
Validating:  82%|████████▏ | 27/33 [01:21<00:18,  3.06s/it]
Validating:  85%|████████▍ | 28/33 [01:24<00:15,  3.01s/it]
Validating:  88%|████████▊ | 29/33 [01:27<00:11,  2.96s/it]
Validating:  91%|█████████ | 30/33 [01:30<00:08,  2.89s/it]
Validating:  94%|█████████▍| 31/33 [01:32<00:05,  2.85s/it]
Validating:  97%|█████████▋| 32/33 [01:35<00:02,  2.88s/it]
Validating: 100%|██████████| 33/33 [01:36<00:00,  2.24s/it]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.04704170674085617, 'f1_score': 0.1804489940404892}
--------------------------------------------------------------------------------
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.476 MB of 0.951 MB uploaded (0.000 MB deduped)
wandb: \ 0.898 MB of 0.951 MB uploaded (0.000 MB deduped)
wandb: | 0.951 MB of 0.951 MB uploaded (0.000 MB deduped)
wandb: / 0.951 MB of 0.971 MB uploaded (0.000 MB deduped)
wandb: - 0.951 MB of 0.971 MB uploaded (0.000 MB deduped)
wandb: \ 0.971 MB of 0.971 MB uploaded (0.000 MB deduped)
wandb: | 0.971 MB of 0.971 MB uploaded (0.000 MB deduped)
wandb: / 0.971 MB of 0.971 MB uploaded (0.000 MB deduped)
wandb: - 0.971 MB of 0.971 MB uploaded (0.000 MB deduped)
wandb: \ 0.971 MB of 0.971 MB uploaded (0.000 MB deduped)
wandb: | 0.971 MB of 0.971 MB uploaded (0.000 MB deduped)
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
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/1xgs102q
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220923_124719-1xgs102q/logs
