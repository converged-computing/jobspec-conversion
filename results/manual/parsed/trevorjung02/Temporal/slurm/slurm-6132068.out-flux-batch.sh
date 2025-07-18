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
python evaluate_yearly.py --config configs/templama/training/t5_kadapters_yearly_2freeze.json--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220909_131602-3ujaxwlg
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_2010
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/3ujaxwlg
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapter_2010_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=False, checkpoint_dir='outputs/', checkpoint_path='', dataset='templama', dataset_version='2010', early_stop_callback=False, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.003, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=120, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_2010_2freeze_158_128', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data=None, wandb_log=True, warmup_steps=0, weight_decay=0.0)
outputs/kadapter_2010_0freeze_158_128
exists
outputs/kadapter_2010_1freeze_158_128
checkpoint path = outputs/kadapter_2010_0freeze_158_128/epoch=16-f1_score=0.169-em_score=0.063.ckpt
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
split is 0
Length of dataset retrieving is.. 410
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/13 [00:00<?, ?it/s]
Validating:   8%|▊         | 1/13 [00:01<00:21,  1.76s/it]
Validating:  15%|█▌        | 2/13 [00:02<00:12,  1.12s/it]
Validating:  23%|██▎       | 3/13 [00:03<00:09,  1.09it/s]
Validating:  31%|███       | 4/13 [00:03<00:07,  1.16it/s]
Validating:  38%|███▊      | 5/13 [00:04<00:06,  1.23it/s]
Validating:  46%|████▌     | 6/13 [00:05<00:05,  1.32it/s]
Validating:  54%|█████▍    | 7/13 [00:05<00:04,  1.35it/s]
Validating:  62%|██████▏   | 8/13 [00:06<00:04,  1.21it/s]
Validating:  69%|██████▉   | 9/13 [00:07<00:03,  1.27it/s]
Validating:  77%|███████▋  | 10/13 [00:08<00:02,  1.31it/s]
Validating:  85%|████████▍ | 11/13 [00:09<00:01,  1.31it/s]
Validating:  92%|█████████▏| 12/13 [00:09<00:00,  1.35it/s]
Validating: 100%|██████████| 13/13 [00:10<00:00,  1.45it/s]
                                                           Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.043902438133955, 'f1_score': 0.15377283096313477}
--------------------------------------------------------------------------------
split is 0
Length of dataset retrieving is.. 410
[(0.043902438133955, 0.15377283096313477, 410)]
outputs/kadapter_2011_0freeze_158_128
exists
outputs/kadapter_2011_1freeze_158_128
exists
checkpoint path = outputs/kadapter_2011_1freeze_158_128/epoch=29-f1_score=0.194-em_score=0.074.ckpt
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
split is 0
Length of dataset retrieving is.. 431
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/14 [00:00<?, ?it/s]
Validating:   7%|▋         | 1/14 [00:01<00:24,  1.85s/it]
Validating:  14%|█▍        | 2/14 [00:02<00:16,  1.37s/it]
Validating:  21%|██▏       | 3/14 [00:03<00:13,  1.22s/it]
Validating:  29%|██▊       | 4/14 [00:04<00:11,  1.16s/it]
Validating:  36%|███▌      | 5/14 [00:06<00:10,  1.14s/it]
Validating:  43%|████▎     | 6/14 [00:07<00:08,  1.11s/it]
Validating:  50%|█████     | 7/14 [00:08<00:07,  1.09s/it]
Validating:  57%|█████▋    | 8/14 [00:09<00:06,  1.08s/it]
Validating:  64%|██████▍   | 9/14 [00:10<00:05,  1.06s/it]
Validating:  71%|███████▏  | 10/14 [00:11<00:04,  1.07s/it]
Validating:  79%|███████▊  | 11/14 [00:12<00:03,  1.05s/it]
Validating:  86%|████████▌ | 12/14 [00:13<00:02,  1.04s/it]
Validating:  93%|█████████▎| 13/14 [00:14<00:01,  1.04s/it]
Validating: 100%|██████████| 14/14 [00:15<00:00,  1.08it/s]
                                                           Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.009280742146074772, 'f1_score': 0.12425388395786285}
