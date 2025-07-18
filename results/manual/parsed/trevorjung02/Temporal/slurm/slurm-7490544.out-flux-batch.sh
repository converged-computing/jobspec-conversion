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
python run.py --config configs/wmt/training/t5_kadapters_yearly256.json
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.5 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20221115_035847-1icqwhee
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_2010
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/1icqwhee
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/wmtkadapter_2010_2freeze_11218192021222324_256 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-large-ssm and are newly initialized: ['enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.8.down_project.bias', 'enc_kadapter.adapter.3.down_project.weight', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.8.up_project.bias', 'enc_kadapter.adapter.6.down_project.bias', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.6.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.7.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.3.up_project.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.adapter.7.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.7.down_project.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.5.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.5.up_project.weight', 'enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.8.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.3.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.6.up_project.bias', 'enc_kadapter.adapter.8.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.4.down_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.7.down_project.bias', 'enc_kadapter.adapter.7.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.8.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.4.up_project.bias', 'enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.4.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.4.down_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.6.down_project.weight', 'enc_kadapter.adapter.4.up_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.7.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.5.down_project.bias', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.3.up_project.weight', 'enc_kadapter.adapter.8.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.7.encoder.layer.1.layer_norm.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.5.down_project.weight', 'enc_kadapter.adapter.8.up_project.weight', 'enc_kadapter.adapter.6.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.3.down_project.bias', 'enc_kadapter.adapter.6.up_project.weight', 'enc_kadapter.adapter.4.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.6.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.5.up_project.bias', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.5.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.7.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.6.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.3.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.8.down_project.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Set SLURM handle signals.
  | Name  | Type                       | Params
-----------------------------------------------------
0 | model | T5ForConditionalGeneration | 770 M 
-----------------------------------------------------
33.1 M    Trainable params
737 M     Non-trainable params
770 M     Total params
3,082.880 Total estimated model params size (MB)
checkpoint path = outputs/wmtbaseline_full/epoch=0-f1_score=0.2586-em_score=0.2194.ckpt
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 12, 18, 19, 20, 21, 22, 23, 24], 'adapter_hidden_size': 256, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=256, adapter_list=[1, 12, 18, 19, 20, 21, 22, 23, 24], check_validation_only=False, checkpoint_dir='outputs/wmtbaseline_full', checkpoint_path='outputs/wmtbaseline_full/epoch=0-f1_score=0.2586-em_score=0.2194.ckpt', dataset='wmt', dataset_version='2010', early_stop_callback=False, eval_batch_size=32, find_lr=False, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=100, max_output_length=50, method='kadapter', mode='pretrain', model_name_or_path='google/t5-large-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=1, num_workers=4, opt_level='O1', output_dir='outputs/wmtkadapter_2010_2freeze_11218192021222324_256', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-large-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=False, val_check_interval=500, val_data='2010', wandb_log=True, warmup_steps=0, weight_decay=0.0)
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
  "adapter_hidden_size": 256,
  "adapter_list": [
    1,
    12,
    18,
    19,
    20,
    21,
    22,
    23,
    24
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
enc_kadapter.layer_norm.weight
enc_kadapter.adapter.0.down_project.weight
enc_kadapter.adapter.0.down_project.bias
enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight
enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight
enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight
enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight
enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight
enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight
enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi.weight
enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight
enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight
enc_kadapter.adapter.0.up_project.weight
enc_kadapter.adapter.0.up_project.bias
enc_kadapter.adapter.1.down_project.weight
enc_kadapter.adapter.1.down_project.bias
enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight
enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight
enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight
enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight
enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight
enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight
enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi.weight
enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight
enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight
enc_kadapter.adapter.1.up_project.weight
enc_kadapter.adapter.1.up_project.bias
enc_kadapter.adapter.2.down_project.weight
enc_kadapter.adapter.2.down_project.bias
enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight
enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight
enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight
enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight
enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight
enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight
enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi.weight
enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight
enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight
enc_kadapter.adapter.2.up_project.weight
enc_kadapter.adapter.2.up_project.bias
enc_kadapter.adapter.3.down_project.weight
enc_kadapter.adapter.3.down_project.bias
enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.q.weight
enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.k.weight
enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.v.weight
enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.o.weight
enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight
enc_kadapter.adapter.3.encoder.layer.0.layer_norm.weight
enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wi.weight
enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wo.weight
enc_kadapter.adapter.3.encoder.layer.1.layer_norm.weight
enc_kadapter.adapter.3.up_project.weight
enc_kadapter.adapter.3.up_project.bias
enc_kadapter.adapter.4.down_project.weight
enc_kadapter.adapter.4.down_project.bias
enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.q.weight
enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.k.weight
enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.v.weight
enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.o.weight
enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight
enc_kadapter.adapter.4.encoder.layer.0.layer_norm.weight
enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wi.weight
enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wo.weight
enc_kadapter.adapter.4.encoder.layer.1.layer_norm.weight
enc_kadapter.adapter.4.up_project.weight
enc_kadapter.adapter.4.up_project.bias
enc_kadapter.adapter.5.down_project.weight
enc_kadapter.adapter.5.down_project.bias
enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.q.weight
enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.k.weight
enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.v.weight
enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.o.weight
enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight
enc_kadapter.adapter.5.encoder.layer.0.layer_norm.weight
enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wi.weight
enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wo.weight
enc_kadapter.adapter.5.encoder.layer.1.layer_norm.weight
enc_kadapter.adapter.5.up_project.weight
enc_kadapter.adapter.5.up_project.bias
enc_kadapter.adapter.6.down_project.weight
enc_kadapter.adapter.6.down_project.bias
enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.q.weight
enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.k.weight
enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.v.weight
enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.o.weight
enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight
enc_kadapter.adapter.6.encoder.layer.0.layer_norm.weight
enc_kadapter.adapter.6.encoder.layer.1.DenseReluDense.wi.weight
enc_kadapter.adapter.6.encoder.layer.1.DenseReluDense.wo.weight
enc_kadapter.adapter.6.encoder.layer.1.layer_norm.weight
enc_kadapter.adapter.6.up_project.weight
enc_kadapter.adapter.6.up_project.bias
enc_kadapter.adapter.7.down_project.weight
enc_kadapter.adapter.7.down_project.bias
enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.q.weight
enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.k.weight
enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.v.weight
enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.o.weight
enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight
enc_kadapter.adapter.7.encoder.layer.0.layer_norm.weight
enc_kadapter.adapter.7.encoder.layer.1.DenseReluDense.wi.weight
enc_kadapter.adapter.7.encoder.layer.1.DenseReluDense.wo.weight
enc_kadapter.adapter.7.encoder.layer.1.layer_norm.weight
enc_kadapter.adapter.7.up_project.weight
enc_kadapter.adapter.7.up_project.bias
enc_kadapter.adapter.8.down_project.weight
enc_kadapter.adapter.8.down_project.bias
enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.q.weight
enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.k.weight
enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.v.weight
enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.o.weight
enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight
enc_kadapter.adapter.8.encoder.layer.0.layer_norm.weight
enc_kadapter.adapter.8.encoder.layer.1.DenseReluDense.wi.weight
enc_kadapter.adapter.8.encoder.layer.1.DenseReluDense.wo.weight
enc_kadapter.adapter.8.encoder.layer.1.layer_norm.weight
enc_kadapter.adapter.8.up_project.weight
enc_kadapter.adapter.8.up_project.bias
enc_kadapter.pool.weight
enc_kadapter.pool.bias
odict_keys(['model.shared.weight', 'model.encoder.embed_tokens.weight', 'model.encoder.block.0.layer.0.SelfAttention.q.weight', 'model.encoder.block.0.layer.0.SelfAttention.k.weight', 'model.encoder.block.0.layer.0.SelfAttention.v.weight', 'model.encoder.block.0.layer.0.SelfAttention.o.weight', 'model.encoder.block.0.layer.0.SelfAttention.relative_attention_bias.weight', 'model.encoder.block.0.layer.0.layer_norm.weight', 'model.encoder.block.0.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.0.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.0.layer.1.layer_norm.weight', 'model.encoder.block.1.layer.0.SelfAttention.q.weight', 'model.encoder.block.1.layer.0.SelfAttention.k.weight', 'model.encoder.block.1.layer.0.SelfAttention.v.weight', 'model.encoder.block.1.layer.0.SelfAttention.o.weight', 'model.encoder.block.1.layer.0.layer_norm.weight', 'model.encoder.block.1.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.1.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.1.layer.1.layer_norm.weight', 'model.encoder.block.2.layer.0.SelfAttention.q.weight', 'model.encoder.block.2.layer.0.SelfAttention.k.weight', 'model.encoder.block.2.layer.0.SelfAttention.v.weight', 'model.encoder.block.2.layer.0.SelfAttention.o.weight', 'model.encoder.block.2.layer.0.layer_norm.weight', 'model.encoder.block.2.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.2.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.2.layer.1.layer_norm.weight', 'model.encoder.block.3.layer.0.SelfAttention.q.weight', 'model.encoder.block.3.layer.0.SelfAttention.k.weight', 'model.encoder.block.3.layer.0.SelfAttention.v.weight', 'model.encoder.block.3.layer.0.SelfAttention.o.weight', 'model.encoder.block.3.layer.0.layer_norm.weight', 'model.encoder.block.3.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.3.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.3.layer.1.layer_norm.weight', 'model.encoder.block.4.layer.0.SelfAttention.q.weight', 'model.encoder.block.4.layer.0.SelfAttention.k.weight', 'model.encoder.block.4.layer.0.SelfAttention.v.weight', 'model.encoder.block.4.layer.0.SelfAttention.o.weight', 'model.encoder.block.4.layer.0.layer_norm.weight', 'model.encoder.block.4.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.4.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.4.layer.1.layer_norm.weight', 'model.encoder.block.5.layer.0.SelfAttention.q.weight', 'model.encoder.block.5.layer.0.SelfAttention.k.weight', 'model.encoder.block.5.layer.0.SelfAttention.v.weight', 'model.encoder.block.5.layer.0.SelfAttention.o.weight', 'model.encoder.block.5.layer.0.layer_norm.weight', 'model.encoder.block.5.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.5.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.5.layer.1.layer_norm.weight', 'model.encoder.block.6.layer.0.SelfAttention.q.weight', 'model.encoder.block.6.layer.0.SelfAttention.k.weight', 'model.encoder.block.6.layer.0.SelfAttention.v.weight', 'model.encoder.block.6.layer.0.SelfAttention.o.weight', 'model.encoder.block.6.layer.0.layer_norm.weight', 'model.encoder.block.6.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.6.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.6.layer.1.layer_norm.weight', 'model.encoder.block.7.layer.0.SelfAttention.q.weight', 'model.encoder.block.7.layer.0.SelfAttention.k.weight', 'model.encoder.block.7.layer.0.SelfAttention.v.weight', 'model.encoder.block.7.layer.0.SelfAttention.o.weight', 'model.encoder.block.7.layer.0.layer_norm.weight', 'model.encoder.block.7.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.7.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.7.layer.1.layer_norm.weight', 'model.encoder.block.8.layer.0.SelfAttention.q.weight', 'model.encoder.block.8.layer.0.SelfAttention.k.weight', 'model.encoder.block.8.layer.0.SelfAttention.v.weight', 'model.encoder.block.8.layer.0.SelfAttention.o.weight', 'model.encoder.block.8.layer.0.layer_norm.weight', 'model.encoder.block.8.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.8.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.8.layer.1.layer_norm.weight', 'model.encoder.block.9.layer.0.SelfAttention.q.weight', 'model.encoder.block.9.layer.0.SelfAttention.k.weight', 'model.encoder.block.9.layer.0.SelfAttention.v.weight', 'model.encoder.block.9.layer.0.SelfAttention.o.weight', 'model.encoder.block.9.layer.0.layer_norm.weight', 'model.encoder.block.9.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.9.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.9.layer.1.layer_norm.weight', 'model.encoder.block.10.layer.0.SelfAttention.q.weight', 'model.encoder.block.10.layer.0.SelfAttention.k.weight', 'model.encoder.block.10.layer.0.SelfAttention.v.weight', 'model.encoder.block.10.layer.0.SelfAttention.o.weight', 'model.encoder.block.10.layer.0.layer_norm.weight', 'model.encoder.block.10.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.10.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.10.layer.1.layer_norm.weight', 'model.encoder.block.11.layer.0.SelfAttention.q.weight', 'model.encoder.block.11.layer.0.SelfAttention.k.weight', 'model.encoder.block.11.layer.0.SelfAttention.v.weight', 'model.encoder.block.11.layer.0.SelfAttention.o.weight', 'model.encoder.block.11.layer.0.layer_norm.weight', 'model.encoder.block.11.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.11.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.11.layer.1.layer_norm.weight', 'model.encoder.block.12.layer.0.SelfAttention.q.weight', 'model.encoder.block.12.layer.0.SelfAttention.k.weight', 'model.encoder.block.12.layer.0.SelfAttention.v.weight', 'model.encoder.block.12.layer.0.SelfAttention.o.weight', 'model.encoder.block.12.layer.0.layer_norm.weight', 'model.encoder.block.12.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.12.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.12.layer.1.layer_norm.weight', 'model.encoder.block.13.layer.0.SelfAttention.q.weight', 'model.encoder.block.13.layer.0.SelfAttention.k.weight', 'model.encoder.block.13.layer.0.SelfAttention.v.weight', 'model.encoder.block.13.layer.0.SelfAttention.o.weight', 'model.encoder.block.13.layer.0.layer_norm.weight', 'model.encoder.block.13.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.13.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.13.layer.1.layer_norm.weight', 'model.encoder.block.14.layer.0.SelfAttention.q.weight', 'model.encoder.block.14.layer.0.SelfAttention.k.weight', 'model.encoder.block.14.layer.0.SelfAttention.v.weight', 'model.encoder.block.14.layer.0.SelfAttention.o.weight', 'model.encoder.block.14.layer.0.layer_norm.weight', 'model.encoder.block.14.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.14.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.14.layer.1.layer_norm.weight', 'model.encoder.block.15.layer.0.SelfAttention.q.weight', 'model.encoder.block.15.layer.0.SelfAttention.k.weight', 'model.encoder.block.15.layer.0.SelfAttention.v.weight', 'model.encoder.block.15.layer.0.SelfAttention.o.weight', 'model.encoder.block.15.layer.0.layer_norm.weight', 'model.encoder.block.15.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.15.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.15.layer.1.layer_norm.weight', 'model.encoder.block.16.layer.0.SelfAttention.q.weight', 'model.encoder.block.16.layer.0.SelfAttention.k.weight', 'model.encoder.block.16.layer.0.SelfAttention.v.weight', 'model.encoder.block.16.layer.0.SelfAttention.o.weight', 'model.encoder.block.16.layer.0.layer_norm.weight', 'model.encoder.block.16.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.16.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.16.layer.1.layer_norm.weight', 'model.encoder.block.17.layer.0.SelfAttention.q.weight', 'model.encoder.block.17.layer.0.SelfAttention.k.weight', 'model.encoder.block.17.layer.0.SelfAttention.v.weight', 'model.encoder.block.17.layer.0.SelfAttention.o.weight', 'model.encoder.block.17.layer.0.layer_norm.weight', 'model.encoder.block.17.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.17.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.17.layer.1.layer_norm.weight', 'model.encoder.block.18.layer.0.SelfAttention.q.weight', 'model.encoder.block.18.layer.0.SelfAttention.k.weight', 'model.encoder.block.18.layer.0.SelfAttention.v.weight', 'model.encoder.block.18.layer.0.SelfAttention.o.weight', 'model.encoder.block.18.layer.0.layer_norm.weight', 'model.encoder.block.18.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.18.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.18.layer.1.layer_norm.weight', 'model.encoder.block.19.layer.0.SelfAttention.q.weight', 'model.encoder.block.19.layer.0.SelfAttention.k.weight', 'model.encoder.block.19.layer.0.SelfAttention.v.weight', 'model.encoder.block.19.layer.0.SelfAttention.o.weight', 'model.encoder.block.19.layer.0.layer_norm.weight', 'model.encoder.block.19.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.19.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.19.layer.1.layer_norm.weight', 'model.encoder.block.20.layer.0.SelfAttention.q.weight', 'model.encoder.block.20.layer.0.SelfAttention.k.weight', 'model.encoder.block.20.layer.0.SelfAttention.v.weight', 'model.encoder.block.20.layer.0.SelfAttention.o.weight', 'model.encoder.block.20.layer.0.layer_norm.weight', 'model.encoder.block.20.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.20.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.20.layer.1.layer_norm.weight', 'model.encoder.block.21.layer.0.SelfAttention.q.weight', 'model.encoder.block.21.layer.0.SelfAttention.k.weight', 'model.encoder.block.21.layer.0.SelfAttention.v.weight', 'model.encoder.block.21.layer.0.SelfAttention.o.weight', 'model.encoder.block.21.layer.0.layer_norm.weight', 'model.encoder.block.21.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.21.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.21.layer.1.layer_norm.weight', 'model.encoder.block.22.layer.0.SelfAttention.q.weight', 'model.encoder.block.22.layer.0.SelfAttention.k.weight', 'model.encoder.block.22.layer.0.SelfAttention.v.weight', 'model.encoder.block.22.layer.0.SelfAttention.o.weight', 'model.encoder.block.22.layer.0.layer_norm.weight', 'model.encoder.block.22.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.22.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.22.layer.1.layer_norm.weight', 'model.encoder.block.23.layer.0.SelfAttention.q.weight', 'model.encoder.block.23.layer.0.SelfAttention.k.weight', 'model.encoder.block.23.layer.0.SelfAttention.v.weight', 'model.encoder.block.23.layer.0.SelfAttention.o.weight', 'model.encoder.block.23.layer.0.layer_norm.weight', 'model.encoder.block.23.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.23.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.23.layer.1.layer_norm.weight', 'model.encoder.final_layer_norm.weight', 'model.enc_kadapter.layer_norm.weight', 'model.enc_kadapter.adapter.0.down_project.weight', 'model.enc_kadapter.adapter.0.down_project.bias', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.0.up_project.weight', 'model.enc_kadapter.adapter.0.up_project.bias', 'model.enc_kadapter.adapter.1.down_project.weight', 'model.enc_kadapter.adapter.1.down_project.bias', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.1.up_project.weight', 'model.enc_kadapter.adapter.1.up_project.bias', 'model.enc_kadapter.adapter.2.down_project.weight', 'model.enc_kadapter.adapter.2.down_project.bias', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.2.up_project.weight', 'model.enc_kadapter.adapter.2.up_project.bias', 'model.enc_kadapter.adapter.3.down_project.weight', 'model.enc_kadapter.adapter.3.down_project.bias', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.3.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.3.up_project.weight', 'model.enc_kadapter.adapter.3.up_project.bias', 'model.enc_kadapter.adapter.4.down_project.weight', 'model.enc_kadapter.adapter.4.down_project.bias', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.4.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.4.up_project.weight', 'model.enc_kadapter.adapter.4.up_project.bias', 'model.enc_kadapter.adapter.5.down_project.weight', 'model.enc_kadapter.adapter.5.down_project.bias', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.5.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.5.up_project.weight', 'model.enc_kadapter.adapter.5.up_project.bias', 'model.enc_kadapter.adapter.6.down_project.weight', 'model.enc_kadapter.adapter.6.down_project.bias', 'model.enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.6.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.6.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.6.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.6.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.6.up_project.weight', 'model.enc_kadapter.adapter.6.up_project.bias', 'model.enc_kadapter.adapter.7.down_project.weight', 'model.enc_kadapter.adapter.7.down_project.bias', 'model.enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.7.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.7.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.7.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.7.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.7.up_project.weight', 'model.enc_kadapter.adapter.7.up_project.bias', 'model.enc_kadapter.adapter.8.down_project.weight', 'model.enc_kadapter.adapter.8.down_project.bias', 'model.enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.8.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.8.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.8.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.8.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.8.up_project.weight', 'model.enc_kadapter.adapter.8.up_project.bias', 'model.enc_kadapter.pool.weight', 'model.enc_kadapter.pool.bias', 'model.decoder.embed_tokens.weight', 'model.decoder.block.0.layer.0.SelfAttention.q.weight', 'model.decoder.block.0.layer.0.SelfAttention.k.weight', 'model.decoder.block.0.layer.0.SelfAttention.v.weight', 'model.decoder.block.0.layer.0.SelfAttention.o.weight', 'model.decoder.block.0.layer.0.SelfAttention.relative_attention_bias.weight', 'model.decoder.block.0.layer.0.layer_norm.weight', 'model.decoder.block.0.layer.1.EncDecAttention.q.weight', 'model.decoder.block.0.layer.1.EncDecAttention.k.weight', 'model.decoder.block.0.layer.1.EncDecAttention.v.weight', 'model.decoder.block.0.layer.1.EncDecAttention.o.weight', 'model.decoder.block.0.layer.1.layer_norm.weight', 'model.decoder.block.0.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.0.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.0.layer.2.layer_norm.weight', 'model.decoder.block.1.layer.0.SelfAttention.q.weight', 'model.decoder.block.1.layer.0.SelfAttention.k.weight', 'model.decoder.block.1.layer.0.SelfAttention.v.weight', 'model.decoder.block.1.layer.0.SelfAttention.o.weight', 'model.decoder.block.1.layer.0.layer_norm.weight', 'model.decoder.block.1.layer.1.EncDecAttention.q.weight', 'model.decoder.block.1.layer.1.EncDecAttention.k.weight', 'model.decoder.block.1.layer.1.EncDecAttention.v.weight', 'model.decoder.block.1.layer.1.EncDecAttention.o.weight', 'model.decoder.block.1.layer.1.layer_norm.weight', 'model.decoder.block.1.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.1.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.1.layer.2.layer_norm.weight', 'model.decoder.block.2.layer.0.SelfAttention.q.weight', 'model.decoder.block.2.layer.0.SelfAttention.k.weight', 'model.decoder.block.2.layer.0.SelfAttention.v.weight', 'model.decoder.block.2.layer.0.SelfAttention.o.weight', 'model.decoder.block.2.layer.0.layer_norm.weight', 'model.decoder.block.2.layer.1.EncDecAttention.q.weight', 'model.decoder.block.2.layer.1.EncDecAttention.k.weight', 'model.decoder.block.2.layer.1.EncDecAttention.v.weight', 'model.decoder.block.2.layer.1.EncDecAttention.o.weight', 'model.decoder.block.2.layer.1.layer_norm.weight', 'model.decoder.block.2.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.2.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.2.layer.2.layer_norm.weight', 'model.decoder.block.3.layer.0.SelfAttention.q.weight', 'model.decoder.block.3.layer.0.SelfAttention.k.weight', 'model.decoder.block.3.layer.0.SelfAttention.v.weight', 'model.decoder.block.3.layer.0.SelfAttention.o.weight', 'model.decoder.block.3.layer.0.layer_norm.weight', 'model.decoder.block.3.layer.1.EncDecAttention.q.weight', 'model.decoder.block.3.layer.1.EncDecAttention.k.weight', 'model.decoder.block.3.layer.1.EncDecAttention.v.weight', 'model.decoder.block.3.layer.1.EncDecAttention.o.weight', 'model.decoder.block.3.layer.1.layer_norm.weight', 'model.decoder.block.3.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.3.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.3.layer.2.layer_norm.weight', 'model.decoder.block.4.layer.0.SelfAttention.q.weight', 'model.decoder.block.4.layer.0.SelfAttention.k.weight', 'model.decoder.block.4.layer.0.SelfAttention.v.weight', 'model.decoder.block.4.layer.0.SelfAttention.o.weight', 'model.decoder.block.4.layer.0.layer_norm.weight', 'model.decoder.block.4.layer.1.EncDecAttention.q.weight', 'model.decoder.block.4.layer.1.EncDecAttention.k.weight', 'model.decoder.block.4.layer.1.EncDecAttention.v.weight', 'model.decoder.block.4.layer.1.EncDecAttention.o.weight', 'model.decoder.block.4.layer.1.layer_norm.weight', 'model.decoder.block.4.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.4.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.4.layer.2.layer_norm.weight', 'model.decoder.block.5.layer.0.SelfAttention.q.weight', 'model.decoder.block.5.layer.0.SelfAttention.k.weight', 'model.decoder.block.5.layer.0.SelfAttention.v.weight', 'model.decoder.block.5.layer.0.SelfAttention.o.weight', 'model.decoder.block.5.layer.0.layer_norm.weight', 'model.decoder.block.5.layer.1.EncDecAttention.q.weight', 'model.decoder.block.5.layer.1.EncDecAttention.k.weight', 'model.decoder.block.5.layer.1.EncDecAttention.v.weight', 'model.decoder.block.5.layer.1.EncDecAttention.o.weight', 'model.decoder.block.5.layer.1.layer_norm.weight', 'model.decoder.block.5.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.5.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.5.layer.2.layer_norm.weight', 'model.decoder.block.6.layer.0.SelfAttention.q.weight', 'model.decoder.block.6.layer.0.SelfAttention.k.weight', 'model.decoder.block.6.layer.0.SelfAttention.v.weight', 'model.decoder.block.6.layer.0.SelfAttention.o.weight', 'model.decoder.block.6.layer.0.layer_norm.weight', 'model.decoder.block.6.layer.1.EncDecAttention.q.weight', 'model.decoder.block.6.layer.1.EncDecAttention.k.weight', 'model.decoder.block.6.layer.1.EncDecAttention.v.weight', 'model.decoder.block.6.layer.1.EncDecAttention.o.weight', 'model.decoder.block.6.layer.1.layer_norm.weight', 'model.decoder.block.6.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.6.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.6.layer.2.layer_norm.weight', 'model.decoder.block.7.layer.0.SelfAttention.q.weight', 'model.decoder.block.7.layer.0.SelfAttention.k.weight', 'model.decoder.block.7.layer.0.SelfAttention.v.weight', 'model.decoder.block.7.layer.0.SelfAttention.o.weight', 'model.decoder.block.7.layer.0.layer_norm.weight', 'model.decoder.block.7.layer.1.EncDecAttention.q.weight', 'model.decoder.block.7.layer.1.EncDecAttention.k.weight', 'model.decoder.block.7.layer.1.EncDecAttention.v.weight', 'model.decoder.block.7.layer.1.EncDecAttention.o.weight', 'model.decoder.block.7.layer.1.layer_norm.weight', 'model.decoder.block.7.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.7.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.7.layer.2.layer_norm.weight', 'model.decoder.block.8.layer.0.SelfAttention.q.weight', 'model.decoder.block.8.layer.0.SelfAttention.k.weight', 'model.decoder.block.8.layer.0.SelfAttention.v.weight', 'model.decoder.block.8.layer.0.SelfAttention.o.weight', 'model.decoder.block.8.layer.0.layer_norm.weight', 'model.decoder.block.8.layer.1.EncDecAttention.q.weight', 'model.decoder.block.8.layer.1.EncDecAttention.k.weight', 'model.decoder.block.8.layer.1.EncDecAttention.v.weight', 'model.decoder.block.8.layer.1.EncDecAttention.o.weight', 'model.decoder.block.8.layer.1.layer_norm.weight', 'model.decoder.block.8.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.8.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.8.layer.2.layer_norm.weight', 'model.decoder.block.9.layer.0.SelfAttention.q.weight', 'model.decoder.block.9.layer.0.SelfAttention.k.weight', 'model.decoder.block.9.layer.0.SelfAttention.v.weight', 'model.decoder.block.9.layer.0.SelfAttention.o.weight', 'model.decoder.block.9.layer.0.layer_norm.weight', 'model.decoder.block.9.layer.1.EncDecAttention.q.weight', 'model.decoder.block.9.layer.1.EncDecAttention.k.weight', 'model.decoder.block.9.layer.1.EncDecAttention.v.weight', 'model.decoder.block.9.layer.1.EncDecAttention.o.weight', 'model.decoder.block.9.layer.1.layer_norm.weight', 'model.decoder.block.9.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.9.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.9.layer.2.layer_norm.weight', 'model.decoder.block.10.layer.0.SelfAttention.q.weight', 'model.decoder.block.10.layer.0.SelfAttention.k.weight', 'model.decoder.block.10.layer.0.SelfAttention.v.weight', 'model.decoder.block.10.layer.0.SelfAttention.o.weight', 'model.decoder.block.10.layer.0.layer_norm.weight', 'model.decoder.block.10.layer.1.EncDecAttention.q.weight', 'model.decoder.block.10.layer.1.EncDecAttention.k.weight', 'model.decoder.block.10.layer.1.EncDecAttention.v.weight', 'model.decoder.block.10.layer.1.EncDecAttention.o.weight', 'model.decoder.block.10.layer.1.layer_norm.weight', 'model.decoder.block.10.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.10.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.10.layer.2.layer_norm.weight', 'model.decoder.block.11.layer.0.SelfAttention.q.weight', 'model.decoder.block.11.layer.0.SelfAttention.k.weight', 'model.decoder.block.11.layer.0.SelfAttention.v.weight', 'model.decoder.block.11.layer.0.SelfAttention.o.weight', 'model.decoder.block.11.layer.0.layer_norm.weight', 'model.decoder.block.11.layer.1.EncDecAttention.q.weight', 'model.decoder.block.11.layer.1.EncDecAttention.k.weight', 'model.decoder.block.11.layer.1.EncDecAttention.v.weight', 'model.decoder.block.11.layer.1.EncDecAttention.o.weight', 'model.decoder.block.11.layer.1.layer_norm.weight', 'model.decoder.block.11.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.11.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.11.layer.2.layer_norm.weight', 'model.decoder.block.12.layer.0.SelfAttention.q.weight', 'model.decoder.block.12.layer.0.SelfAttention.k.weight', 'model.decoder.block.12.layer.0.SelfAttention.v.weight', 'model.decoder.block.12.layer.0.SelfAttention.o.weight', 'model.decoder.block.12.layer.0.layer_norm.weight', 'model.decoder.block.12.layer.1.EncDecAttention.q.weight', 'model.decoder.block.12.layer.1.EncDecAttention.k.weight', 'model.decoder.block.12.layer.1.EncDecAttention.v.weight', 'model.decoder.block.12.layer.1.EncDecAttention.o.weight', 'model.decoder.block.12.layer.1.layer_norm.weight', 'model.decoder.block.12.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.12.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.12.layer.2.layer_norm.weight', 'model.decoder.block.13.layer.0.SelfAttention.q.weight', 'model.decoder.block.13.layer.0.SelfAttention.k.weight', 'model.decoder.block.13.layer.0.SelfAttention.v.weight', 'model.decoder.block.13.layer.0.SelfAttention.o.weight', 'model.decoder.block.13.layer.0.layer_norm.weight', 'model.decoder.block.13.layer.1.EncDecAttention.q.weight', 'model.decoder.block.13.layer.1.EncDecAttention.k.weight', 'model.decoder.block.13.layer.1.EncDecAttention.v.weight', 'model.decoder.block.13.layer.1.EncDecAttention.o.weight', 'model.decoder.block.13.layer.1.layer_norm.weight', 'model.decoder.block.13.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.13.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.13.layer.2.layer_norm.weight', 'model.decoder.block.14.layer.0.SelfAttention.q.weight', 'model.decoder.block.14.layer.0.SelfAttention.k.weight', 'model.decoder.block.14.layer.0.SelfAttention.v.weight', 'model.decoder.block.14.layer.0.SelfAttention.o.weight', 'model.decoder.block.14.layer.0.layer_norm.weight', 'model.decoder.block.14.layer.1.EncDecAttention.q.weight', 'model.decoder.block.14.layer.1.EncDecAttention.k.weight', 'model.decoder.block.14.layer.1.EncDecAttention.v.weight', 'model.decoder.block.14.layer.1.EncDecAttention.o.weight', 'model.decoder.block.14.layer.1.layer_norm.weight', 'model.decoder.block.14.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.14.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.14.layer.2.layer_norm.weight', 'model.decoder.block.15.layer.0.SelfAttention.q.weight', 'model.decoder.block.15.layer.0.SelfAttention.k.weight', 'model.decoder.block.15.layer.0.SelfAttention.v.weight', 'model.decoder.block.15.layer.0.SelfAttention.o.weight', 'model.decoder.block.15.layer.0.layer_norm.weight', 'model.decoder.block.15.layer.1.EncDecAttention.q.weight', 'model.decoder.block.15.layer.1.EncDecAttention.k.weight', 'model.decoder.block.15.layer.1.EncDecAttention.v.weight', 'model.decoder.block.15.layer.1.EncDecAttention.o.weight', 'model.decoder.block.15.layer.1.layer_norm.weight', 'model.decoder.block.15.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.15.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.15.layer.2.layer_norm.weight', 'model.decoder.block.16.layer.0.SelfAttention.q.weight', 'model.decoder.block.16.layer.0.SelfAttention.k.weight', 'model.decoder.block.16.layer.0.SelfAttention.v.weight', 'model.decoder.block.16.layer.0.SelfAttention.o.weight', 'model.decoder.block.16.layer.0.layer_norm.weight', 'model.decoder.block.16.layer.1.EncDecAttention.q.weight', 'model.decoder.block.16.layer.1.EncDecAttention.k.weight', 'model.decoder.block.16.layer.1.EncDecAttention.v.weight', 'model.decoder.block.16.layer.1.EncDecAttention.o.weight', 'model.decoder.block.16.layer.1.layer_norm.weight', 'model.decoder.block.16.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.16.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.16.layer.2.layer_norm.weight', 'model.decoder.block.17.layer.0.SelfAttention.q.weight', 'model.decoder.block.17.layer.0.SelfAttention.k.weight', 'model.decoder.block.17.layer.0.SelfAttention.v.weight', 'model.decoder.block.17.layer.0.SelfAttention.o.weight', 'model.decoder.block.17.layer.0.layer_norm.weight', 'model.decoder.block.17.layer.1.EncDecAttention.q.weight', 'model.decoder.block.17.layer.1.EncDecAttention.k.weight', 'model.decoder.block.17.layer.1.EncDecAttention.v.weight', 'model.decoder.block.17.layer.1.EncDecAttention.o.weight', 'model.decoder.block.17.layer.1.layer_norm.weight', 'model.decoder.block.17.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.17.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.17.layer.2.layer_norm.weight', 'model.decoder.block.18.layer.0.SelfAttention.q.weight', 'model.decoder.block.18.layer.0.SelfAttention.k.weight', 'model.decoder.block.18.layer.0.SelfAttention.v.weight', 'model.decoder.block.18.layer.0.SelfAttention.o.weight', 'model.decoder.block.18.layer.0.layer_norm.weight', 'model.decoder.block.18.layer.1.EncDecAttention.q.weight', 'model.decoder.block.18.layer.1.EncDecAttention.k.weight', 'model.decoder.block.18.layer.1.EncDecAttention.v.weight', 'model.decoder.block.18.layer.1.EncDecAttention.o.weight', 'model.decoder.block.18.layer.1.layer_norm.weight', 'model.decoder.block.18.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.18.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.18.layer.2.layer_norm.weight', 'model.decoder.block.19.layer.0.SelfAttention.q.weight', 'model.decoder.block.19.layer.0.SelfAttention.k.weight', 'model.decoder.block.19.layer.0.SelfAttention.v.weight', 'model.decoder.block.19.layer.0.SelfAttention.o.weight', 'model.decoder.block.19.layer.0.layer_norm.weight', 'model.decoder.block.19.layer.1.EncDecAttention.q.weight', 'model.decoder.block.19.layer.1.EncDecAttention.k.weight', 'model.decoder.block.19.layer.1.EncDecAttention.v.weight', 'model.decoder.block.19.layer.1.EncDecAttention.o.weight', 'model.decoder.block.19.layer.1.layer_norm.weight', 'model.decoder.block.19.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.19.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.19.layer.2.layer_norm.weight', 'model.decoder.block.20.layer.0.SelfAttention.q.weight', 'model.decoder.block.20.layer.0.SelfAttention.k.weight', 'model.decoder.block.20.layer.0.SelfAttention.v.weight', 'model.decoder.block.20.layer.0.SelfAttention.o.weight', 'model.decoder.block.20.layer.0.layer_norm.weight', 'model.decoder.block.20.layer.1.EncDecAttention.q.weight', 'model.decoder.block.20.layer.1.EncDecAttention.k.weight', 'model.decoder.block.20.layer.1.EncDecAttention.v.weight', 'model.decoder.block.20.layer.1.EncDecAttention.o.weight', 'model.decoder.block.20.layer.1.layer_norm.weight', 'model.decoder.block.20.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.20.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.20.layer.2.layer_norm.weight', 'model.decoder.block.21.layer.0.SelfAttention.q.weight', 'model.decoder.block.21.layer.0.SelfAttention.k.weight', 'model.decoder.block.21.layer.0.SelfAttention.v.weight', 'model.decoder.block.21.layer.0.SelfAttention.o.weight', 'model.decoder.block.21.layer.0.layer_norm.weight', 'model.decoder.block.21.layer.1.EncDecAttention.q.weight', 'model.decoder.block.21.layer.1.EncDecAttention.k.weight', 'model.decoder.block.21.layer.1.EncDecAttention.v.weight', 'model.decoder.block.21.layer.1.EncDecAttention.o.weight', 'model.decoder.block.21.layer.1.layer_norm.weight', 'model.decoder.block.21.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.21.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.21.layer.2.layer_norm.weight', 'model.decoder.block.22.layer.0.SelfAttention.q.weight', 'model.decoder.block.22.layer.0.SelfAttention.k.weight', 'model.decoder.block.22.layer.0.SelfAttention.v.weight', 'model.decoder.block.22.layer.0.SelfAttention.o.weight', 'model.decoder.block.22.layer.0.layer_norm.weight', 'model.decoder.block.22.layer.1.EncDecAttention.q.weight', 'model.decoder.block.22.layer.1.EncDecAttention.k.weight', 'model.decoder.block.22.layer.1.EncDecAttention.v.weight', 'model.decoder.block.22.layer.1.EncDecAttention.o.weight', 'model.decoder.block.22.layer.1.layer_norm.weight', 'model.decoder.block.22.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.22.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.22.layer.2.layer_norm.weight', 'model.decoder.block.23.layer.0.SelfAttention.q.weight', 'model.decoder.block.23.layer.0.SelfAttention.k.weight', 'model.decoder.block.23.layer.0.SelfAttention.v.weight', 'model.decoder.block.23.layer.0.SelfAttention.o.weight', 'model.decoder.block.23.layer.0.layer_norm.weight', 'model.decoder.block.23.layer.1.EncDecAttention.q.weight', 'model.decoder.block.23.layer.1.EncDecAttention.k.weight', 'model.decoder.block.23.layer.1.EncDecAttention.v.weight', 'model.decoder.block.23.layer.1.EncDecAttention.o.weight', 'model.decoder.block.23.layer.1.layer_norm.weight', 'model.decoder.block.23.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.23.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.23.layer.2.layer_norm.weight', 'model.decoder.final_layer_norm.weight', 'model.lm_head.weight'])
hparams.learning_rate = 0.001
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 32000
Index(['id', 'date', 'input', 'output'], dtype='object')
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]
Validation sanity check:  50%|█████     | 1/2 [00:05<00:05,  5.23s/it]
Validation sanity check: 100%|██████████| 2/2 [00:09<00:00,  4.49s/it]
split is 0
Length of dataset retrieving is.. 500000
Index(['id', 'date', 'input', 'output'], dtype='object')
----------Sampler init----------
mid epoch = False
Training: 0it [00:00, ?it/s]
Training:   0%|          | 0/46625 [00:00<?, ?it/s]
Epoch 0:   0%|          | 0/46625 [00:00<?, ?it/s] cuda memory allocated: 7903606784
----------Sampler iter----------
_____not mid epoch_____
Epoch 0:   0%|          | 1/46625 [00:00<12:08:48,  1.07it/s]
Epoch 0:   0%|          | 1/46625 [00:00<12:09:17,  1.07it/s, loss=11.3, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 2/46625 [00:01<8:04:32,  1.60it/s, loss=11.3, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 2/46625 [00:01<8:04:48,  1.60it/s, loss=9.34, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 3/46625 [00:01<6:42:14,  1.93it/s, loss=9.34, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 3/46625 [00:01<6:42:22,  1.93it/s, loss=8.34, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 4/46625 [00:01<6:01:09,  2.15it/s, loss=8.34, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 4/46625 [00:01<6:01:14,  2.15it/s, loss=7.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 5/46625 [00:02<5:36:48,  2.31it/s, loss=7.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 5/46625 [00:02<5:36:51,  2.31it/s, loss=7.22, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 6/46625 [00:02<5:20:10,  2.43it/s, loss=7.22, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 6/46625 [00:02<5:20:16,  2.43it/s, loss=6.79, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 7/46625 [00:02<5:08:21,  2.52it/s, loss=6.79, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 7/46625 [00:02<5:08:27,  2.52it/s, loss=6.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 8/46625 [00:03<4:59:35,  2.59it/s, loss=6.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 8/46625 [00:03<4:59:41,  2.59it/s, loss=6.12, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 9/46625 [00:03<4:52:48,  2.65it/s, loss=6.12, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 9/46625 [00:03<4:52:52,  2.65it/s, loss=5.94, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 10/46625 [00:03<4:47:27,  2.70it/s, loss=5.94, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 10/46625 [00:03<4:47:32,  2.70it/s, loss=5.7, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 11/46625 [00:04<4:43:03,  2.74it/s, loss=5.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 11/46625 [00:04<4:43:07,  2.74it/s, loss=5.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 12/46625 [00:04<4:39:21,  2.78it/s, loss=5.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 12/46625 [00:04<4:39:25,  2.78it/s, loss=5.29, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 13/46625 [00:04<4:36:16,  2.81it/s, loss=5.29, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 13/46625 [00:04<4:36:18,  2.81it/s, loss=5.12, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 14/46625 [00:04<4:33:32,  2.84it/s, loss=5.12, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 14/46625 [00:04<4:33:35,  2.84it/s, loss=4.99, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 15/46625 [00:05<4:31:17,  2.86it/s, loss=4.99, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 15/46625 [00:05<4:31:20,  2.86it/s, loss=4.86, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 16/46625 [00:05<4:29:18,  2.88it/s, loss=4.86, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 16/46625 [00:05<4:29:20,  2.88it/s, loss=4.73, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 17/46625 [00:05<4:27:34,  2.90it/s, loss=4.73, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 17/46625 [00:05<4:27:38,  2.90it/s, loss=4.61, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 18/46625 [00:06<4:26:07,  2.92it/s, loss=4.61, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 18/46625 [00:06<4:26:11,  2.92it/s, loss=4.52, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 19/46625 [00:06<4:24:52,  2.93it/s, loss=4.52, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 19/46625 [00:06<4:24:56,  2.93it/s, loss=4.42, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 20/46625 [00:06<4:23:42,  2.95it/s, loss=4.42, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 20/46625 [00:06<4:23:46,  2.94it/s, loss=4.32, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 21/46625 [00:07<4:22:38,  2.96it/s, loss=4.32, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 21/46625 [00:07<4:22:41,  2.96it/s, loss=3.96, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 22/46625 [00:07<4:21:37,  2.97it/s, loss=3.96, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 22/46625 [00:07<4:21:39,  2.97it/s, loss=3.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 23/46625 [00:07<4:20:39,  2.98it/s, loss=3.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 23/46625 [00:07<4:20:42,  2.98it/s, loss=3.53, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 24/46625 [00:08<4:19:45,  2.99it/s, loss=3.53, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 24/46625 [00:08<4:19:47,  2.99it/s, loss=3.37, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 25/46625 [00:08<4:18:57,  3.00it/s, loss=3.37, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 25/46625 [00:08<4:19:00,  3.00it/s, loss=3.24, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 26/46625 [00:08<4:18:19,  3.01it/s, loss=3.24, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 26/46625 [00:08<4:18:21,  3.01it/s, loss=3.13, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 27/46625 [00:08<4:17:40,  3.01it/s, loss=3.13, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 27/46625 [00:08<4:17:41,  3.01it/s, loss=3.01, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 28/46625 [00:09<4:17:02,  3.02it/s, loss=3.01, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 28/46625 [00:09<4:17:03,  3.02it/s, loss=2.95, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 29/46625 [00:09<4:16:26,  3.03it/s, loss=2.95, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 29/46625 [00:09<4:16:27,  3.03it/s, loss=2.83, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 30/46625 [00:09<4:15:52,  3.03it/s, loss=2.83, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 30/46625 [00:09<4:15:54,  3.03it/s, loss=2.77, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 31/46625 [00:10<4:15:21,  3.04it/s, loss=2.77, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 31/46625 [00:10<4:15:22,  3.04it/s, loss=2.73, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 32/46625 [00:10<4:14:51,  3.05it/s, loss=2.73, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 32/46625 [00:10<4:14:53,  3.05it/s, loss=2.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 33/46625 [00:10<4:14:23,  3.05it/s, loss=2.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 33/46625 [00:10<4:14:25,  3.05it/s, loss=2.62, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 34/46625 [00:11<4:13:59,  3.06it/s, loss=2.62, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 34/46625 [00:11<4:14:02,  3.06it/s, loss=2.59, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 35/46625 [00:11<4:13:38,  3.06it/s, loss=2.59, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 35/46625 [00:11<4:13:38,  3.06it/s, loss=2.53, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 36/46625 [00:11<4:13:13,  3.07it/s, loss=2.53, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 36/46625 [00:11<4:13:14,  3.07it/s, loss=2.49, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 37/46625 [00:12<4:12:52,  3.07it/s, loss=2.49, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 37/46625 [00:12<4:12:54,  3.07it/s, loss=2.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 38/46625 [00:12<4:12:34,  3.07it/s, loss=2.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 38/46625 [00:12<4:12:35,  3.07it/s, loss=2.4, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 39/46625 [00:12<4:12:13,  3.08it/s, loss=2.4, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 39/46625 [00:12<4:12:14,  3.08it/s, loss=2.35, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 40/46625 [00:12<4:11:53,  3.08it/s, loss=2.35, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 40/46625 [00:12<4:11:54,  3.08it/s, loss=2.31, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 41/46625 [00:13<4:11:37,  3.09it/s, loss=2.31, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 41/46625 [00:13<4:11:39,  3.09it/s, loss=2.2, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 42/46625 [00:13<4:11:19,  3.09it/s, loss=2.2, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 42/46625 [00:13<4:11:20,  3.09it/s, loss=2.16, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 43/46625 [00:13<4:11:02,  3.09it/s, loss=2.16, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 43/46625 [00:13<4:11:03,  3.09it/s, loss=2.13, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 44/46625 [00:14<4:10:44,  3.10it/s, loss=2.13, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 44/46625 [00:14<4:10:45,  3.10it/s, loss=2.11, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 45/46625 [00:14<4:10:28,  3.10it/s, loss=2.11, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 45/46625 [00:14<4:10:29,  3.10it/s, loss=2.05, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 46/46625 [00:14<4:10:12,  3.10it/s, loss=2.05, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 46/46625 [00:14<4:10:13,  3.10it/s, loss=2.01, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 47/46625 [00:15<4:09:58,  3.11it/s, loss=2.01, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 47/46625 [00:15<4:09:59,  3.11it/s, loss=1.99, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 48/46625 [00:15<4:09:43,  3.11it/s, loss=1.99, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 48/46625 [00:15<4:09:43,  3.11it/s, loss=1.96, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 49/46625 [00:15<4:09:28,  3.11it/s, loss=1.96, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 49/46625 [00:15<4:09:29,  3.11it/s, loss=1.94, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 50/46625 [00:16<4:09:16,  3.11it/s, loss=1.94, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 50/46625 [00:16<4:09:16,  3.11it/s, loss=1.92, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 51/46625 [00:16<4:09:03,  3.12it/s, loss=1.92, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 51/46625 [00:16<4:09:04,  3.12it/s, loss=1.91, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 52/46625 [00:16<4:08:51,  3.12it/s, loss=1.91, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 52/46625 [00:16<4:08:51,  3.12it/s, loss=1.91, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 53/46625 [00:16<4:08:39,  3.12it/s, loss=1.91, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 53/46625 [00:16<4:08:39,  3.12it/s, loss=1.87, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 54/46625 [00:17<4:08:27,  3.12it/s, loss=1.87, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 54/46625 [00:17<4:08:27,  3.12it/s, loss=1.83, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 55/46625 [00:17<4:08:15,  3.13it/s, loss=1.83, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 55/46625 [00:17<4:08:16,  3.13it/s, loss=1.82, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 56/46625 [00:17<4:08:05,  3.13it/s, loss=1.82, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 56/46625 [00:17<4:08:06,  3.13it/s, loss=1.81, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 57/46625 [00:18<4:07:55,  3.13it/s, loss=1.81, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 57/46625 [00:18<4:07:56,  3.13it/s, loss=1.8, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 58/46625 [00:18<4:07:48,  3.13it/s, loss=1.8, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 58/46625 [00:18<4:07:49,  3.13it/s, loss=1.8, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 59/46625 [00:18<4:07:41,  3.13it/s, loss=1.8, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 59/46625 [00:18<4:07:43,  3.13it/s, loss=1.79, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 60/46625 [00:19<4:07:35,  3.13it/s, loss=1.79, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 60/46625 [00:19<4:07:36,  3.13it/s, loss=1.82, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 61/46625 [00:19<4:07:29,  3.14it/s, loss=1.82, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 61/46625 [00:19<4:07:30,  3.14it/s, loss=1.81, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 62/46625 [00:19<4:07:22,  3.14it/s, loss=1.81, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 62/46625 [00:19<4:07:23,  3.14it/s, loss=1.82, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 63/46625 [00:20<4:07:15,  3.14it/s, loss=1.82, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 63/46625 [00:20<4:07:15,  3.14it/s, loss=1.8, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 64/46625 [00:20<4:07:08,  3.14it/s, loss=1.8, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 64/46625 [00:20<4:07:09,  3.14it/s, loss=1.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 65/46625 [00:20<4:07:01,  3.14it/s, loss=1.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 65/46625 [00:20<4:07:02,  3.14it/s, loss=1.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 66/46625 [00:21<4:06:54,  3.14it/s, loss=1.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 66/46625 [00:21<4:06:55,  3.14it/s, loss=1.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 67/46625 [00:21<4:06:48,  3.14it/s, loss=1.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 67/46625 [00:21<4:06:49,  3.14it/s, loss=1.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 68/46625 [00:21<4:06:41,  3.15it/s, loss=1.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 68/46625 [00:21<4:06:41,  3.15it/s, loss=1.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 69/46625 [00:21<4:06:35,  3.15it/s, loss=1.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 69/46625 [00:21<4:06:36,  3.15it/s, loss=1.76, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 70/46625 [00:22<4:06:29,  3.15it/s, loss=1.76, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 70/46625 [00:22<4:06:30,  3.15it/s, loss=1.76, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 71/46625 [00:22<4:06:23,  3.15it/s, loss=1.76, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 71/46625 [00:22<4:06:24,  3.15it/s, loss=1.74, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 72/46625 [00:22<4:06:18,  3.15it/s, loss=1.74, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 72/46625 [00:22<4:06:19,  3.15it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 73/46625 [00:23<4:06:12,  3.15it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 73/46625 [00:23<4:06:12,  3.15it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 74/46625 [00:23<4:06:06,  3.15it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 74/46625 [00:23<4:06:07,  3.15it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 75/46625 [00:23<4:06:01,  3.15it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 75/46625 [00:23<4:06:01,  3.15it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 76/46625 [00:24<4:05:55,  3.15it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 76/46625 [00:24<4:05:55,  3.15it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 77/46625 [00:24<4:05:49,  3.16it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 77/46625 [00:24<4:05:50,  3.16it/s, loss=1.72, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 78/46625 [00:24<4:05:44,  3.16it/s, loss=1.72, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 78/46625 [00:24<4:05:45,  3.16it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 79/46625 [00:25<4:05:39,  3.16it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 79/46625 [00:25<4:05:40,  3.16it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 80/46625 [00:25<4:05:35,  3.16it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 80/46625 [00:25<4:05:36,  3.16it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 81/46625 [00:25<4:05:31,  3.16it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 81/46625 [00:25<4:05:32,  3.16it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 82/46625 [00:25<4:05:27,  3.16it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 82/46625 [00:25<4:05:28,  3.16it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 83/46625 [00:26<4:05:24,  3.16it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 83/46625 [00:26<4:05:25,  3.16it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 84/46625 [00:26<4:05:20,  3.16it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 84/46625 [00:26<4:05:20,  3.16it/s, loss=1.65, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 85/46625 [00:26<4:05:14,  3.16it/s, loss=1.65, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 85/46625 [00:26<4:05:15,  3.16it/s, loss=1.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 86/46625 [00:27<4:05:10,  3.16it/s, loss=1.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 86/46625 [00:27<4:05:10,  3.16it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 87/46625 [00:27<4:05:05,  3.16it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 87/46625 [00:27<4:05:06,  3.16it/s, loss=1.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 88/46625 [00:27<4:05:00,  3.17it/s, loss=1.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 88/46625 [00:27<4:05:01,  3.17it/s, loss=1.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 89/46625 [00:28<4:04:56,  3.17it/s, loss=1.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 89/46625 [00:28<4:04:56,  3.17it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 90/46625 [00:28<4:04:54,  3.17it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 90/46625 [00:28<4:04:54,  3.17it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 91/46625 [00:28<4:04:50,  3.17it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 91/46625 [00:28<4:04:50,  3.17it/s, loss=1.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 92/46625 [00:29<4:04:47,  3.17it/s, loss=1.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 92/46625 [00:29<4:04:47,  3.17it/s, loss=1.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 93/46625 [00:29<4:04:43,  3.17it/s, loss=1.66, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 93/46625 [00:29<4:04:44,  3.17it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 94/46625 [00:29<4:04:40,  3.17it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 94/46625 [00:29<4:04:40,  3.17it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 95/46625 [00:29<4:04:36,  3.17it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 95/46625 [00:29<4:04:36,  3.17it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 96/46625 [00:30<4:04:32,  3.17it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 96/46625 [00:30<4:04:33,  3.17it/s, loss=1.65, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 97/46625 [00:30<4:04:29,  3.17it/s, loss=1.65, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 97/46625 [00:30<4:04:29,  3.17it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 98/46625 [00:30<4:04:25,  3.17it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 98/46625 [00:30<4:04:26,  3.17it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 99/46625 [00:31<4:04:23,  3.17it/s, loss=1.67, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 99/46625 [00:31<4:04:24,  3.17it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 100/46625 [00:31<4:04:21,  3.17it/s, loss=1.68, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 100/46625 [00:31<4:04:22,  3.17it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 101/46625 [00:31<4:04:20,  3.17it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 101/46625 [00:31<4:04:21,  3.17it/s, loss=1.69, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 102/46625 [00:32<4:04:19,  3.17it/s, loss=1.69, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 102/46625 [00:32<4:04:20,  3.17it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 103/46625 [00:32<4:04:17,  3.17it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 103/46625 [00:32<4:04:17,  3.17it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 104/46625 [00:32<4:04:14,  3.17it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 104/46625 [00:32<4:04:15,  3.17it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 105/46625 [00:33<4:04:11,  3.18it/s, loss=1.71, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 105/46625 [00:33<4:04:12,  3.17it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 106/46625 [00:33<4:04:08,  3.18it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 106/46625 [00:33<4:04:08,  3.18it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 107/46625 [00:33<4:04:05,  3.18it/s, loss=1.7, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 107/46625 [00:33<4:04:06,  3.18it/s, loss=1.69, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 108/46625 [00:33<4:04:03,  3.18it/s, loss=1.69, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 108/46625 [00:34<4:04:04,  3.18it/s, loss=2.12, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 109/46625 [00:34<4:04:01,  3.18it/s, loss=2.12, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 109/46625 [00:34<4:04:01,  3.18it/s, loss=2.57, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 110/46625 [00:34<4:03:57,  3.18it/s, loss=2.57, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 110/46625 [00:34<4:03:58,  3.18it/s, loss=2.93, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 111/46625 [00:34<4:03:55,  3.18it/s, loss=2.93, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 111/46625 [00:34<4:03:55,  3.18it/s, loss=2.91, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 112/46625 [00:35<4:03:52,  3.18it/s, loss=2.91, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 112/46625 [00:35<4:03:53,  3.18it/s, loss=2.91, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 113/46625 [00:35<4:03:50,  3.18it/s, loss=2.91, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 113/46625 [00:35<4:03:51,  3.18it/s, loss=2.91, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 114/46625 [00:35<4:03:48,  3.18it/s, loss=2.91, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 114/46625 [00:35<4:03:48,  3.18it/s, loss=2.88, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 115/46625 [00:36<4:03:46,  3.18it/s, loss=2.88, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 115/46625 [00:36<4:03:46,  3.18it/s, loss=2.89, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 116/46625 [00:36<4:03:43,  3.18it/s, loss=2.89, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 116/46625 [00:36<4:03:43,  3.18it/s, loss=2.89, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 117/46625 [00:36<4:03:41,  3.18it/s, loss=2.89, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 117/46625 [00:36<4:03:41,  3.18it/s, loss=2.85, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 118/46625 [00:37<4:03:38,  3.18it/s, loss=2.85, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 118/46625 [00:37<4:03:38,  3.18it/s, loss=2.87, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 119/46625 [00:37<4:03:35,  3.18it/s, loss=2.87, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 119/46625 [00:37<4:03:35,  3.18it/s, loss=2.86, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 120/46625 [00:37<4:03:32,  3.18it/s, loss=2.86, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 120/46625 [00:37<4:03:32,  3.18it/s, loss=2.84, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 121/46625 [00:38<4:03:30,  3.18it/s, loss=2.84, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 121/46625 [00:38<4:03:30,  3.18it/s, loss=2.84, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 122/46625 [00:38<4:03:27,  3.18it/s, loss=2.84, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 122/46625 [00:38<4:03:28,  3.18it/s, loss=2.83, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 123/46625 [00:38<4:03:25,  3.18it/s, loss=2.83, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 123/46625 [00:38<4:03:26,  3.18it/s, loss=2.83, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 124/46625 [00:38<4:03:23,  3.18it/s, loss=2.83, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 124/46625 [00:38<4:03:23,  3.18it/s, loss=2.81, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 125/46625 [00:39<4:03:20,  3.18it/s, loss=2.81, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 125/46625 [00:39<4:03:20,  3.18it/s, loss=2.8, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 126/46625 [00:39<4:03:18,  3.19it/s, loss=2.8, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 126/46625 [00:39<4:03:18,  3.19it/s, loss=2.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 127/46625 [00:39<4:03:15,  3.19it/s, loss=2.78, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 127/46625 [00:39<4:03:16,  3.19it/s, loss=2.76, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 128/46625 [00:40<4:03:13,  3.19it/s, loss=2.76, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 128/46625 [00:40<4:03:14,  3.19it/s, loss=2.32, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 129/46625 [00:40<4:03:11,  3.19it/s, loss=2.32, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 129/46625 [00:40<4:03:11,  3.19it/s, loss=1.88, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 130/46625 [00:40<4:03:11,  3.19it/s, loss=1.88, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 130/46625 [00:40<4:03:12,  3.19it/s, loss=1.5, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 131/46625 [00:41<4:03:10,  3.19it/s, loss=1.5, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 131/46625 [00:41<4:03:11,  3.19it/s, loss=1.52, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 132/46625 [00:41<4:03:08,  3.19it/s, loss=1.52, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 132/46625 [00:41<4:03:08,  3.19it/s, loss=1.54, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 133/46625 [00:41<4:03:06,  3.19it/s, loss=1.54, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 133/46625 [00:41<4:03:06,  3.19it/s, loss=1.53, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 134/46625 [00:42<4:03:04,  3.19it/s, loss=1.53, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 134/46625 [00:42<4:03:04,  3.19it/s, loss=1.54, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 135/46625 [00:42<4:03:02,  3.19it/s, loss=1.54, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 135/46625 [00:42<4:03:02,  3.19it/s, loss=1.53, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 136/46625 [00:42<4:03:00,  3.19it/s, loss=1.53, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 136/46625 [00:42<4:03:00,  3.19it/s, loss=1.5, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 137/46625 [00:42<4:02:58,  3.19it/s, loss=1.5, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 137/46625 [00:42<4:02:58,  3.19it/s, loss=1.48, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 138/46625 [00:43<4:02:56,  3.19it/s, loss=1.48, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 138/46625 [00:43<4:02:56,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 139/46625 [00:43<4:02:55,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 139/46625 [00:43<4:02:55,  3.19it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 140/46625 [00:43<4:02:54,  3.19it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 140/46625 [00:43<4:02:54,  3.19it/s, loss=1.42, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 141/46625 [00:44<4:02:53,  3.19it/s, loss=1.42, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 141/46625 [00:44<4:02:53,  3.19it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 142/46625 [00:44<4:02:52,  3.19it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 142/46625 [00:44<4:02:53,  3.19it/s, loss=1.41, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 143/46625 [00:44<4:02:51,  3.19it/s, loss=1.41, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 143/46625 [00:44<4:02:51,  3.19it/s, loss=1.41, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 144/46625 [00:45<4:02:50,  3.19it/s, loss=1.41, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 144/46625 [00:45<4:02:50,  3.19it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 145/46625 [00:45<4:02:49,  3.19it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 145/46625 [00:45<4:02:50,  3.19it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 146/46625 [00:45<4:02:47,  3.19it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 146/46625 [00:45<4:02:48,  3.19it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 147/46625 [00:46<4:02:47,  3.19it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 147/46625 [00:46<4:02:48,  3.19it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 148/46625 [00:46<4:02:46,  3.19it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 148/46625 [00:46<4:02:47,  3.19it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 149/46625 [00:46<4:02:44,  3.19it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 149/46625 [00:46<4:02:45,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 150/46625 [00:47<4:02:43,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 150/46625 [00:47<4:02:43,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 151/46625 [00:47<4:02:42,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 151/46625 [00:47<4:02:42,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 152/46625 [00:47<4:02:41,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 152/46625 [00:47<4:02:41,  3.19it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 153/46625 [00:47<4:02:40,  3.19it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 153/46625 [00:47<4:02:40,  3.19it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 154/46625 [00:48<4:02:38,  3.19it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 154/46625 [00:48<4:02:39,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 155/46625 [00:48<4:02:37,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 155/46625 [00:48<4:02:37,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 156/46625 [00:48<4:02:36,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 156/46625 [00:48<4:02:36,  3.19it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 157/46625 [00:49<4:02:34,  3.19it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 157/46625 [00:49<4:02:34,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 158/46625 [00:49<4:02:32,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 158/46625 [00:49<4:02:32,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 159/46625 [00:49<4:02:31,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 159/46625 [00:49<4:02:31,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 160/46625 [00:50<4:02:30,  3.19it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 160/46625 [00:50<4:02:30,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 161/46625 [00:50<4:02:28,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 161/46625 [00:50<4:02:29,  3.19it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 162/46625 [00:50<4:02:27,  3.19it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 162/46625 [00:50<4:02:27,  3.19it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 163/46625 [00:51<4:02:26,  3.19it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 163/46625 [00:51<4:02:26,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 164/46625 [00:51<4:02:24,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 164/46625 [00:51<4:02:24,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 165/46625 [00:51<4:02:23,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 165/46625 [00:51<4:02:23,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 166/46625 [00:51<4:02:21,  3.19it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 166/46625 [00:51<4:02:21,  3.19it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 167/46625 [00:52<4:02:19,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 167/46625 [00:52<4:02:19,  3.20it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 168/46625 [00:52<4:02:17,  3.20it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 168/46625 [00:52<4:02:18,  3.20it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 169/46625 [00:52<4:02:16,  3.20it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 169/46625 [00:52<4:02:16,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 170/46625 [00:53<4:02:14,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 170/46625 [00:53<4:02:14,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 171/46625 [00:53<4:02:12,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 171/46625 [00:53<4:02:12,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 172/46625 [00:53<4:02:11,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 172/46625 [00:53<4:02:11,  3.20it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 173/46625 [00:54<4:02:09,  3.20it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 173/46625 [00:54<4:02:09,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 174/46625 [00:54<4:02:09,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 174/46625 [00:54<4:02:09,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 175/46625 [00:54<4:02:07,  3.20it/s, loss=1.45, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 175/46625 [00:54<4:02:08,  3.20it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 176/46625 [00:55<4:02:06,  3.20it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 176/46625 [00:55<4:02:06,  3.20it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 177/46625 [00:55<4:02:04,  3.20it/s, loss=1.44, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 177/46625 [00:55<4:02:04,  3.20it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 178/46625 [00:55<4:02:03,  3.20it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 178/46625 [00:55<4:02:03,  3.20it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 179/46625 [00:55<4:02:02,  3.20it/s, loss=1.47, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 179/46625 [00:55<4:02:02,  3.20it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 180/46625 [00:56<4:02:01,  3.20it/s, loss=1.46, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 180/46625 [00:56<4:02:01,  3.20it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 181/46625 [00:56<4:02:00,  3.20it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 181/46625 [00:56<4:02:00,  3.20it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 182/46625 [00:56<4:01:59,  3.20it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 182/46625 [00:56<4:02:00,  3.20it/s, loss=1.42, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 183/46625 [00:57<4:01:59,  3.20it/s, loss=1.42, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 183/46625 [00:57<4:01:59,  3.20it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 184/46625 [00:57<4:01:58,  3.20it/s, loss=1.43, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 184/46625 [00:57<4:01:58,  3.20it/s, loss=1.42, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 185/46625 [00:57<4:01:57,  3.20it/s, loss=1.42, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 185/46625 [00:57<4:01:58,  3.20it/s, loss=1.4, v_num=whee, em_score=0.000, f1_score=0.000] 
Epoch 0:   0%|          | 186/46625 [00:58<4:01:57,  3.20it/s, loss=1.4, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 186/46625 [00:58<4:01:57,  3.20it/s, loss=1.4, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 187/46625 [00:58<4:01:56,  3.20it/s, loss=1.4, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 187/46625 [00:58<4:01:56,  3.20it/s, loss=1.4, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 188/46625 [00:58<4:01:55,  3.20it/s, loss=1.4, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 188/46625 [00:58<4:01:55,  3.20it/s, loss=1.42, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 189/46625 [00:59<4:01:54,  3.20it/s, loss=1.42, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 189/46625 [00:59<4:01:54,  3.20it/s, loss=1.39, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 190/46625 [00:59<4:01:53,  3.20it/s, loss=1.39, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 190/46625 [00:59<4:01:53,  3.20it/s, loss=1.38, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 191/46625 [00:59<4:01:52,  3.20it/s, loss=1.38, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 191/46625 [00:59<4:01:52,  3.20it/s, loss=1.39, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 192/46625 [01:00<4:01:51,  3.20it/s, loss=1.39, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 192/46625 [01:00<4:01:51,  3.20it/s, loss=1.37, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 193/46625 [01:00<4:01:50,  3.20it/s, loss=1.37, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 193/46625 [01:00<4:01:50,  3.20it/s, loss=1.37, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 194/46625 [01:00<4:01:49,  3.20it/s, loss=1.37, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 194/46625 [01:00<4:01:49,  3.20it/s, loss=1.36, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 195/46625 [01:00<4:01:48,  3.20it/s, loss=1.36, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 195/46625 [01:00<4:01:48,  3.20it/s, loss=1.35, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 196/46625 [01:01<4:01:47,  3.20it/s, loss=1.35, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 196/46625 [01:01<4:01:47,  3.20it/s, loss=1.35, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 197/46625 [01:01<4:01:46,  3.20it/s, loss=1.35, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 197/46625 [01:01<4:01:47,  3.20it/s, loss=1.36, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 198/46625 [01:01<4:01:45,  3.20it/s, loss=1.36, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 198/46625 [01:01<4:01:46,  3.20it/s, loss=1.35, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 199/46625 [01:02<4:01:45,  3.20it/s, loss=1.35, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 199/46625 [01:02<4:01:45,  3.20it/s, loss=1.35, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 200/46625 [01:02<4:01:44,  3.20it/s, loss=1.35, v_num=whee, em_score=0.000, f1_score=0.000]
Epoch 0:   0%|          | 200/46625 [01:02<4:01:44,  3.20it/s, loss=1.37, v_num=whee, em_score=0.000, f1_score=0.000]slurmstepd: error: *** JOB 7490544 ON g3071 CANCELLED AT 2022-11-15T04:01:36 ***
