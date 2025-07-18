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
python run.py --config configs/wmt/training/t5_kadapters_yearly_2freeze.json -find_lr
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220928_002106-260yruu8
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_2010
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/260yruu8
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/wmtkadapter_2010_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
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
0 | model | T5ForConditionalGeneration | 79.1 M
-----------------------------------------------------
2.2 M     Trainable params
77.0 M    Non-trainable params
79.1 M    Total params
316.510   Total estimated model params size (MB)
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='wmt', dataset_version='2010', early_stop_callback=False, eval_batch_size=128, find_lr=True, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=350, max_output_length=50, method='kadapter', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=2, num_workers=4, opt_level='O1', output_dir='outputs/wmtkadapter_2010_2freeze_158_128', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=128, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=500, val_data='2010', wandb_log=True, warmup_steps=0, weight_decay=0.0)
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
  "pool_size": null,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
hparams.learning_rate = 0.001
split is 0
Length of dataset retrieving is.. 500000
Index(['id', 'date', 'input', 'output'], dtype='object')
split is 0
Length of dataset retrieving is.. 32000
Index(['id', 'date', 'input', 'output'], dtype='object')
split is 0
Length of dataset retrieving is.. 500000
Index(['id', 'date', 'input', 'output'], dtype='object')
Finding best initial lr:   0%|          | 0/100 [00:00<?, ?it/s][W reducer.cpp:1158] Warning: find_unused_parameters=True was specified in DDP constructor, but did not find any unused parameters in the forward pass. This flag results in an extra traversal of the autograd graph every iteration,  which can adversely affect performance. If your model indeed never has any unused parameters in the forward pass, consider turning this flag off. Note that this warning may be a false positive if your model has flow control causing later iterations to have unused parameters. (function operator())
Finding best initial lr:   1%|          | 1/100 [00:01<01:49,  1.10s/it]
Finding best initial lr:   2%|▏         | 2/100 [00:01<01:32,  1.06it/s]
Finding best initial lr:   3%|▎         | 3/100 [00:02<01:26,  1.12it/s]
Finding best initial lr:   4%|▍         | 4/100 [00:03<01:23,  1.15it/s]
Finding best initial lr:   5%|▌         | 5/100 [00:04<01:21,  1.16it/s]
Finding best initial lr:   6%|▌         | 6/100 [00:05<01:19,  1.18it/s]
Finding best initial lr:   7%|▋         | 7/100 [00:06<01:18,  1.18it/s]
Finding best initial lr:   8%|▊         | 8/100 [00:06<01:17,  1.19it/s]
Finding best initial lr:   9%|▉         | 9/100 [00:07<01:16,  1.19it/s]
Finding best initial lr:  10%|█         | 10/100 [00:08<01:15,  1.19it/s]
Finding best initial lr:  11%|█         | 11/100 [00:09<01:14,  1.19it/s]
Finding best initial lr:  12%|█▏        | 12/100 [00:10<01:13,  1.19it/s]
Finding best initial lr:  13%|█▎        | 13/100 [00:11<01:12,  1.19it/s]
Finding best initial lr:  14%|█▍        | 14/100 [00:11<01:12,  1.19it/s]
Finding best initial lr:  15%|█▌        | 15/100 [00:12<01:11,  1.19it/s]
Finding best initial lr:  16%|█▌        | 16/100 [00:13<01:10,  1.19it/s]
Finding best initial lr:  17%|█▋        | 17/100 [00:14<01:09,  1.19it/s]
Finding best initial lr:  18%|█▊        | 18/100 [00:15<01:08,  1.19it/s]
Finding best initial lr:  19%|█▉        | 19/100 [00:16<01:08,  1.19it/s]
Finding best initial lr:  20%|██        | 20/100 [00:17<01:07,  1.19it/s]
Finding best initial lr:  21%|██        | 21/100 [00:17<01:06,  1.19it/s]
Finding best initial lr:  22%|██▏       | 22/100 [00:18<01:03,  1.22it/s]
Finding best initial lr:  23%|██▎       | 23/100 [00:19<01:03,  1.21it/s]
Finding best initial lr:  24%|██▍       | 24/100 [00:20<01:01,  1.24it/s]
Finding best initial lr:  25%|██▌       | 25/100 [00:21<01:01,  1.22it/s]
Finding best initial lr:  26%|██▌       | 26/100 [00:21<01:01,  1.21it/s]
Finding best initial lr:  27%|██▋       | 27/100 [00:22<01:00,  1.20it/s]
Finding best initial lr:  28%|██▊       | 28/100 [00:23<01:00,  1.20it/s]
Finding best initial lr:  29%|██▉       | 29/100 [00:24<00:59,  1.19it/s]
Finding best initial lr:  30%|███       | 30/100 [00:25<00:58,  1.19it/s]
Finding best initial lr:  31%|███       | 31/100 [00:26<00:58,  1.19it/s]
Finding best initial lr:  32%|███▏      | 32/100 [00:27<00:57,  1.18it/s]
Finding best initial lr:  33%|███▎      | 33/100 [00:27<00:56,  1.18it/s]
Finding best initial lr:  34%|███▍      | 34/100 [00:28<00:55,  1.18it/s]
Finding best initial lr:  35%|███▌      | 35/100 [00:29<00:55,  1.18it/s]
Finding best initial lr:  36%|███▌      | 36/100 [00:30<00:54,  1.18it/s]
Finding best initial lr:  37%|███▋      | 37/100 [00:31<00:53,  1.18it/s]
Finding best initial lr:  38%|███▊      | 38/100 [00:32<00:52,  1.17it/s]
Finding best initial lr:  39%|███▉      | 39/100 [00:32<00:51,  1.17it/s]
Finding best initial lr:  40%|████      | 40/100 [00:33<00:51,  1.17it/s]
Finding best initial lr:  41%|████      | 41/100 [00:34<00:50,  1.17it/s]
Finding best initial lr:  42%|████▏     | 42/100 [00:35<00:49,  1.17it/s]
Finding best initial lr:  43%|████▎     | 43/100 [00:36<00:48,  1.17it/s]
Finding best initial lr:  44%|████▍     | 44/100 [00:37<00:47,  1.17it/s]
Finding best initial lr:  45%|████▌     | 45/100 [00:38<00:46,  1.17it/s]
Finding best initial lr:  46%|████▌     | 46/100 [00:38<00:44,  1.21it/s]
Finding best initial lr:  47%|████▋     | 47/100 [00:39<00:44,  1.19it/s]
Finding best initial lr:  48%|████▊     | 48/100 [00:40<00:43,  1.19it/s]
Finding best initial lr:  49%|████▉     | 49/100 [00:41<00:43,  1.18it/s]
Finding best initial lr:  50%|█████     | 50/100 [00:42<00:42,  1.18it/s]
Finding best initial lr:  51%|█████     | 51/100 [00:43<00:41,  1.17it/s]
Finding best initial lr:  52%|█████▏    | 52/100 [00:44<00:40,  1.17it/s]
Finding best initial lr:  53%|█████▎    | 53/100 [00:44<00:40,  1.17it/s]
Finding best initial lr:  54%|█████▍    | 54/100 [00:45<00:38,  1.21it/s]
Finding best initial lr:  55%|█████▌    | 55/100 [00:46<00:37,  1.19it/s]
Finding best initial lr:  56%|█████▌    | 56/100 [00:47<00:37,  1.19it/s]
Finding best initial lr:  57%|█████▋    | 57/100 [00:48<00:36,  1.18it/s]
Finding best initial lr:  58%|█████▊    | 58/100 [00:49<00:35,  1.18it/s]
Finding best initial lr:  59%|█████▉    | 59/100 [00:49<00:34,  1.17it/s]
Finding best initial lr:  60%|██████    | 60/100 [00:50<00:34,  1.17it/s]
Finding best initial lr:  61%|██████    | 61/100 [00:51<00:33,  1.17it/s]
Finding best initial lr:  62%|██████▏   | 62/100 [00:52<00:32,  1.17it/s]
Finding best initial lr:  63%|██████▎   | 63/100 [00:53<00:31,  1.17it/s]
Finding best initial lr:  64%|██████▍   | 64/100 [00:54<00:30,  1.17it/s]
Finding best initial lr:  65%|██████▌   | 65/100 [00:55<00:29,  1.17it/s]
Finding best initial lr:  66%|██████▌   | 66/100 [00:55<00:29,  1.17it/s]
Finding best initial lr:  67%|██████▋   | 67/100 [00:56<00:28,  1.17it/s]
Finding best initial lr:  68%|██████▊   | 68/100 [00:57<00:26,  1.20it/s]
Finding best initial lr:  69%|██████▉   | 69/100 [00:58<00:26,  1.19it/s]
Finding best initial lr:  70%|███████   | 70/100 [00:59<00:25,  1.19it/s]
Finding best initial lr:  71%|███████   | 71/100 [01:00<00:24,  1.18it/s]
Finding best initial lr:  72%|███████▏  | 72/100 [01:00<00:23,  1.17it/s]
Finding best initial lr:  73%|███████▎  | 73/100 [01:01<00:23,  1.17it/s]
Finding best initial lr:  74%|███████▍  | 74/100 [01:02<00:22,  1.17it/s]
Finding best initial lr:  75%|███████▌  | 75/100 [01:03<00:21,  1.17it/s]
Finding best initial lr:  76%|███████▌  | 76/100 [01:04<00:20,  1.17it/s]
Finding best initial lr:  77%|███████▋  | 77/100 [01:05<00:19,  1.17it/s]
Finding best initial lr:  78%|███████▊  | 78/100 [01:06<00:18,  1.17it/s]
Finding best initial lr:  79%|███████▉  | 79/100 [01:06<00:17,  1.17it/s]
Finding best initial lr:  80%|████████  | 80/100 [01:07<00:17,  1.17it/s]
Finding best initial lr:  81%|████████  | 81/100 [01:08<00:16,  1.17it/s]
Finding best initial lr:  82%|████████▏ | 82/100 [01:09<00:15,  1.17it/s]
Finding best initial lr:  83%|████████▎ | 83/100 [01:10<00:14,  1.17it/s]
Finding best initial lr:  84%|████████▍ | 84/100 [01:11<00:13,  1.17it/s]
Finding best initial lr:  85%|████████▌ | 85/100 [01:12<00:12,  1.17it/s]
Finding best initial lr:  86%|████████▌ | 86/100 [01:12<00:11,  1.17it/s]
Finding best initial lr:  87%|████████▋ | 87/100 [01:13<00:11,  1.17it/s]
Finding best initial lr:  88%|████████▊ | 88/100 [01:14<00:10,  1.17it/s]
Finding best initial lr:  89%|████████▉ | 89/100 [01:15<00:09,  1.17it/s]
Finding best initial lr:  90%|█████████ | 90/100 [01:16<00:08,  1.17it/s]
Finding best initial lr:  91%|█████████ | 91/100 [01:17<00:07,  1.17it/s]
Finding best initial lr:  92%|█████████▏| 92/100 [01:18<00:06,  1.20it/s]
Finding best initial lr:  93%|█████████▎| 93/100 [01:18<00:05,  1.19it/s]
Finding best initial lr:  94%|█████████▍| 94/100 [01:19<00:05,  1.18it/s]
Finding best initial lr:  95%|█████████▌| 95/100 [01:20<00:04,  1.18it/s]
Finding best initial lr:  96%|█████████▌| 96/100 [01:21<00:03,  1.17it/s]
Finding best initial lr:  97%|█████████▋| 97/100 [01:22<00:02,  1.17it/s]
Finding best initial lr:  98%|█████████▊| 98/100 [01:23<00:01,  1.17it/s]
Finding best initial lr:  99%|█████████▉| 99/100 [01:24<00:00,  1.17it/s]
Finding best initial lr: 100%|██████████| 100/100 [01:24<00:00,  1.16it/s]Restored states from the checkpoint file at /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/lr_find_temp_model.ckpt
Finding best initial lr: 100%|██████████| 100/100 [01:26<00:00,  1.16it/s]
Learning rate set to 0.005754399373371567
wandb: ERROR Attempted to change value of key "learning_rate" from 0.001 to 0.005754399373371567
wandb: ERROR If you really want to do this, pass allow_val_change=True to config.update()
wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.227 MB of 0.227 MB uploaded (0.000 MB deduped)
wandb: \ 0.227 MB of 0.227 MB uploaded (0.000 MB deduped)
wandb: | 0.227 MB of 0.227 MB uploaded (0.000 MB deduped)
wandb: / 0.227 MB of 0.243 MB uploaded (0.000 MB deduped)
wandb: - 0.228 MB of 0.243 MB uploaded (0.000 MB deduped)
wandb: \ 0.243 MB of 0.243 MB uploaded (0.000 MB deduped)
wandb: | 0.243 MB of 0.243 MB uploaded (0.000 MB deduped)
wandb: / 0.243 MB of 0.243 MB uploaded (0.000 MB deduped)
wandb: - 0.243 MB of 0.243 MB uploaded (0.000 MB deduped)
wandb: \ 0.243 MB of 0.243 MB uploaded (0.000 MB deduped)
wandb: | 0.243 MB of 0.243 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced kadapter_2010: https://wandb.ai/tjung2/temporal_questions/runs/260yruu8
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220928_002106-260yruu8/logs
Traceback (most recent call last):
  File "run.py", line 240, in <module>
    wandb.config['learning_rate'] = model.hparams.learning_rate
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/wandb/sdk/wandb_config.py", line 147, in __setitem__
    key, val = self._sanitize(key, val)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/wandb/sdk/wandb_config.py", line 259, in _sanitize
    raise config_util.ConfigError(
wandb.sdk.lib.config_util.ConfigError: Attempted to change value of key "learning_rate" from 0.001 to 0.005754399373371567
If you really want to do this, pass allow_val_change=True to config.update()