--------------------------------------------------------------------------------
split is 0
Length of dataset retrieving is.. 431
[(0.043902438133955, 0.15377283096313477, 410), (0.009280742146074772, 0.12425388395786285, 431)]
outputs/kadapter_2012_0freeze_158_128
exists
outputs/kadapter_2012_1freeze_158_128
exists
checkpoint path = outputs/kadapter_2012_0freeze_158_128/epoch=13-f1_score=0.189-em_score=0.065.ckpt
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
split is 0
Length of dataset retrieving is.. 446
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/14 [00:00<?, ?it/s]
Validating:   7%|▋         | 1/14 [00:01<00:20,  1.56s/it]
Validating:  14%|█▍        | 2/14 [00:02<00:13,  1.11s/it]
Validating:  21%|██▏       | 3/14 [00:03<00:10,  1.06it/s]
Validating:  29%|██▊       | 4/14 [00:03<00:08,  1.14it/s]
Validating:  36%|███▌      | 5/14 [00:04<00:07,  1.16it/s]
Validating:  43%|████▎     | 6/14 [00:05<00:06,  1.19it/s]
Validating:  50%|█████     | 7/14 [00:06<00:05,  1.24it/s]
Validating:  57%|█████▋    | 8/14 [00:07<00:05,  1.20it/s]
Validating:  64%|██████▍   | 9/14 [00:07<00:04,  1.24it/s]
Validating:  71%|███████▏  | 10/14 [00:08<00:03,  1.19it/s]
Validating:  79%|███████▊  | 11/14 [00:09<00:02,  1.21it/s]
Validating:  86%|████████▌ | 12/14 [00:10<00:01,  1.25it/s]
Validating:  93%|█████████▎| 13/14 [00:11<00:00,  1.28it/s]
Validating: 100%|██████████| 14/14 [00:11<00:00,  1.30it/s]
                                                           Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.04708520323038101, 'f1_score': 0.18699949979782104}
--------------------------------------------------------------------------------
split is 0
Length of dataset retrieving is.. 446
[(0.043902438133955, 0.15377283096313477, 410), (0.009280742146074772, 0.12425388395786285, 431), (0.04708520323038101, 0.18699949979782104, 446)]
outputs/kadapter_2013_0freeze_158_128
exists
outputs/kadapter_2013_1freeze_158_128
exists
checkpoint path = outputs/kadapter_2013_1freeze_158_128/epoch=8-f1_score=0.174-em_score=0.051.ckpt
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
split is 0
Length of dataset retrieving is.. 455
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/15 [00:00<?, ?it/s]
Validating:   7%|▋         | 1/15 [00:01<00:22,  1.59s/it]
Validating:  13%|█▎        | 2/15 [00:02<00:13,  1.07s/it]
Validating:  20%|██        | 3/15 [00:03<00:11,  1.06it/s]
Validating:  27%|██▋       | 4/15 [00:03<00:09,  1.13it/s]
Validating:  33%|███▎      | 5/15 [00:04<00:08,  1.13it/s]
Validating:  40%|████      | 6/15 [00:05<00:07,  1.18it/s]
Validating:  47%|████▋     | 7/15 [00:06<00:06,  1.23it/s]
Validating:  53%|█████▎    | 8/15 [00:07<00:05,  1.22it/s]
Validating:  60%|██████    | 9/15 [00:07<00:04,  1.23it/s]
Validating:  67%|██████▋   | 10/15 [00:08<00:04,  1.22it/s]
Validating:  73%|███████▎  | 11/15 [00:09<00:03,  1.26it/s]
Validating:  80%|████████  | 12/15 [00:10<00:02,  1.24it/s]
Validating:  87%|████████▋ | 13/15 [00:11<00:01,  1.26it/s]
Validating:  93%|█████████▎| 14/15 [00:11<00:00,  1.23it/s]
Validating: 100%|██████████| 15/15 [00:12<00:00,  1.52it/s]
                                                           Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.03956044092774391, 'f1_score': 0.1697094440460205}
