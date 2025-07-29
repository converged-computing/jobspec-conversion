#!/bin/bash
#SBATCH --job-name=data-proc
#SBATCH --account=ark
#SBATCH --mail-user=tjung2@uw.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=11:00:00

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/templama/training/t5_kadapters_2010_2freeze.json -datav 2011
python run.py --config configs/templama/training/t5_kadapters_2010_2freeze.json -datav 2012
python run.py --config configs/templama/training/t5_kadapters_2010_2freeze.json -datav 2013
python run.py --config configs/templama/training/t5_kadapters_2010_2freeze.json -datav 2014
--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.2 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220831_162038-3vai1hqf
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_2010
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/3vai1hqf
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight']
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
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='templama', dataset_version='2011', early_stop_callback=False, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=90, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_2011_2freeze_158_128', output_log=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, wandb_log=True, warmup_steps=0, weight_decay=0.0)
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
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 3019
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 431
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]
Validation sanity check:  50%|█████     | 1/2 [00:02<00:02,  2.29s/it]
Validation sanity check: 100%|██████████| 2/2 [00:03<00:00,  1.71s/it]
split is 0
Length of dataset retrieving is.. 3019
Training: 0it [00:00, ?it/s]
Training:   0%|          | 0/108 [00:00<?, ?it/s]
Epoch 0:   0%|          | 0/108 [00:00<?, ?it/s] [W reducer.cpp:1158] Warning: find_unused_parameters=True was specified in DDP constructor, but did not find any unused parameters in the forward pass. This flag results in an extra traversal of the autograd graph every iteration,  which can adversely affect performance. If your model indeed never has any unused parameters in the forward pass, consider turning this flag off. Note that this warning may be a false positive if your model has flow control causing later iterations to have unused parameters. (function operator())
Epoch 0:   1%|          | 1/108 [00:01<01:57,  1.09s/it]
Epoch 0:   1%|          | 1/108 [00:01<01:57,  1.09s/it, loss=27.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   2%|▏         | 2/108 [00:01<01:01,  1.72it/s, loss=27.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   3%|▎         | 3/108 [00:01<00:42,  2.47it/s, loss=27.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   3%|▎         | 3/108 [00:01<00:42,  2.47it/s, loss=26.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   4%|▎         | 4/108 [00:01<00:33,  3.15it/s, loss=26.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   5%|▍         | 5/108 [00:01<00:27,  3.77it/s, loss=26.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   5%|▍         | 5/108 [00:01<00:27,  3.77it/s, loss=26.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   6%|▌         | 6/108 [00:01<00:23,  4.33it/s, loss=26.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   6%|▋         | 7/108 [00:01<00:20,  4.86it/s, loss=26.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   6%|▋         | 7/108 [00:01<00:20,  4.86it/s, loss=26.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   7%|▋         | 8/108 [00:01<00:18,  5.35it/s, loss=26.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   8%|▊         | 9/108 [00:01<00:17,  5.80it/s, loss=26.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   8%|▊         | 9/108 [00:01<00:17,  5.80it/s, loss=26.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:   9%|▉         | 10/108 [00:01<00:15,  6.21it/s, loss=26, v_num=1hqf, em_score=0.000, f1_score=0.000] 
Epoch 0:  10%|█         | 11/108 [00:01<00:14,  6.59it/s, loss=26, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  10%|█         | 11/108 [00:01<00:14,  6.59it/s, loss=26.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  11%|█         | 12/108 [00:01<00:13,  6.93it/s, loss=25.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  12%|█▏        | 13/108 [00:01<00:13,  7.25it/s, loss=25.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  12%|█▏        | 13/108 [00:01<00:13,  7.24it/s, loss=25.8, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  13%|█▎        | 14/108 [00:01<00:12,  7.53it/s, loss=25.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  14%|█▍        | 15/108 [00:01<00:11,  7.80it/s, loss=25.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  14%|█▍        | 15/108 [00:01<00:11,  7.80it/s, loss=25.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  15%|█▍        | 16/108 [00:01<00:11,  8.04it/s, loss=25.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  16%|█▌        | 17/108 [00:02<00:11,  8.27it/s, loss=25.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  16%|█▌        | 17/108 [00:02<00:11,  8.26it/s, loss=25.2, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  17%|█▋        | 18/108 [00:02<00:10,  8.49it/s, loss=25, v_num=1hqf, em_score=0.000, f1_score=0.000]  
Epoch 0:  18%|█▊        | 19/108 [00:02<00:10,  8.70it/s, loss=25, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  18%|█▊        | 19/108 [00:02<00:10,  8.70it/s, loss=24.8, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  19%|█▊        | 20/108 [00:02<00:09,  8.90it/s, loss=24.8, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  19%|█▉        | 21/108 [00:02<00:09,  9.08it/s, loss=24.8, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  19%|█▉        | 21/108 [00:02<00:09,  9.07it/s, loss=24.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  20%|██        | 22/108 [00:02<00:09,  9.25it/s, loss=24.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  21%|██▏       | 23/108 [00:02<00:09,  9.41it/s, loss=24.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  21%|██▏       | 23/108 [00:02<00:09,  9.41it/s, loss=24, v_num=1hqf, em_score=0.000, f1_score=0.000]  
Epoch 0:  22%|██▏       | 24/108 [00:02<00:08,  9.57it/s, loss=23.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  23%|██▎       | 25/108 [00:02<00:08,  9.72it/s, loss=23.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  23%|██▎       | 25/108 [00:02<00:08,  9.72it/s, loss=23.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  24%|██▍       | 26/108 [00:02<00:08,  9.86it/s, loss=23.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  25%|██▌       | 27/108 [00:02<00:08, 10.00it/s, loss=23.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  25%|██▌       | 27/108 [00:02<00:08, 10.00it/s, loss=22.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  26%|██▌       | 28/108 [00:02<00:07, 10.13it/s, loss=22.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  27%|██▋       | 29/108 [00:02<00:07, 10.24it/s, loss=22.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  27%|██▋       | 29/108 [00:02<00:07, 10.23it/s, loss=22.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  28%|██▊       | 30/108 [00:02<00:07, 10.35it/s, loss=22.2, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  29%|██▊       | 31/108 [00:02<00:07, 10.47it/s, loss=22.2, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  29%|██▊       | 31/108 [00:02<00:07, 10.47it/s, loss=21.8, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  30%|██▉       | 32/108 [00:03<00:07, 10.58it/s, loss=21.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  31%|███       | 33/108 [00:03<00:07, 10.68it/s, loss=21.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  31%|███       | 33/108 [00:03<00:07, 10.67it/s, loss=21.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  31%|███▏      | 34/108 [00:03<00:06, 10.78it/s, loss=21, v_num=1hqf, em_score=0.000, f1_score=0.000]  
Epoch 0:  32%|███▏      | 35/108 [00:03<00:06, 10.88it/s, loss=21, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  32%|███▏      | 35/108 [00:03<00:06, 10.88it/s, loss=20.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  33%|███▎      | 36/108 [00:03<00:06, 10.97it/s, loss=20.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  34%|███▍      | 37/108 [00:03<00:06, 11.06it/s, loss=20.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  34%|███▍      | 37/108 [00:03<00:06, 11.05it/s, loss=20.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  35%|███▌      | 38/108 [00:03<00:06, 11.15it/s, loss=20.2, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  36%|███▌      | 39/108 [00:03<00:06, 11.24it/s, loss=20.2, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  36%|███▌      | 39/108 [00:03<00:06, 11.24it/s, loss=20, v_num=1hqf, em_score=0.000, f1_score=0.000]  
Epoch 0:  37%|███▋      | 40/108 [00:03<00:06, 11.32it/s, loss=19.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  38%|███▊      | 41/108 [00:03<00:05, 11.41it/s, loss=19.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  38%|███▊      | 41/108 [00:03<00:05, 11.41it/s, loss=19.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  39%|███▉      | 42/108 [00:03<00:05, 11.49it/s, loss=19.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  40%|███▉      | 43/108 [00:03<00:05, 11.56it/s, loss=19.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  40%|███▉      | 43/108 [00:03<00:05, 11.56it/s, loss=19.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  41%|████      | 44/108 [00:03<00:05, 11.63it/s, loss=18.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  42%|████▏     | 45/108 [00:03<00:05, 11.70it/s, loss=18.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  42%|████▏     | 45/108 [00:03<00:05, 11.70it/s, loss=18.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  43%|████▎     | 46/108 [00:03<00:05, 11.77it/s, loss=18.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  44%|████▎     | 47/108 [00:03<00:05, 11.85it/s, loss=18.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  44%|████▎     | 47/108 [00:03<00:05, 11.84it/s, loss=18.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  44%|████▍     | 48/108 [00:04<00:05, 11.91it/s, loss=18.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  45%|████▌     | 49/108 [00:04<00:04, 11.97it/s, loss=18.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  45%|████▌     | 49/108 [00:04<00:04, 11.97it/s, loss=17.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  46%|████▋     | 50/108 [00:04<00:04, 12.03it/s, loss=17.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  47%|████▋     | 51/108 [00:04<00:04, 12.08it/s, loss=17.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  47%|████▋     | 51/108 [00:04<00:04, 12.08it/s, loss=17.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  48%|████▊     | 52/108 [00:04<00:04, 12.15it/s, loss=17.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  49%|████▉     | 53/108 [00:04<00:04, 12.21it/s, loss=17.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  49%|████▉     | 53/108 [00:04<00:04, 12.20it/s, loss=17.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  50%|█████     | 54/108 [00:04<00:04, 12.26it/s, loss=17.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  51%|█████     | 55/108 [00:04<00:04, 12.32it/s, loss=17.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  51%|█████     | 55/108 [00:04<00:04, 12.32it/s, loss=16.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  52%|█████▏    | 56/108 [00:04<00:04, 12.38it/s, loss=16.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  53%|█████▎    | 57/108 [00:04<00:04, 12.44it/s, loss=16.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  53%|█████▎    | 57/108 [00:04<00:04, 12.44it/s, loss=16.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  54%|█████▎    | 58/108 [00:04<00:03, 12.50it/s, loss=16.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  55%|█████▍    | 59/108 [00:04<00:03, 12.57it/s, loss=16.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  55%|█████▍    | 59/108 [00:04<00:03, 12.57it/s, loss=16.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  56%|█████▌    | 60/108 [00:04<00:03, 12.63it/s, loss=16.2, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  56%|█████▋    | 61/108 [00:04<00:03, 12.70it/s, loss=16.2, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  56%|█████▋    | 61/108 [00:04<00:03, 12.70it/s, loss=16, v_num=1hqf, em_score=0.000, f1_score=0.000]  
Epoch 0:  57%|█████▋    | 62/108 [00:04<00:03, 12.76it/s, loss=15.8, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  58%|█████▊    | 63/108 [00:04<00:03, 12.81it/s, loss=15.8, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  58%|█████▊    | 63/108 [00:04<00:03, 12.81it/s, loss=15.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  59%|█████▉    | 64/108 [00:04<00:03, 12.87it/s, loss=15.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  60%|██████    | 65/108 [00:05<00:03, 12.92it/s, loss=15.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  60%|██████    | 65/108 [00:05<00:03, 12.92it/s, loss=15.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  61%|██████    | 66/108 [00:05<00:03, 12.96it/s, loss=15.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  62%|██████▏   | 67/108 [00:05<00:03, 13.00it/s, loss=15.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  62%|██████▏   | 67/108 [00:05<00:03, 13.00it/s, loss=15.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  63%|██████▎   | 68/108 [00:05<00:03, 13.03it/s, loss=15, v_num=1hqf, em_score=0.000, f1_score=0.000]  
Epoch 0:  64%|██████▍   | 69/108 [00:05<00:02, 13.07it/s, loss=15, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  64%|██████▍   | 69/108 [00:05<00:02, 13.06it/s, loss=14.8, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  65%|██████▍   | 70/108 [00:05<00:02, 13.09it/s, loss=14.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  66%|██████▌   | 71/108 [00:05<00:02, 13.12it/s, loss=14.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  66%|██████▌   | 71/108 [00:05<00:02, 13.12it/s, loss=14.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  67%|██████▋   | 72/108 [00:05<00:02, 13.15it/s, loss=14.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  68%|██████▊   | 73/108 [00:05<00:02, 13.18it/s, loss=14.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  68%|██████▊   | 73/108 [00:05<00:02, 13.18it/s, loss=14.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  69%|██████▊   | 74/108 [00:05<00:02, 13.20it/s, loss=14.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  69%|██████▉   | 75/108 [00:05<00:02, 13.23it/s, loss=14.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  69%|██████▉   | 75/108 [00:05<00:02, 13.23it/s, loss=14.2, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  70%|███████   | 76/108 [00:05<00:02, 13.25it/s, loss=14.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  71%|███████▏  | 77/108 [00:05<00:02, 13.28it/s, loss=14.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  71%|███████▏  | 77/108 [00:05<00:02, 13.28it/s, loss=14, v_num=1hqf, em_score=0.000, f1_score=0.000]  
Epoch 0:  72%|███████▏  | 78/108 [00:05<00:02, 13.31it/s, loss=13.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  73%|███████▎  | 79/108 [00:05<00:02, 13.33it/s, loss=13.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  73%|███████▎  | 79/108 [00:05<00:02, 13.33it/s, loss=13.7, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  74%|███████▍  | 80/108 [00:05<00:02, 13.36it/s, loss=13.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  75%|███████▌  | 81/108 [00:06<00:02, 13.39it/s, loss=13.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  75%|███████▌  | 81/108 [00:06<00:02, 13.38it/s, loss=13.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  76%|███████▌  | 82/108 [00:06<00:01, 13.41it/s, loss=13.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  77%|███████▋  | 83/108 [00:06<00:01, 13.44it/s, loss=13.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  77%|███████▋  | 83/108 [00:06<00:01, 13.44it/s, loss=13.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  78%|███████▊  | 84/108 [00:06<00:01, 13.46it/s, loss=13.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  79%|███████▊  | 85/108 [00:06<00:01, 13.49it/s, loss=13.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  79%|███████▊  | 85/108 [00:06<00:01, 13.49it/s, loss=13.2, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  80%|███████▉  | 86/108 [00:06<00:01, 13.51it/s, loss=13.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  81%|████████  | 87/108 [00:06<00:01, 13.54it/s, loss=13.1, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  81%|████████  | 87/108 [00:06<00:01, 13.54it/s, loss=13, v_num=1hqf, em_score=0.000, f1_score=0.000]  
Epoch 0:  81%|████████▏ | 88/108 [00:06<00:01, 13.56it/s, loss=12.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  82%|████████▏ | 89/108 [00:06<00:01, 13.58it/s, loss=12.9, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  82%|████████▏ | 89/108 [00:06<00:01, 13.58it/s, loss=12.8, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  83%|████████▎ | 90/108 [00:06<00:01, 13.61it/s, loss=12.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  84%|████████▍ | 91/108 [00:06<00:01, 13.63it/s, loss=12.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  84%|████████▍ | 91/108 [00:06<00:01, 13.63it/s, loss=12.6, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  85%|████████▌ | 92/108 [00:06<00:01, 13.66it/s, loss=12.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  86%|████████▌ | 93/108 [00:06<00:01, 13.68it/s, loss=12.5, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  86%|████████▌ | 93/108 [00:06<00:01, 13.68it/s, loss=12.4, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  87%|████████▋ | 94/108 [00:06<00:01, 13.43it/s, loss=12.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Epoch 0:  88%|████████▊ | 95/108 [00:07<00:00, 13.55it/s, loss=12.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Validating: 0it [00:00, ?it/s][A
Validating:   0%|          | 0/14 [00:00<?, ?it/s][A
Validating:   7%|▋         | 1/14 [00:02<00:29,  2.27s/it][A
Validating:  14%|█▍        | 2/14 [00:03<00:20,  1.69s/it][A
Epoch 0:  90%|████████▉ | 97/108 [00:10<00:01,  9.17it/s, loss=12.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Validating:  21%|██▏       | 3/14 [00:04<00:16,  1.52s/it][A
Validating:  29%|██▊       | 4/14 [00:06<00:14,  1.43s/it][A
Epoch 0:  92%|█████████▏| 99/108 [00:13<00:01,  7.52it/s, loss=12.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Validating:  36%|███▌      | 5/14 [00:07<00:12,  1.38s/it][A
Validating:  43%|████▎     | 6/14 [00:08<00:10,  1.36s/it][A
Epoch 0:  94%|█████████▎| 101/108 [00:15<00:01,  6.40it/s, loss=12.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Validating:  50%|█████     | 7/14 [00:10<00:09,  1.34s/it][A
Validating:  57%|█████▋    | 8/14 [00:11<00:07,  1.33s/it][A
Epoch 0:  95%|█████████▌| 103/108 [00:18<00:00,  5.60it/s, loss=12.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Validating:  64%|██████▍   | 9/14 [00:12<00:06,  1.32s/it][A
Validating:  71%|███████▏  | 10/14 [00:13<00:05,  1.31s/it][A
Epoch 0:  97%|█████████▋| 105/108 [00:21<00:00,  5.00it/s, loss=12.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Validating:  79%|███████▊  | 11/14 [00:15<00:03,  1.31s/it][A
Validating:  86%|████████▌ | 12/14 [00:16<00:02,  1.31s/it][A
Epoch 0:  99%|█████████▉| 107/108 [00:23<00:00,  4.53it/s, loss=12.3, v_num=1hqf, em_score=0.000, f1_score=0.000]
Validating:  93%|█████████▎| 13/14 [00:17<00:01,  1.31s/it][Aslurmstepd: error: *** JOB 6033515 ON g3040 CANCELLED AT 2022-08-31T16:21:22 ***
