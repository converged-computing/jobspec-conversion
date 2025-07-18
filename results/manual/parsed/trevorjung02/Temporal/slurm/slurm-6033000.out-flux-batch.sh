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
python run.py --config configs/templama/training/t5_kadapters_2010_1freeze.json--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapters_2010_1freeze_158_64 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight']
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
0 | model | T5ForConditionalGeneration | 78.0 M
-----------------------------------------------------
42.7 M    Trainable params
35.3 M    Non-trainable params
78.0 M    Total params
312.183   Total estimated model params size (MB)
checkpoint path = outputs/kadapters_2010_2freeze_158_64/epoch=47-f1_score=0.202-em_score=0.054.ckpt
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 64, 'adapter_enc_dec': None}, adapter_enc_dec=None, adapter_hidden_size=64, adapter_list=[1, 5, 8], check_validation_only=False, checkpoint_dir='outputs/kadapters_2010_2freeze_158_64', checkpoint_path='outputs/kadapters_2010_2freeze_158_64/epoch=47-f1_score=0.202-em_score=0.054.ckpt', dataset='templama', dataset_version='2010', early_stop_callback=False, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=1, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapters_2010_1freeze_158_64', output_log=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=1e-06, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, wandb_log=False, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 64,
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
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 2866
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 410
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]
Validation sanity check:  50%|█████     | 1/2 [00:02<00:02,  2.49s/it]
Validation sanity check: 100%|██████████| 2/2 [00:03<00:00,  1.50s/it]
split is 0
Length of dataset retrieving is.. 2866
Training: 0it [00:00, ?it/s]
Training:   0%|          | 0/102 [00:00<?, ?it/s]
Epoch 0:   0%|          | 0/102 [00:00<?, ?it/s] [W reducer.cpp:1158] Warning: find_unused_parameters=True was specified in DDP constructor, but did not find any unused parameters in the forward pass. This flag results in an extra traversal of the autograd graph every iteration,  which can adversely affect performance. If your model indeed never has any unused parameters in the forward pass, consider turning this flag off. Note that this warning may be a false positive if your model has flow control causing later iterations to have unused parameters. (function operator())
Epoch 0:   1%|          | 1/102 [00:01<01:57,  1.16s/it]
Epoch 0:   1%|          | 1/102 [00:01<01:57,  1.16s/it, loss=1.35, em_score=0.0938, f1_score=0.220]
Epoch 0:   2%|▏         | 2/102 [00:01<01:03,  1.59it/s, loss=1.55, em_score=0.0938, f1_score=0.220]
Epoch 0:   3%|▎         | 3/102 [00:01<00:44,  2.21it/s, loss=1.55, em_score=0.0938, f1_score=0.220]
Epoch 0:   3%|▎         | 3/102 [00:01<00:44,  2.21it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:   4%|▍         | 4/102 [00:01<00:35,  2.77it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:   5%|▍         | 5/102 [00:01<00:29,  3.27it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:   5%|▍         | 5/102 [00:01<00:29,  3.27it/s, loss=1.66, em_score=0.0938, f1_score=0.220]
Epoch 0:   6%|▌         | 6/102 [00:01<00:25,  3.72it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:   7%|▋         | 7/102 [00:01<00:22,  4.13it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:   7%|▋         | 7/102 [00:01<00:22,  4.13it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:   8%|▊         | 8/102 [00:01<00:20,  4.51it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:   9%|▉         | 9/102 [00:01<00:19,  4.85it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:   9%|▉         | 9/102 [00:01<00:19,  4.85it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  10%|▉         | 10/102 [00:01<00:17,  5.16it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  11%|█         | 11/102 [00:02<00:16,  5.45it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  11%|█         | 11/102 [00:02<00:16,  5.45it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  12%|█▏        | 12/102 [00:02<00:15,  5.71it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  13%|█▎        | 13/102 [00:02<00:14,  5.97it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  13%|█▎        | 13/102 [00:02<00:14,  5.97it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  14%|█▎        | 14/102 [00:02<00:14,  6.19it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  15%|█▍        | 15/102 [00:02<00:13,  6.40it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  15%|█▍        | 15/102 [00:02<00:13,  6.40it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  16%|█▌        | 16/102 [00:02<00:13,  6.60it/s, loss=1.64, em_score=0.0938, f1_score=0.220]
Epoch 0:  17%|█▋        | 17/102 [00:02<00:12,  6.78it/s, loss=1.64, em_score=0.0938, f1_score=0.220]
Epoch 0:  17%|█▋        | 17/102 [00:02<00:12,  6.78it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  18%|█▊        | 18/102 [00:02<00:12,  6.97it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  19%|█▊        | 19/102 [00:02<00:11,  7.13it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  19%|█▊        | 19/102 [00:02<00:11,  7.13it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  20%|█▉        | 20/102 [00:02<00:11,  7.28it/s, loss=1.64, em_score=0.0938, f1_score=0.220]
Epoch 0:  21%|██        | 21/102 [00:02<00:10,  7.42it/s, loss=1.64, em_score=0.0938, f1_score=0.220]
Epoch 0:  21%|██        | 21/102 [00:02<00:10,  7.42it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  22%|██▏       | 22/102 [00:02<00:10,  7.54it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  23%|██▎       | 23/102 [00:03<00:10,  7.65it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  23%|██▎       | 23/102 [00:03<00:10,  7.65it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  24%|██▎       | 24/102 [00:03<00:10,  7.76it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  25%|██▍       | 25/102 [00:03<00:09,  7.87it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  25%|██▍       | 25/102 [00:03<00:09,  7.87it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  25%|██▌       | 26/102 [00:03<00:09,  7.97it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  26%|██▋       | 27/102 [00:03<00:09,  8.06it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  26%|██▋       | 27/102 [00:03<00:09,  8.06it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  27%|██▋       | 28/102 [00:03<00:09,  8.15it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  28%|██▊       | 29/102 [00:03<00:08,  8.23it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  28%|██▊       | 29/102 [00:03<00:08,  8.23it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  29%|██▉       | 30/102 [00:03<00:08,  8.31it/s, loss=1.6, em_score=0.0938, f1_score=0.220] 
Epoch 0:  30%|███       | 31/102 [00:03<00:08,  8.38it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Epoch 0:  30%|███       | 31/102 [00:03<00:08,  8.38it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  31%|███▏      | 32/102 [00:03<00:08,  8.45it/s, loss=1.6, em_score=0.0938, f1_score=0.220] 
Epoch 0:  32%|███▏      | 33/102 [00:03<00:08,  8.52it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Epoch 0:  32%|███▏      | 33/102 [00:03<00:08,  8.52it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  33%|███▎      | 34/102 [00:03<00:07,  8.59it/s, loss=1.6, em_score=0.0938, f1_score=0.220] 
Epoch 0:  34%|███▍      | 35/102 [00:04<00:07,  8.66it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Epoch 0:  34%|███▍      | 35/102 [00:04<00:07,  8.66it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  35%|███▌      | 36/102 [00:04<00:07,  8.72it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  36%|███▋      | 37/102 [00:04<00:07,  8.78it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  36%|███▋      | 37/102 [00:04<00:07,  8.78it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  37%|███▋      | 38/102 [00:04<00:07,  8.85it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  38%|███▊      | 39/102 [00:04<00:07,  8.90it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  38%|███▊      | 39/102 [00:04<00:07,  8.90it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  39%|███▉      | 40/102 [00:04<00:06,  8.95it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  40%|████      | 41/102 [00:04<00:06,  9.00it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  40%|████      | 41/102 [00:04<00:06,  9.00it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  41%|████      | 42/102 [00:04<00:06,  9.05it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  42%|████▏     | 43/102 [00:04<00:06,  9.10it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  42%|████▏     | 43/102 [00:04<00:06,  9.10it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  43%|████▎     | 44/102 [00:04<00:06,  9.15it/s, loss=1.57, em_score=0.0938, f1_score=0.220]
Epoch 0:  44%|████▍     | 45/102 [00:04<00:06,  9.19it/s, loss=1.57, em_score=0.0938, f1_score=0.220]
Epoch 0:  44%|████▍     | 45/102 [00:04<00:06,  9.19it/s, loss=1.58, em_score=0.0938, f1_score=0.220]
Epoch 0:  45%|████▌     | 46/102 [00:04<00:06,  9.24it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  46%|████▌     | 47/102 [00:05<00:05,  9.29it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  46%|████▌     | 47/102 [00:05<00:05,  9.29it/s, loss=1.6, em_score=0.0938, f1_score=0.220] 
Epoch 0:  47%|████▋     | 48/102 [00:05<00:05,  9.33it/s, loss=1.58, em_score=0.0938, f1_score=0.220]
Epoch 0:  48%|████▊     | 49/102 [00:05<00:05,  9.37it/s, loss=1.58, em_score=0.0938, f1_score=0.220]
Epoch 0:  48%|████▊     | 49/102 [00:05<00:05,  9.37it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  49%|████▉     | 50/102 [00:05<00:05,  9.41it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  50%|█████     | 51/102 [00:05<00:05,  9.45it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  50%|█████     | 51/102 [00:05<00:05,  9.45it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  51%|█████     | 52/102 [00:05<00:05,  9.49it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  52%|█████▏    | 53/102 [00:05<00:05,  9.53it/s, loss=1.59, em_score=0.0938, f1_score=0.220]
Epoch 0:  52%|█████▏    | 53/102 [00:05<00:05,  9.53it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  53%|█████▎    | 54/102 [00:05<00:05,  9.57it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  54%|█████▍    | 55/102 [00:05<00:04,  9.61it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  54%|█████▍    | 55/102 [00:05<00:04,  9.61it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  55%|█████▍    | 56/102 [00:05<00:04,  9.64it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  56%|█████▌    | 57/102 [00:05<00:04,  9.67it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  56%|█████▌    | 57/102 [00:05<00:04,  9.67it/s, loss=1.6, em_score=0.0938, f1_score=0.220] 
Epoch 0:  57%|█████▋    | 58/102 [00:05<00:04,  9.70it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  58%|█████▊    | 59/102 [00:06<00:04,  9.73it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  58%|█████▊    | 59/102 [00:06<00:04,  9.72it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  59%|█████▉    | 60/102 [00:06<00:04,  9.75it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  60%|█████▉    | 61/102 [00:06<00:04,  9.78it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  60%|█████▉    | 61/102 [00:06<00:04,  9.78it/s, loss=1.64, em_score=0.0938, f1_score=0.220]
Epoch 0:  61%|██████    | 62/102 [00:06<00:04,  9.80it/s, loss=1.66, em_score=0.0938, f1_score=0.220]
Epoch 0:  62%|██████▏   | 63/102 [00:06<00:03,  9.82it/s, loss=1.66, em_score=0.0938, f1_score=0.220]
Epoch 0:  62%|██████▏   | 63/102 [00:06<00:03,  9.82it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  63%|██████▎   | 64/102 [00:06<00:03,  9.85it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  64%|██████▎   | 65/102 [00:06<00:03,  9.87it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  64%|██████▎   | 65/102 [00:06<00:03,  9.87it/s, loss=1.68, em_score=0.0938, f1_score=0.220]
Epoch 0:  65%|██████▍   | 66/102 [00:06<00:03,  9.89it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  66%|██████▌   | 67/102 [00:06<00:03,  9.92it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  66%|██████▌   | 67/102 [00:06<00:03,  9.92it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  67%|██████▋   | 68/102 [00:06<00:03,  9.94it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  68%|██████▊   | 69/102 [00:06<00:03,  9.96it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  68%|██████▊   | 69/102 [00:06<00:03,  9.96it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  69%|██████▊   | 70/102 [00:07<00:03,  9.98it/s, loss=1.66, em_score=0.0938, f1_score=0.220]
Epoch 0:  70%|██████▉   | 71/102 [00:07<00:03, 10.00it/s, loss=1.66, em_score=0.0938, f1_score=0.220]
Epoch 0:  70%|██████▉   | 71/102 [00:07<00:03, 10.00it/s, loss=1.67, em_score=0.0938, f1_score=0.220]
Epoch 0:  71%|███████   | 72/102 [00:07<00:02, 10.03it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  72%|███████▏  | 73/102 [00:07<00:02, 10.05it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  72%|███████▏  | 73/102 [00:07<00:02, 10.05it/s, loss=1.64, em_score=0.0938, f1_score=0.220]
Epoch 0:  73%|███████▎  | 74/102 [00:07<00:02, 10.07it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  74%|███████▎  | 75/102 [00:07<00:02, 10.09it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  74%|███████▎  | 75/102 [00:07<00:02, 10.09it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  75%|███████▍  | 76/102 [00:07<00:02, 10.11it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  75%|███████▌  | 77/102 [00:07<00:02, 10.13it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  75%|███████▌  | 77/102 [00:07<00:02, 10.13it/s, loss=1.64, em_score=0.0938, f1_score=0.220]
Epoch 0:  76%|███████▋  | 78/102 [00:07<00:02, 10.15it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  77%|███████▋  | 79/102 [00:07<00:02, 10.17it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  77%|███████▋  | 79/102 [00:07<00:02, 10.17it/s, loss=1.64, em_score=0.0938, f1_score=0.220]
Epoch 0:  78%|███████▊  | 80/102 [00:07<00:02, 10.19it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  79%|███████▉  | 81/102 [00:07<00:02, 10.21it/s, loss=1.65, em_score=0.0938, f1_score=0.220]
Epoch 0:  79%|███████▉  | 81/102 [00:07<00:02, 10.21it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  80%|████████  | 82/102 [00:08<00:01, 10.23it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  81%|████████▏ | 83/102 [00:08<00:01, 10.25it/s, loss=1.63, em_score=0.0938, f1_score=0.220]
Epoch 0:  81%|████████▏ | 83/102 [00:08<00:01, 10.25it/s, loss=1.6, em_score=0.0938, f1_score=0.220] 
Epoch 0:  82%|████████▏ | 84/102 [00:08<00:01, 10.27it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  83%|████████▎ | 85/102 [00:08<00:01, 10.30it/s, loss=1.61, em_score=0.0938, f1_score=0.220]
Epoch 0:  83%|████████▎ | 85/102 [00:08<00:01, 10.30it/s, loss=1.6, em_score=0.0938, f1_score=0.220] 
Epoch 0:  84%|████████▍ | 86/102 [00:08<00:01, 10.32it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  85%|████████▌ | 87/102 [00:08<00:01, 10.33it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  85%|████████▌ | 87/102 [00:08<00:01, 10.33it/s, loss=1.62, em_score=0.0938, f1_score=0.220]
Epoch 0:  86%|████████▋ | 88/102 [00:08<00:01, 10.35it/s, loss=1.6, em_score=0.0938, f1_score=0.220] 
Epoch 0:  87%|████████▋ | 89/102 [00:08<00:01, 10.16it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Epoch 0:  87%|████████▋ | 89/102 [00:08<00:01, 10.16it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/13 [00:00<?, ?it/s][A
Validating:   8%|▊         | 1/13 [00:01<00:21,  1.80s/it][A
Epoch 0:  89%|████████▉ | 91/102 [00:10<00:01,  8.61it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Validating:  15%|█▌        | 2/13 [00:02<00:13,  1.25s/it][A
Validating:  23%|██▎       | 3/13 [00:03<00:10,  1.07s/it][A
Epoch 0:  91%|█████████ | 93/102 [00:12<00:01,  7.56it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Validating:  31%|███       | 4/13 [00:04<00:09,  1.01s/it][A
Validating:  38%|███▊      | 5/13 [00:05<00:07,  1.02it/s][A
Epoch 0:  93%|█████████▎| 95/102 [00:14<00:01,  6.72it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Validating:  46%|████▌     | 6/13 [00:06<00:06,  1.11it/s][A
Validating:  54%|█████▍    | 7/13 [00:06<00:05,  1.13it/s][A
Epoch 0:  95%|█████████▌| 97/102 [00:15<00:00,  6.16it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Validating:  62%|██████▏   | 8/13 [00:07<00:04,  1.13it/s][A
Validating:  69%|██████▉   | 9/13 [00:08<00:03,  1.17it/s][A
Epoch 0:  97%|█████████▋| 99/102 [00:17<00:00,  5.69it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Validating:  77%|███████▋  | 10/13 [00:09<00:02,  1.20it/s][A
Validating:  85%|████████▍ | 11/13 [00:10<00:01,  1.22it/s][A
Epoch 0:  99%|█████████▉| 101/102 [00:18<00:00,  5.32it/s, loss=1.6, em_score=0.0938, f1_score=0.220]
Validating:  92%|█████████▏| 12/13 [00:11<00:00,  1.22it/s][A
Validating: 100%|██████████| 13/13 [00:11<00:00,  1.18it/s][A
Epoch 0: 100%|██████████| 102/102 [00:20<00:00,  4.89it/s, loss=1.6, em_score=0.0537, f1_score=0.204]
                                                           [A
Epoch 0:   0%|          | 0/102 [00:00<?, ?it/s, loss=1.6, em_score=0.0537, f1_score=0.204]          
Epoch 1:   0%|          | 0/102 [00:00<?, ?it/s, loss=1.6, em_score=0.0537, f1_score=0.204]
Epoch 1:   1%|          | 1/102 [00:01<01:46,  1.05s/it, loss=1.58, em_score=0.0537, f1_score=0.204]
Epoch 1:   2%|▏         | 2/102 [00:01<00:57,  1.75it/s, loss=1.58, em_score=0.0537, f1_score=0.204]
Epoch 1:   2%|▏         | 2/102 [00:01<00:57,  1.75it/s, loss=1.6, em_score=0.0537, f1_score=0.204] 
Epoch 1:   3%|▎         | 3/102 [00:01<00:40,  2.43it/s, loss=1.6, em_score=0.0537, f1_score=0.204]
Epoch 1:   4%|▍         | 4/102 [00:01<00:32,  3.03it/s, loss=1.6, em_score=0.0537, f1_score=0.204]
Epoch 1:   4%|▍         | 4/102 [00:01<00:32,  3.03it/s, loss=1.6, em_score=0.0537, f1_score=0.204]
Epoch 1:   5%|▍         | 5/102 [00:01<00:27,  3.56it/s, loss=1.61, em_score=0.0537, f1_score=0.204]
Epoch 1:   6%|▌         | 6/102 [00:01<00:23,  4.03it/s, loss=1.61, em_score=0.0537, f1_score=0.204]
Epoch 1:   6%|▌         | 6/102 [00:01<00:23,  4.03it/s, loss=1.61, em_score=0.0537, f1_score=0.204]
Epoch 1:   7%|▋         | 7/102 [00:01<00:21,  4.45it/s, loss=1.6, em_score=0.0537, f1_score=0.204] 
Epoch 1:   8%|▊         | 8/102 [00:01<00:19,  4.83it/s, loss=1.6, em_score=0.0537, f1_score=0.204]
Epoch 1:   8%|▊         | 8/102 [00:01<00:19,  4.83it/s, loss=1.58, em_score=0.0537, f1_score=0.204]
Epoch 1:   9%|▉         | 9/102 [00:01<00:17,  5.17it/s, loss=1.59, em_score=0.0537, f1_score=0.204]
Epoch 1:  10%|▉         | 10/102 [00:01<00:16,  5.48it/s, loss=1.59, em_score=0.0537, f1_score=0.204]
Epoch 1:  10%|▉         | 10/102 [00:01<00:16,  5.48it/s, loss=1.58, em_score=0.0537, f1_score=0.204]
Epoch 1:  11%|█         | 11/102 [00:01<00:15,  5.76it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  12%|█▏        | 12/102 [00:01<00:14,  6.02it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  12%|█▏        | 12/102 [00:01<00:14,  6.02it/s, loss=1.58, em_score=0.0537, f1_score=0.204]
Epoch 1:  13%|█▎        | 13/102 [00:02<00:14,  6.26it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  14%|█▎        | 14/102 [00:02<00:13,  6.48it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  14%|█▎        | 14/102 [00:02<00:13,  6.48it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  15%|█▍        | 15/102 [00:02<00:13,  6.68it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  16%|█▌        | 16/102 [00:02<00:12,  6.87it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  16%|█▌        | 16/102 [00:02<00:12,  6.87it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  17%|█▋        | 17/102 [00:02<00:12,  7.04it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  18%|█▊        | 18/102 [00:02<00:11,  7.21it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  18%|█▊        | 18/102 [00:02<00:11,  7.21it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  19%|█▊        | 19/102 [00:02<00:11,  7.36it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  20%|█▉        | 20/102 [00:02<00:10,  7.50it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  20%|█▉        | 20/102 [00:02<00:10,  7.50it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  21%|██        | 21/102 [00:02<00:10,  7.62it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  22%|██▏       | 22/102 [00:02<00:10,  7.74it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  22%|██▏       | 22/102 [00:02<00:10,  7.74it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  23%|██▎       | 23/102 [00:02<00:10,  7.85it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  24%|██▎       | 24/102 [00:03<00:09,  7.96it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  24%|██▎       | 24/102 [00:03<00:09,  7.96it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  25%|██▍       | 25/102 [00:03<00:09,  8.05it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  25%|██▌       | 26/102 [00:03<00:09,  8.15it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  25%|██▌       | 26/102 [00:03<00:09,  8.14it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  26%|██▋       | 27/102 [00:03<00:09,  8.23it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  27%|██▋       | 28/102 [00:03<00:08,  8.32it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  27%|██▋       | 28/102 [00:03<00:08,  8.31it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  28%|██▊       | 29/102 [00:03<00:08,  8.39it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  29%|██▉       | 30/102 [00:03<00:08,  8.46it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  29%|██▉       | 30/102 [00:03<00:08,  8.46it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  30%|███       | 31/102 [00:03<00:08,  8.54it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  31%|███▏      | 32/102 [00:03<00:08,  8.62it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  31%|███▏      | 32/102 [00:03<00:08,  8.61it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  32%|███▏      | 33/102 [00:03<00:07,  8.68it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  33%|███▎      | 34/102 [00:03<00:07,  8.75it/s, loss=1.55, em_score=0.0537, f1_score=0.204]
Epoch 1:  33%|███▎      | 34/102 [00:03<00:07,  8.75it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  34%|███▍      | 35/102 [00:03<00:07,  8.82it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  35%|███▌      | 36/102 [00:04<00:07,  8.89it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  35%|███▌      | 36/102 [00:04<00:07,  8.89it/s, loss=1.53, em_score=0.0537, f1_score=0.204]
Epoch 1:  36%|███▋      | 37/102 [00:04<00:07,  8.95it/s, loss=1.52, em_score=0.0537, f1_score=0.204]
Epoch 1:  37%|███▋      | 38/102 [00:04<00:07,  9.01it/s, loss=1.52, em_score=0.0537, f1_score=0.204]
Epoch 1:  37%|███▋      | 38/102 [00:04<00:07,  9.01it/s, loss=1.5, em_score=0.0537, f1_score=0.204] 
Epoch 1:  38%|███▊      | 39/102 [00:04<00:06,  9.06it/s, loss=1.5, em_score=0.0537, f1_score=0.204]
Epoch 1:  39%|███▉      | 40/102 [00:04<00:06,  9.11it/s, loss=1.5, em_score=0.0537, f1_score=0.204]
Epoch 1:  39%|███▉      | 40/102 [00:04<00:06,  9.11it/s, loss=1.5, em_score=0.0537, f1_score=0.204]
Epoch 1:  40%|████      | 41/102 [00:04<00:06,  9.16it/s, loss=1.5, em_score=0.0537, f1_score=0.204]
Epoch 1:  41%|████      | 42/102 [00:04<00:06,  9.21it/s, loss=1.5, em_score=0.0537, f1_score=0.204]
Epoch 1:  41%|████      | 42/102 [00:04<00:06,  9.21it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  42%|████▏     | 43/102 [00:04<00:06,  9.26it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  43%|████▎     | 44/102 [00:04<00:06,  9.32it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  43%|████▎     | 44/102 [00:04<00:06,  9.32it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  44%|████▍     | 45/102 [00:04<00:06,  9.37it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  45%|████▌     | 46/102 [00:04<00:05,  9.42it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  45%|████▌     | 46/102 [00:04<00:05,  9.42it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Epoch 1:  46%|████▌     | 47/102 [00:04<00:05,  9.47it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  47%|████▋     | 48/102 [00:05<00:05,  9.52it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  47%|████▋     | 48/102 [00:05<00:05,  9.52it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  48%|████▊     | 49/102 [00:05<00:05,  9.56it/s, loss=1.5, em_score=0.0537, f1_score=0.204] 
Epoch 1:  49%|████▉     | 50/102 [00:05<00:05,  9.60it/s, loss=1.5, em_score=0.0537, f1_score=0.204]
Epoch 1:  49%|████▉     | 50/102 [00:05<00:05,  9.60it/s, loss=1.48, em_score=0.0537, f1_score=0.204]
Epoch 1:  50%|█████     | 51/102 [00:05<00:05,  9.63it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Epoch 1:  51%|█████     | 52/102 [00:05<00:05,  9.66it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Epoch 1:  51%|█████     | 52/102 [00:05<00:05,  9.66it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  52%|█████▏    | 53/102 [00:05<00:05,  9.69it/s, loss=1.45, em_score=0.0537, f1_score=0.204]
Epoch 1:  53%|█████▎    | 54/102 [00:05<00:04,  9.72it/s, loss=1.45, em_score=0.0537, f1_score=0.204]
Epoch 1:  53%|█████▎    | 54/102 [00:05<00:04,  9.72it/s, loss=1.46, em_score=0.0537, f1_score=0.204]
Epoch 1:  54%|█████▍    | 55/102 [00:05<00:04,  9.75it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  55%|█████▍    | 56/102 [00:05<00:04,  9.78it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  55%|█████▍    | 56/102 [00:05<00:04,  9.78it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  56%|█████▌    | 57/102 [00:05<00:04,  9.80it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  57%|█████▋    | 58/102 [00:05<00:04,  9.82it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  57%|█████▋    | 58/102 [00:05<00:04,  9.82it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  58%|█████▊    | 59/102 [00:05<00:04,  9.85it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  59%|█████▉    | 60/102 [00:06<00:04,  9.88it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  59%|█████▉    | 60/102 [00:06<00:04,  9.88it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Epoch 1:  60%|█████▉    | 61/102 [00:06<00:04,  9.89it/s, loss=1.48, em_score=0.0537, f1_score=0.204]
Epoch 1:  61%|██████    | 62/102 [00:06<00:04,  9.92it/s, loss=1.48, em_score=0.0537, f1_score=0.204]
Epoch 1:  61%|██████    | 62/102 [00:06<00:04,  9.92it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  62%|██████▏   | 63/102 [00:06<00:03,  9.93it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  63%|██████▎   | 64/102 [00:06<00:03,  9.95it/s, loss=1.47, em_score=0.0537, f1_score=0.204]
Epoch 1:  63%|██████▎   | 64/102 [00:06<00:03,  9.95it/s, loss=1.48, em_score=0.0537, f1_score=0.204]
Epoch 1:  64%|██████▎   | 65/102 [00:06<00:03,  9.97it/s, loss=1.46, em_score=0.0537, f1_score=0.204]
Epoch 1:  65%|██████▍   | 66/102 [00:06<00:03,  9.99it/s, loss=1.46, em_score=0.0537, f1_score=0.204]
Epoch 1:  65%|██████▍   | 66/102 [00:06<00:03,  9.99it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Epoch 1:  66%|██████▌   | 67/102 [00:06<00:03, 10.01it/s, loss=1.48, em_score=0.0537, f1_score=0.204]
Epoch 1:  67%|██████▋   | 68/102 [00:06<00:03, 10.04it/s, loss=1.48, em_score=0.0537, f1_score=0.204]
Epoch 1:  67%|██████▋   | 68/102 [00:06<00:03, 10.03it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Epoch 1:  68%|██████▊   | 69/102 [00:06<00:03, 10.05it/s, loss=1.48, em_score=0.0537, f1_score=0.204]
Epoch 1:  69%|██████▊   | 70/102 [00:06<00:03, 10.08it/s, loss=1.48, em_score=0.0537, f1_score=0.204]
Epoch 1:  69%|██████▊   | 70/102 [00:06<00:03, 10.07it/s, loss=1.5, em_score=0.0537, f1_score=0.204] 
Epoch 1:  70%|██████▉   | 71/102 [00:07<00:03, 10.09it/s, loss=1.5, em_score=0.0537, f1_score=0.204]
Epoch 1:  71%|███████   | 72/102 [00:07<00:02, 10.11it/s, loss=1.5, em_score=0.0537, f1_score=0.204]
Epoch 1:  71%|███████   | 72/102 [00:07<00:02, 10.11it/s, loss=1.5, em_score=0.0537, f1_score=0.204]
Epoch 1:  72%|███████▏  | 73/102 [00:07<00:02, 10.14it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  73%|███████▎  | 74/102 [00:07<00:02, 10.16it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  73%|███████▎  | 74/102 [00:07<00:02, 10.15it/s, loss=1.52, em_score=0.0537, f1_score=0.204]
Epoch 1:  74%|███████▎  | 75/102 [00:07<00:02, 10.17it/s, loss=1.52, em_score=0.0537, f1_score=0.204]
Epoch 1:  75%|███████▍  | 76/102 [00:07<00:02, 10.19it/s, loss=1.52, em_score=0.0537, f1_score=0.204]
Epoch 1:  75%|███████▍  | 76/102 [00:07<00:02, 10.19it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  75%|███████▌  | 77/102 [00:07<00:02, 10.21it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  76%|███████▋  | 78/102 [00:07<00:02, 10.23it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  76%|███████▋  | 78/102 [00:07<00:02, 10.22it/s, loss=1.56, em_score=0.0537, f1_score=0.204]
Epoch 1:  77%|███████▋  | 79/102 [00:07<00:02, 10.24it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  78%|███████▊  | 80/102 [00:07<00:02, 10.26it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  78%|███████▊  | 80/102 [00:07<00:02, 10.26it/s, loss=1.54, em_score=0.0537, f1_score=0.204]
Epoch 1:  79%|███████▉  | 81/102 [00:07<00:02, 10.28it/s, loss=1.52, em_score=0.0537, f1_score=0.204]
Epoch 1:  80%|████████  | 82/102 [00:07<00:01, 10.30it/s, loss=1.52, em_score=0.0537, f1_score=0.204]
Epoch 1:  80%|████████  | 82/102 [00:07<00:01, 10.30it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  81%|████████▏ | 83/102 [00:08<00:01, 10.33it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  82%|████████▏ | 84/102 [00:08<00:01, 10.35it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  82%|████████▏ | 84/102 [00:08<00:01, 10.34it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  83%|████████▎ | 85/102 [00:08<00:01, 10.36it/s, loss=1.52, em_score=0.0537, f1_score=0.204]
Epoch 1:  84%|████████▍ | 86/102 [00:08<00:01, 10.38it/s, loss=1.52, em_score=0.0537, f1_score=0.204]
Epoch 1:  84%|████████▍ | 86/102 [00:08<00:01, 10.38it/s, loss=1.51, em_score=0.0537, f1_score=0.204]
Epoch 1:  85%|████████▌ | 87/102 [00:08<00:01, 10.39it/s, loss=1.5, em_score=0.0537, f1_score=0.204] 
Epoch 1:  86%|████████▋ | 88/102 [00:08<00:01, 10.40it/s, loss=1.5, em_score=0.0537, f1_score=0.204]
Epoch 1:  86%|████████▋ | 88/102 [00:08<00:01, 10.40it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Epoch 1:  87%|████████▋ | 89/102 [00:08<00:01, 10.22it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Epoch 1:  88%|████████▊ | 90/102 [00:08<00:01, 10.33it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/13 [00:00<?, ?it/s][A
Validating:   8%|▊         | 1/13 [00:01<00:21,  1.79s/it][A
Validating:  15%|█▌        | 2/13 [00:02<00:13,  1.25s/it][A
Epoch 1:  90%|█████████ | 92/102 [00:11<00:01,  8.08it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Validating:  23%|██▎       | 3/13 [00:03<00:10,  1.06s/it][A
Validating:  31%|███       | 4/13 [00:04<00:08,  1.05it/s][A
Epoch 1:  92%|█████████▏| 94/102 [00:12<00:01,  7.23it/s, loss=1.49, em_score=0.0537, f1_score=0.204]
Validating:  38%|███▊      | 5/13 [00:05<00:07,  1.08it/s][Aslurmstepd: error: *** JOB 6033000 ON g3040 CANCELLED AT 2022-08-31T16:02:57 ***