--------------------------------------------------------------------------------
split is 0
Length of dataset retrieving is.. 455
[(0.043902438133955, 0.15377283096313477, 410), (0.009280742146074772, 0.12425388395786285, 431), (0.04708520323038101, 0.18699949979782104, 446), (0.03956044092774391, 0.1697094440460205, 455)]
outputs/kadapter_2014_0freeze_158_128
exists
outputs/kadapter_2014_1freeze_158_128
exists
checkpoint path = outputs/kadapter_2014_0freeze_158_128/epoch=28-f1_score=0.174-em_score=0.077.ckpt
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
split is 0
Length of dataset retrieving is.. 469
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/15 [00:00<?, ?it/s]
Validating:   7%|▋         | 1/15 [00:01<00:26,  1.89s/it]
Validating:  13%|█▎        | 2/15 [00:02<00:18,  1.39s/it]
Validating:  20%|██        | 3/15 [00:03<00:14,  1.23s/it]
Validating:  27%|██▋       | 4/15 [00:05<00:12,  1.16s/it]
Validating:  33%|███▎      | 5/15 [00:06<00:11,  1.14s/it]
Validating:  40%|████      | 6/15 [00:07<00:10,  1.12s/it]
Validating:  47%|████▋     | 7/15 [00:08<00:08,  1.09s/it]
Validating:  53%|█████▎    | 8/15 [00:09<00:07,  1.09s/it]
Validating:  60%|██████    | 9/15 [00:10<00:06,  1.09s/it]
Validating:  67%|██████▋   | 10/15 [00:11<00:05,  1.10s/it]
Validating:  73%|███████▎  | 11/15 [00:12<00:04,  1.10s/it]
Validating:  80%|████████  | 12/15 [00:13<00:03,  1.08s/it]
Validating:  87%|████████▋ | 13/15 [00:14<00:02,  1.07s/it]
Validating:  93%|█████████▎| 14/15 [00:15<00:01,  1.07s/it]
Validating: 100%|██████████| 15/15 [00:16<00:00,  1.00s/it]
                                                           Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.004264392424374819, 'f1_score': 0.11998766660690308}
--------------------------------------------------------------------------------
split is 0
Length of dataset retrieving is.. 469
[(0.043902438133955, 0.15377283096313477, 410), (0.009280742146074772, 0.12425388395786285, 431), (0.04708520323038101, 0.18699949979782104, 446), (0.03956044092774391, 0.1697094440460205, 455), (0.004264392424374819, 0.11998766660690308, 469)]
outputs/kadapter_2015_0freeze_158_128
exists
outputs/kadapter_2015_1freeze_158_128
exists
checkpoint path = outputs/kadapter_2015_0freeze_158_128/epoch=25-f1_score=0.184-em_score=0.065.ckpt
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
split is 0
Length of dataset retrieving is.. 479
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/15 [00:00<?, ?it/s]
Validating:   7%|▋         | 1/15 [00:01<00:20,  1.49s/it]
Validating:  13%|█▎        | 2/15 [00:02<00:13,  1.05s/it]
Validating:  20%|██        | 3/15 [00:03<00:11,  1.07it/s]
Validating:  27%|██▋       | 4/15 [00:03<00:09,  1.11it/s]
Validating:  33%|███▎      | 5/15 [00:04<00:08,  1.17it/s]
Validating:  40%|████      | 6/15 [00:05<00:07,  1.22it/s]
Validating:  47%|████▋     | 7/15 [00:06<00:06,  1.25it/s]
Validating:  53%|█████▎    | 8/15 [00:06<00:05,  1.28it/s]
Validating:  60%|██████    | 9/15 [00:07<00:04,  1.30it/s]
Validating:  67%|██████▋   | 10/15 [00:08<00:03,  1.29it/s]
Validating:  73%|███████▎  | 11/15 [00:09<00:03,  1.31it/s]
Validating:  80%|████████  | 12/15 [00:09<00:02,  1.29it/s]
Validating:  87%|████████▋ | 13/15 [00:10<00:01,  1.20it/s]
Validating:  93%|█████████▎| 14/15 [00:11<00:00,  1.25it/s]
Validating: 100%|██████████| 15/15 [00:12<00:00,  1.30it/s]
                                                           Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.04801670089364052, 'f1_score': 0.16759240627288818}
--------------------------------------------------------------------------------
split is 0
Length of dataset retrieving is.. 479
[(0.043902438133955, 0.15377283096313477, 410), (0.009280742146074772, 0.12425388395786285, 431), (0.04708520323038101, 0.18699949979782104, 446), (0.03956044092774391, 0.1697094440460205, 455), (0.004264392424374819, 0.11998766660690308, 469), (0.04801670089364052, 0.16759240627288818, 479)]
outputs/kadapter_2016_0freeze_158_128
exists
outputs/kadapter_2016_1freeze_158_128
exists
checkpoint path = outputs/kadapter_2016_1freeze_158_128/epoch=20-f1_score=0.178-em_score=0.062.ckpt
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
split is 0
Length of dataset retrieving is.. 480
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/15 [00:00<?, ?it/s]
Validating:   7%|▋         | 1/15 [00:01<00:23,  1.71s/it]
Validating:  13%|█▎        | 2/15 [00:02<00:15,  1.21s/it]
Validating:  20%|██        | 3/15 [00:03<00:11,  1.01it/s]
Validating:  27%|██▋       | 4/15 [00:04<00:10,  1.08it/s]
Validating:  33%|███▎      | 5/15 [00:04<00:08,  1.16it/s]
Validating:  40%|████      | 6/15 [00:05<00:07,  1.24it/s]
Validating:  47%|████▋     | 7/15 [00:06<00:06,  1.23it/s]
Validating:  53%|█████▎    | 8/15 [00:07<00:05,  1.21it/s]
Validating:  60%|██████    | 9/15 [00:08<00:04,  1.21it/s]
Validating:  67%|██████▋   | 10/15 [00:08<00:04,  1.25it/s]
Validating:  73%|███████▎  | 11/15 [00:09<00:03,  1.28it/s]
Validating:  80%|████████  | 12/15 [00:10<00:02,  1.28it/s]
Validating:  87%|████████▋ | 13/15 [00:11<00:01,  1.29it/s]
Validating:  93%|█████████▎| 14/15 [00:11<00:00,  1.28it/s]
Validating: 100%|██████████| 15/15 [00:12<00:00,  1.23it/s]
                                                           Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.05624999850988388, 'f1_score': 0.15832525491714478}
--------------------------------------------------------------------------------
split is 0
Length of dataset retrieving is.. 480
[(0.043902438133955, 0.15377283096313477, 410), (0.009280742146074772, 0.12425388395786285, 431), (0.04708520323038101, 0.18699949979782104, 446), (0.03956044092774391, 0.1697094440460205, 455), (0.004264392424374819, 0.11998766660690308, 469), (0.04801670089364052, 0.16759240627288818, 479), (0.05624999850988388, 0.15832525491714478, 480)]
outputs/kadapter_2017_0freeze_158_128
exists
outputs/kadapter_2017_1freeze_158_128
exists
checkpoint path = outputs/kadapter_2017_0freeze_158_128/epoch=24-f1_score=0.177-em_score=0.069.ckpt
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
split is 0
Length of dataset retrieving is.. 481
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/16 [00:00<?, ?it/s]
Validating:   6%|▋         | 1/16 [00:01<00:28,  1.91s/it]
Validating:  12%|█▎        | 2/16 [00:03<00:20,  1.45s/it]
Validating:  19%|█▉        | 3/16 [00:04<00:16,  1.27s/it]
Validating:  25%|██▌       | 4/16 [00:05<00:14,  1.19s/it]
Validating:  31%|███▏      | 5/16 [00:06<00:12,  1.15s/it]
Validating:  38%|███▊      | 6/16 [00:07<00:11,  1.12s/it]
Validating:  44%|████▍     | 7/16 [00:08<00:09,  1.11s/it]
Validating:  50%|█████     | 8/16 [00:09<00:08,  1.10s/it]
Validating:  56%|█████▋    | 9/16 [00:10<00:07,  1.08s/it]
Validating:  62%|██████▎   | 10/16 [00:11<00:06,  1.08s/it]
Validating:  69%|██████▉   | 11/16 [00:12<00:05,  1.06s/it]
Validating:  75%|███████▌  | 12/16 [00:13<00:04,  1.07s/it]
Validating:  81%|████████▏ | 13/16 [00:14<00:03,  1.07s/it]
Validating:  88%|████████▊ | 14/16 [00:15<00:02,  1.06s/it]
Validating:  94%|█████████▍| 15/16 [00:16<00:01,  1.06s/it]
Validating: 100%|██████████| 16/16 [00:17<00:00,  1.19it/s]
                                                           Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.014553014189004898, 'f1_score': 0.13066820800304413}
--------------------------------------------------------------------------------
split is 0
Length of dataset retrieving is.. 481
[(0.043902438133955, 0.15377283096313477, 410), (0.009280742146074772, 0.12425388395786285, 431), (0.04708520323038101, 0.18699949979782104, 446), (0.03956044092774391, 0.1697094440460205, 455), (0.004264392424374819, 0.11998766660690308, 469), (0.04801670089364052, 0.16759240627288818, 479), (0.05624999850988388, 0.15832525491714478, 480), (0.014553014189004898, 0.13066820800304413, 481)]
outputs/kadapter_2018_0freeze_158_128
exists
outputs/kadapter_2018_1freeze_158_128
exists
checkpoint path = outputs/kadapter_2018_0freeze_158_128/epoch=19-f1_score=0.160-em_score=0.051.ckpt
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
split is 0
Length of dataset retrieving is.. 473
Validating: 0it [00:00, ?it/s]
Validating:   0%|          | 0/15 [00:00<?, ?it/s]
Validating:   7%|▋         | 1/15 [00:01<00:24,  1.75s/it]
Validating:  13%|█▎        | 2/15 [00:02<00:14,  1.15s/it]
Validating:  20%|██        | 3/15 [00:03<00:11,  1.06it/s]
Validating:  27%|██▋       | 4/15 [00:03<00:09,  1.16it/s]
Validating:  33%|███▎      | 5/15 [00:04<00:08,  1.14it/s]
Validating:  40%|████      | 6/15 [00:05<00:07,  1.20it/s]
Validating:  47%|████▋     | 7/15 [00:06<00:06,  1.27it/s]
Validating:  53%|█████▎    | 8/15 [00:06<00:05,  1.30it/s]
Validating:  60%|██████    | 9/15 [00:07<00:04,  1.30it/s]
Validating:  67%|██████▋   | 10/15 [00:08<00:03,  1.32it/s]
Validating:  73%|███████▎  | 11/15 [00:09<00:02,  1.34it/s]
Validating:  80%|████████  | 12/15 [00:09<00:02,  1.37it/s]
Validating:  87%|████████▋ | 13/15 [00:10<00:01,  1.39it/s]
Validating:  93%|█████████▎| 14/15 [00:11<00:00,  1.37it/s]
Validating: 100%|██████████| 15/15 [00:11<00:00,  1.43it/s]
--------------------------------------------------------------------------------
DATALOADER:0 VALIDATE RESULTS
{'em_score': 0.033826638013124466, 'f1_score': 0.1442844271659851}
--------------------------------------------------------------------------------
split is 0
Length of dataset retrieving is.. 473
[(0.043902438133955, 0.15377283096313477, 410), (0.009280742146074772, 0.12425388395786285, 431), (0.04708520323038101, 0.18699949979782104, 446), (0.03956044092774391, 0.1697094440460205, 455), (0.004264392424374819, 0.11998766660690308, 469), (0.04801670089364052, 0.16759240627288818, 479), (0.05624999850988388, 0.15832525491714478, 480), (0.014553014189004898, 0.13066820800304413, 481), (0.033826638013124466, 0.1442844271659851, 473)]
weighted_em = 0.03297769142281821
weighted_f1 = 0.1505492001294974
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.899 MB of 0.948 MB uploaded (0.000 MB deduped)
wandb: \ 0.948 MB of 0.948 MB uploaded (0.000 MB deduped)
wandb: | 0.948 MB of 0.948 MB uploaded (0.000 MB deduped)
wandb: / 0.948 MB of 0.998 MB uploaded (0.000 MB deduped)
wandb: - 0.948 MB of 0.998 MB uploaded (0.000 MB deduped)
wandb: \ 0.998 MB of 0.998 MB uploaded (0.000 MB deduped)
wandb: | 0.998 MB of 0.998 MB uploaded (0.000 MB deduped)
wandb: / 0.998 MB of 0.998 MB uploaded (0.000 MB deduped)
wandb: - 0.998 MB of 0.998 MB uploaded (0.000 MB deduped)
wandb: \ 0.998 MB of 0.998 MB uploaded (0.000 MB deduped)
wandb: | 0.998 MB of 0.998 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: 
wandb: Run history:
wandb:            em_score ▆▂▇▆▁▇█▂▅
wandb:               epoch ▁▁▁▁▁▁▁▁▁
wandb:            f1_score ▅▁█▆▁▆▅▂▄
wandb:            total_em ▁
wandb:            total_f1 ▁
wandb: trainer/global_step ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
wandb: 
wandb: Run summary:
wandb:               epoch 0
wandb:            total_em 0.03298
wandb:            total_f1 0.15055
wandb: trainer/global_step 0
wandb: 
wandb: Synced kadapter_2010: https://wandb.ai/tjung2/temporal_questions/runs/3ujaxwlg
wandb: Synced 6 W&B file(s), 9 media file(s), 9 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220909_131602-3ujaxwlg/logs
