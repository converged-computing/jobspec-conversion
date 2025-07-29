#!/bin/bash
#SBATCH --job-name=data-proc
#SBATCH --account=cse
#SBATCH --mail-user=tjung2@uw.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu-a40
#SBATCH --dependency=6700270

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/wmt/training/t5_kadapters_yearly_small.json -datav 2011
python run.py --config configs/wmt/training/t5_kadapters_yearly_small.json -datav 2012
python run.py --config configs/wmt/training/t5_kadapters_yearly_small.json -datav 2013
python run.py --config configs/wmt/training/t5_kadapters_yearly_small.json -datav 2014
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.5 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20221115_070232-i1gim1yv
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_2011
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/i1gim1yv
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/wmtkadapter_2011_2freeze_11221222324_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-large-ssm and are newly initialized: ['enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.4.down_project.weight', 'enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.3.up_project.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.3.down_project.weight', 'enc_kadapter.adapter.5.down_project.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.3.down_project.bias', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.4.down_project.bias', 'enc_kadapter.adapter.4.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.5.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.3.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.3.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.5.encoder.layer.1.layer_norm.weight', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.4.up_project.bias', 'enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.5.encoder.layer.0.layer_norm.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.5.up_project.bias', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.4.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.4.up_project.weight', 'enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.3.up_project.bias', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.5.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.o.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Set SLURM handle signals.
  | Name  | Type                       | Params
-----------------------------------------------------
0 | model | T5ForConditionalGeneration | 748 M 
-----------------------------------------------------
11.0 M    Trainable params
737 M     Non-trainable params
748 M     Total params
2,994.763 Total estimated model params size (MB)
checkpoint path = outputs/wmtkadapter_full_2freeze_11221222324_128/epoch=0-f1_score=0.2566-em_score=0.2175.ckpt
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 12, 21, 22, 23, 24], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': None, 'years_to_paths': None, 'load_adapters': None}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 12, 21, 22, 23, 24], check_validation_only=False, checkpoint_dir='outputs/wmtkadapter_full_2freeze_11221222324_128', checkpoint_path='outputs/wmtkadapter_full_2freeze_11221222324_128/epoch=0-f1_score=0.2566-em_score=0.2175.ckpt', dataset='wmt', dataset_version='2011', early_stop_callback=False, eval_batch_size=32, find_lr=False, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.002, load_adapters=None, max_grad_norm=0.5, max_input_length=100, max_output_length=50, method='kadapter', mode='pretrain', model_name_or_path='google/t5-large-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=1, num_workers=4, opt_level='O1', output_dir='outputs/wmtkadapter_2011_2freeze_11221222324_128', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-large-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=2500, val_data='2011', wandb_log=True, warmup_steps=0, weight_decay=0.0, years_to_paths=None)
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
    12,
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
  "load_adapters": null,
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
  "vocab_size": 32128,
  "years_to_paths": null
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
enc_kadapter.pool.weight
enc_kadapter.pool.bias
odict_keys(['model.shared.weight', 'model.encoder.embed_tokens.weight', 'model.encoder.block.0.layer.0.SelfAttention.q.weight', 'model.encoder.block.0.layer.0.SelfAttention.k.weight', 'model.encoder.block.0.layer.0.SelfAttention.v.weight', 'model.encoder.block.0.layer.0.SelfAttention.o.weight', 'model.encoder.block.0.layer.0.SelfAttention.relative_attention_bias.weight', 'model.encoder.block.0.layer.0.layer_norm.weight', 'model.encoder.block.0.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.0.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.0.layer.1.layer_norm.weight', 'model.encoder.block.1.layer.0.SelfAttention.q.weight', 'model.encoder.block.1.layer.0.SelfAttention.k.weight', 'model.encoder.block.1.layer.0.SelfAttention.v.weight', 'model.encoder.block.1.layer.0.SelfAttention.o.weight', 'model.encoder.block.1.layer.0.layer_norm.weight', 'model.encoder.block.1.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.1.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.1.layer.1.layer_norm.weight', 'model.encoder.block.2.layer.0.SelfAttention.q.weight', 'model.encoder.block.2.layer.0.SelfAttention.k.weight', 'model.encoder.block.2.layer.0.SelfAttention.v.weight', 'model.encoder.block.2.layer.0.SelfAttention.o.weight', 'model.encoder.block.2.layer.0.layer_norm.weight', 'model.encoder.block.2.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.2.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.2.layer.1.layer_norm.weight', 'model.encoder.block.3.layer.0.SelfAttention.q.weight', 'model.encoder.block.3.layer.0.SelfAttention.k.weight', 'model.encoder.block.3.layer.0.SelfAttention.v.weight', 'model.encoder.block.3.layer.0.SelfAttention.o.weight', 'model.encoder.block.3.layer.0.layer_norm.weight', 'model.encoder.block.3.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.3.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.3.layer.1.layer_norm.weight', 'model.encoder.block.4.layer.0.SelfAttention.q.weight', 'model.encoder.block.4.layer.0.SelfAttention.k.weight', 'model.encoder.block.4.layer.0.SelfAttention.v.weight', 'model.encoder.block.4.layer.0.SelfAttention.o.weight', 'model.encoder.block.4.layer.0.layer_norm.weight', 'model.encoder.block.4.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.4.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.4.layer.1.layer_norm.weight', 'model.encoder.block.5.layer.0.SelfAttention.q.weight', 'model.encoder.block.5.layer.0.SelfAttention.k.weight', 'model.encoder.block.5.layer.0.SelfAttention.v.weight', 'model.encoder.block.5.layer.0.SelfAttention.o.weight', 'model.encoder.block.5.layer.0.layer_norm.weight', 'model.encoder.block.5.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.5.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.5.layer.1.layer_norm.weight', 'model.encoder.block.6.layer.0.SelfAttention.q.weight', 'model.encoder.block.6.layer.0.SelfAttention.k.weight', 'model.encoder.block.6.layer.0.SelfAttention.v.weight', 'model.encoder.block.6.layer.0.SelfAttention.o.weight', 'model.encoder.block.6.layer.0.layer_norm.weight', 'model.encoder.block.6.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.6.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.6.layer.1.layer_norm.weight', 'model.encoder.block.7.layer.0.SelfAttention.q.weight', 'model.encoder.block.7.layer.0.SelfAttention.k.weight', 'model.encoder.block.7.layer.0.SelfAttention.v.weight', 'model.encoder.block.7.layer.0.SelfAttention.o.weight', 'model.encoder.block.7.layer.0.layer_norm.weight', 'model.encoder.block.7.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.7.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.7.layer.1.layer_norm.weight', 'model.encoder.block.8.layer.0.SelfAttention.q.weight', 'model.encoder.block.8.layer.0.SelfAttention.k.weight', 'model.encoder.block.8.layer.0.SelfAttention.v.weight', 'model.encoder.block.8.layer.0.SelfAttention.o.weight', 'model.encoder.block.8.layer.0.layer_norm.weight', 'model.encoder.block.8.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.8.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.8.layer.1.layer_norm.weight', 'model.encoder.block.9.layer.0.SelfAttention.q.weight', 'model.encoder.block.9.layer.0.SelfAttention.k.weight', 'model.encoder.block.9.layer.0.SelfAttention.v.weight', 'model.encoder.block.9.layer.0.SelfAttention.o.weight', 'model.encoder.block.9.layer.0.layer_norm.weight', 'model.encoder.block.9.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.9.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.9.layer.1.layer_norm.weight', 'model.encoder.block.10.layer.0.SelfAttention.q.weight', 'model.encoder.block.10.layer.0.SelfAttention.k.weight', 'model.encoder.block.10.layer.0.SelfAttention.v.weight', 'model.encoder.block.10.layer.0.SelfAttention.o.weight', 'model.encoder.block.10.layer.0.layer_norm.weight', 'model.encoder.block.10.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.10.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.10.layer.1.layer_norm.weight', 'model.encoder.block.11.layer.0.SelfAttention.q.weight', 'model.encoder.block.11.layer.0.SelfAttention.k.weight', 'model.encoder.block.11.layer.0.SelfAttention.v.weight', 'model.encoder.block.11.layer.0.SelfAttention.o.weight', 'model.encoder.block.11.layer.0.layer_norm.weight', 'model.encoder.block.11.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.11.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.11.layer.1.layer_norm.weight', 'model.encoder.block.12.layer.0.SelfAttention.q.weight', 'model.encoder.block.12.layer.0.SelfAttention.k.weight', 'model.encoder.block.12.layer.0.SelfAttention.v.weight', 'model.encoder.block.12.layer.0.SelfAttention.o.weight', 'model.encoder.block.12.layer.0.layer_norm.weight', 'model.encoder.block.12.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.12.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.12.layer.1.layer_norm.weight', 'model.encoder.block.13.layer.0.SelfAttention.q.weight', 'model.encoder.block.13.layer.0.SelfAttention.k.weight', 'model.encoder.block.13.layer.0.SelfAttention.v.weight', 'model.encoder.block.13.layer.0.SelfAttention.o.weight', 'model.encoder.block.13.layer.0.layer_norm.weight', 'model.encoder.block.13.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.13.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.13.layer.1.layer_norm.weight', 'model.encoder.block.14.layer.0.SelfAttention.q.weight', 'model.encoder.block.14.layer.0.SelfAttention.k.weight', 'model.encoder.block.14.layer.0.SelfAttention.v.weight', 'model.encoder.block.14.layer.0.SelfAttention.o.weight', 'model.encoder.block.14.layer.0.layer_norm.weight', 'model.encoder.block.14.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.14.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.14.layer.1.layer_norm.weight', 'model.encoder.block.15.layer.0.SelfAttention.q.weight', 'model.encoder.block.15.layer.0.SelfAttention.k.weight', 'model.encoder.block.15.layer.0.SelfAttention.v.weight', 'model.encoder.block.15.layer.0.SelfAttention.o.weight', 'model.encoder.block.15.layer.0.layer_norm.weight', 'model.encoder.block.15.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.15.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.15.layer.1.layer_norm.weight', 'model.encoder.block.16.layer.0.SelfAttention.q.weight', 'model.encoder.block.16.layer.0.SelfAttention.k.weight', 'model.encoder.block.16.layer.0.SelfAttention.v.weight', 'model.encoder.block.16.layer.0.SelfAttention.o.weight', 'model.encoder.block.16.layer.0.layer_norm.weight', 'model.encoder.block.16.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.16.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.16.layer.1.layer_norm.weight', 'model.encoder.block.17.layer.0.SelfAttention.q.weight', 'model.encoder.block.17.layer.0.SelfAttention.k.weight', 'model.encoder.block.17.layer.0.SelfAttention.v.weight', 'model.encoder.block.17.layer.0.SelfAttention.o.weight', 'model.encoder.block.17.layer.0.layer_norm.weight', 'model.encoder.block.17.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.17.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.17.layer.1.layer_norm.weight', 'model.encoder.block.18.layer.0.SelfAttention.q.weight', 'model.encoder.block.18.layer.0.SelfAttention.k.weight', 'model.encoder.block.18.layer.0.SelfAttention.v.weight', 'model.encoder.block.18.layer.0.SelfAttention.o.weight', 'model.encoder.block.18.layer.0.layer_norm.weight', 'model.encoder.block.18.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.18.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.18.layer.1.layer_norm.weight', 'model.encoder.block.19.layer.0.SelfAttention.q.weight', 'model.encoder.block.19.layer.0.SelfAttention.k.weight', 'model.encoder.block.19.layer.0.SelfAttention.v.weight', 'model.encoder.block.19.layer.0.SelfAttention.o.weight', 'model.encoder.block.19.layer.0.layer_norm.weight', 'model.encoder.block.19.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.19.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.19.layer.1.layer_norm.weight', 'model.encoder.block.20.layer.0.SelfAttention.q.weight', 'model.encoder.block.20.layer.0.SelfAttention.k.weight', 'model.encoder.block.20.layer.0.SelfAttention.v.weight', 'model.encoder.block.20.layer.0.SelfAttention.o.weight', 'model.encoder.block.20.layer.0.layer_norm.weight', 'model.encoder.block.20.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.20.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.20.layer.1.layer_norm.weight', 'model.encoder.block.21.layer.0.SelfAttention.q.weight', 'model.encoder.block.21.layer.0.SelfAttention.k.weight', 'model.encoder.block.21.layer.0.SelfAttention.v.weight', 'model.encoder.block.21.layer.0.SelfAttention.o.weight', 'model.encoder.block.21.layer.0.layer_norm.weight', 'model.encoder.block.21.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.21.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.21.layer.1.layer_norm.weight', 'model.encoder.block.22.layer.0.SelfAttention.q.weight', 'model.encoder.block.22.layer.0.SelfAttention.k.weight', 'model.encoder.block.22.layer.0.SelfAttention.v.weight', 'model.encoder.block.22.layer.0.SelfAttention.o.weight', 'model.encoder.block.22.layer.0.layer_norm.weight', 'model.encoder.block.22.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.22.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.22.layer.1.layer_norm.weight', 'model.encoder.block.23.layer.0.SelfAttention.q.weight', 'model.encoder.block.23.layer.0.SelfAttention.k.weight', 'model.encoder.block.23.layer.0.SelfAttention.v.weight', 'model.encoder.block.23.layer.0.SelfAttention.o.weight', 'model.encoder.block.23.layer.0.layer_norm.weight', 'model.encoder.block.23.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.23.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.23.layer.1.layer_norm.weight', 'model.encoder.final_layer_norm.weight', 'model.enc_kadapter.layer_norm.weight', 'model.enc_kadapter.adapter.0.down_project.weight', 'model.enc_kadapter.adapter.0.down_project.bias', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.0.up_project.weight', 'model.enc_kadapter.adapter.0.up_project.bias', 'model.enc_kadapter.adapter.1.down_project.weight', 'model.enc_kadapter.adapter.1.down_project.bias', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.1.up_project.weight', 'model.enc_kadapter.adapter.1.up_project.bias', 'model.enc_kadapter.adapter.2.down_project.weight', 'model.enc_kadapter.adapter.2.down_project.bias', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.2.up_project.weight', 'model.enc_kadapter.adapter.2.up_project.bias', 'model.enc_kadapter.adapter.3.down_project.weight', 'model.enc_kadapter.adapter.3.down_project.bias', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.3.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.3.up_project.weight', 'model.enc_kadapter.adapter.3.up_project.bias', 'model.enc_kadapter.adapter.4.down_project.weight', 'model.enc_kadapter.adapter.4.down_project.bias', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.4.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.4.up_project.weight', 'model.enc_kadapter.adapter.4.up_project.bias', 'model.enc_kadapter.adapter.5.down_project.weight', 'model.enc_kadapter.adapter.5.down_project.bias', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.5.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.5.up_project.weight', 'model.enc_kadapter.adapter.5.up_project.bias', 'model.enc_kadapter.pool.weight', 'model.enc_kadapter.pool.bias', 'model.decoder.embed_tokens.weight', 'model.decoder.block.0.layer.0.SelfAttention.q.weight', 'model.decoder.block.0.layer.0.SelfAttention.k.weight', 'model.decoder.block.0.layer.0.SelfAttention.v.weight', 'model.decoder.block.0.layer.0.SelfAttention.o.weight', 'model.decoder.block.0.layer.0.SelfAttention.relative_attention_bias.weight', 'model.decoder.block.0.layer.0.layer_norm.weight', 'model.decoder.block.0.layer.1.EncDecAttention.q.weight', 'model.decoder.block.0.layer.1.EncDecAttention.k.weight', 'model.decoder.block.0.layer.1.EncDecAttention.v.weight', 'model.decoder.block.0.layer.1.EncDecAttention.o.weight', 'model.decoder.block.0.layer.1.layer_norm.weight', 'model.decoder.block.0.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.0.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.0.layer.2.layer_norm.weight', 'model.decoder.block.1.layer.0.SelfAttention.q.weight', 'model.decoder.block.1.layer.0.SelfAttention.k.weight', 'model.decoder.block.1.layer.0.SelfAttention.v.weight', 'model.decoder.block.1.layer.0.SelfAttention.o.weight', 'model.decoder.block.1.layer.0.layer_norm.weight', 'model.decoder.block.1.layer.1.EncDecAttention.q.weight', 'model.decoder.block.1.layer.1.EncDecAttention.k.weight', 'model.decoder.block.1.layer.1.EncDecAttention.v.weight', 'model.decoder.block.1.layer.1.EncDecAttention.o.weight', 'model.decoder.block.1.layer.1.layer_norm.weight', 'model.decoder.block.1.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.1.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.1.layer.2.layer_norm.weight', 'model.decoder.block.2.layer.0.SelfAttention.q.weight', 'model.decoder.block.2.layer.0.SelfAttention.k.weight', 'model.decoder.block.2.layer.0.SelfAttention.v.weight', 'model.decoder.block.2.layer.0.SelfAttention.o.weight', 'model.decoder.block.2.layer.0.layer_norm.weight', 'model.decoder.block.2.layer.1.EncDecAttention.q.weight', 'model.decoder.block.2.layer.1.EncDecAttention.k.weight', 'model.decoder.block.2.layer.1.EncDecAttention.v.weight', 'model.decoder.block.2.layer.1.EncDecAttention.o.weight', 'model.decoder.block.2.layer.1.layer_norm.weight', 'model.decoder.block.2.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.2.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.2.layer.2.layer_norm.weight', 'model.decoder.block.3.layer.0.SelfAttention.q.weight', 'model.decoder.block.3.layer.0.SelfAttention.k.weight', 'model.decoder.block.3.layer.0.SelfAttention.v.weight', 'model.decoder.block.3.layer.0.SelfAttention.o.weight', 'model.decoder.block.3.layer.0.layer_norm.weight', 'model.decoder.block.3.layer.1.EncDecAttention.q.weight', 'model.decoder.block.3.layer.1.EncDecAttention.k.weight', 'model.decoder.block.3.layer.1.EncDecAttention.v.weight', 'model.decoder.block.3.layer.1.EncDecAttention.o.weight', 'model.decoder.block.3.layer.1.layer_norm.weight', 'model.decoder.block.3.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.3.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.3.layer.2.layer_norm.weight', 'model.decoder.block.4.layer.0.SelfAttention.q.weight', 'model.decoder.block.4.layer.0.SelfAttention.k.weight', 'model.decoder.block.4.layer.0.SelfAttention.v.weight', 'model.decoder.block.4.layer.0.SelfAttention.o.weight', 'model.decoder.block.4.layer.0.layer_norm.weight', 'model.decoder.block.4.layer.1.EncDecAttention.q.weight', 'model.decoder.block.4.layer.1.EncDecAttention.k.weight', 'model.decoder.block.4.layer.1.EncDecAttention.v.weight', 'model.decoder.block.4.layer.1.EncDecAttention.o.weight', 'model.decoder.block.4.layer.1.layer_norm.weight', 'model.decoder.block.4.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.4.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.4.layer.2.layer_norm.weight', 'model.decoder.block.5.layer.0.SelfAttention.q.weight', 'model.decoder.block.5.layer.0.SelfAttention.k.weight', 'model.decoder.block.5.layer.0.SelfAttention.v.weight', 'model.decoder.block.5.layer.0.SelfAttention.o.weight', 'model.decoder.block.5.layer.0.layer_norm.weight', 'model.decoder.block.5.layer.1.EncDecAttention.q.weight', 'model.decoder.block.5.layer.1.EncDecAttention.k.weight', 'model.decoder.block.5.layer.1.EncDecAttention.v.weight', 'model.decoder.block.5.layer.1.EncDecAttention.o.weight', 'model.decoder.block.5.layer.1.layer_norm.weight', 'model.decoder.block.5.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.5.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.5.layer.2.layer_norm.weight', 'model.decoder.block.6.layer.0.SelfAttention.q.weight', 'model.decoder.block.6.layer.0.SelfAttention.k.weight', 'model.decoder.block.6.layer.0.SelfAttention.v.weight', 'model.decoder.block.6.layer.0.SelfAttention.o.weight', 'model.decoder.block.6.layer.0.layer_norm.weight', 'model.decoder.block.6.layer.1.EncDecAttention.q.weight', 'model.decoder.block.6.layer.1.EncDecAttention.k.weight', 'model.decoder.block.6.layer.1.EncDecAttention.v.weight', 'model.decoder.block.6.layer.1.EncDecAttention.o.weight', 'model.decoder.block.6.layer.1.layer_norm.weight', 'model.decoder.block.6.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.6.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.6.layer.2.layer_norm.weight', 'model.decoder.block.7.layer.0.SelfAttention.q.weight', 'model.decoder.block.7.layer.0.SelfAttention.k.weight', 'model.decoder.block.7.layer.0.SelfAttention.v.weight', 'model.decoder.block.7.layer.0.SelfAttention.o.weight', 'model.decoder.block.7.layer.0.layer_norm.weight', 'model.decoder.block.7.layer.1.EncDecAttention.q.weight', 'model.decoder.block.7.layer.1.EncDecAttention.k.weight', 'model.decoder.block.7.layer.1.EncDecAttention.v.weight', 'model.decoder.block.7.layer.1.EncDecAttention.o.weight', 'model.decoder.block.7.layer.1.layer_norm.weight', 'model.decoder.block.7.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.7.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.7.layer.2.layer_norm.weight', 'model.decoder.block.8.layer.0.SelfAttention.q.weight', 'model.decoder.block.8.layer.0.SelfAttention.k.weight', 'model.decoder.block.8.layer.0.SelfAttention.v.weight', 'model.decoder.block.8.layer.0.SelfAttention.o.weight', 'model.decoder.block.8.layer.0.layer_norm.weight', 'model.decoder.block.8.layer.1.EncDecAttention.q.weight', 'model.decoder.block.8.layer.1.EncDecAttention.k.weight', 'model.decoder.block.8.layer.1.EncDecAttention.v.weight', 'model.decoder.block.8.layer.1.EncDecAttention.o.weight', 'model.decoder.block.8.layer.1.layer_norm.weight', 'model.decoder.block.8.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.8.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.8.layer.2.layer_norm.weight', 'model.decoder.block.9.layer.0.SelfAttention.q.weight', 'model.decoder.block.9.layer.0.SelfAttention.k.weight', 'model.decoder.block.9.layer.0.SelfAttention.v.weight', 'model.decoder.block.9.layer.0.SelfAttention.o.weight', 'model.decoder.block.9.layer.0.layer_norm.weight', 'model.decoder.block.9.layer.1.EncDecAttention.q.weight', 'model.decoder.block.9.layer.1.EncDecAttention.k.weight', 'model.decoder.block.9.layer.1.EncDecAttention.v.weight', 'model.decoder.block.9.layer.1.EncDecAttention.o.weight', 'model.decoder.block.9.layer.1.layer_norm.weight', 'model.decoder.block.9.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.9.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.9.layer.2.layer_norm.weight', 'model.decoder.block.10.layer.0.SelfAttention.q.weight', 'model.decoder.block.10.layer.0.SelfAttention.k.weight', 'model.decoder.block.10.layer.0.SelfAttention.v.weight', 'model.decoder.block.10.layer.0.SelfAttention.o.weight', 'model.decoder.block.10.layer.0.layer_norm.weight', 'model.decoder.block.10.layer.1.EncDecAttention.q.weight', 'model.decoder.block.10.layer.1.EncDecAttention.k.weight', 'model.decoder.block.10.layer.1.EncDecAttention.v.weight', 'model.decoder.block.10.layer.1.EncDecAttention.o.weight', 'model.decoder.block.10.layer.1.layer_norm.weight', 'model.decoder.block.10.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.10.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.10.layer.2.layer_norm.weight', 'model.decoder.block.11.layer.0.SelfAttention.q.weight', 'model.decoder.block.11.layer.0.SelfAttention.k.weight', 'model.decoder.block.11.layer.0.SelfAttention.v.weight', 'model.decoder.block.11.layer.0.SelfAttention.o.weight', 'model.decoder.block.11.layer.0.layer_norm.weight', 'model.decoder.block.11.layer.1.EncDecAttention.q.weight', 'model.decoder.block.11.layer.1.EncDecAttention.k.weight', 'model.decoder.block.11.layer.1.EncDecAttention.v.weight', 'model.decoder.block.11.layer.1.EncDecAttention.o.weight', 'model.decoder.block.11.layer.1.layer_norm.weight', 'model.decoder.block.11.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.11.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.11.layer.2.layer_norm.weight', 'model.decoder.block.12.layer.0.SelfAttention.q.weight', 'model.decoder.block.12.layer.0.SelfAttention.k.weight', 'model.decoder.block.12.layer.0.SelfAttention.v.weight', 'model.decoder.block.12.layer.0.SelfAttention.o.weight', 'model.decoder.block.12.layer.0.layer_norm.weight', 'model.decoder.block.12.layer.1.EncDecAttention.q.weight', 'model.decoder.block.12.layer.1.EncDecAttention.k.weight', 'model.decoder.block.12.layer.1.EncDecAttention.v.weight', 'model.decoder.block.12.layer.1.EncDecAttention.o.weight', 'model.decoder.block.12.layer.1.layer_norm.weight', 'model.decoder.block.12.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.12.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.12.layer.2.layer_norm.weight', 'model.decoder.block.13.layer.0.SelfAttention.q.weight', 'model.decoder.block.13.layer.0.SelfAttention.k.weight', 'model.decoder.block.13.layer.0.SelfAttention.v.weight', 'model.decoder.block.13.layer.0.SelfAttention.o.weight', 'model.decoder.block.13.layer.0.layer_norm.weight', 'model.decoder.block.13.layer.1.EncDecAttention.q.weight', 'model.decoder.block.13.layer.1.EncDecAttention.k.weight', 'model.decoder.block.13.layer.1.EncDecAttention.v.weight', 'model.decoder.block.13.layer.1.EncDecAttention.o.weight', 'model.decoder.block.13.layer.1.layer_norm.weight', 'model.decoder.block.13.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.13.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.13.layer.2.layer_norm.weight', 'model.decoder.block.14.layer.0.SelfAttention.q.weight', 'model.decoder.block.14.layer.0.SelfAttention.k.weight', 'model.decoder.block.14.layer.0.SelfAttention.v.weight', 'model.decoder.block.14.layer.0.SelfAttention.o.weight', 'model.decoder.block.14.layer.0.layer_norm.weight', 'model.decoder.block.14.layer.1.EncDecAttention.q.weight', 'model.decoder.block.14.layer.1.EncDecAttention.k.weight', 'model.decoder.block.14.layer.1.EncDecAttention.v.weight', 'model.decoder.block.14.layer.1.EncDecAttention.o.weight', 'model.decoder.block.14.layer.1.layer_norm.weight', 'model.decoder.block.14.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.14.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.14.layer.2.layer_norm.weight', 'model.decoder.block.15.layer.0.SelfAttention.q.weight', 'model.decoder.block.15.layer.0.SelfAttention.k.weight', 'model.decoder.block.15.layer.0.SelfAttention.v.weight', 'model.decoder.block.15.layer.0.SelfAttention.o.weight', 'model.decoder.block.15.layer.0.layer_norm.weight', 'model.decoder.block.15.layer.1.EncDecAttention.q.weight', 'model.decoder.block.15.layer.1.EncDecAttention.k.weight', 'model.decoder.block.15.layer.1.EncDecAttention.v.weight', 'model.decoder.block.15.layer.1.EncDecAttention.o.weight', 'model.decoder.block.15.layer.1.layer_norm.weight', 'model.decoder.block.15.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.15.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.15.layer.2.layer_norm.weight', 'model.decoder.block.16.layer.0.SelfAttention.q.weight', 'model.decoder.block.16.layer.0.SelfAttention.k.weight', 'model.decoder.block.16.layer.0.SelfAttention.v.weight', 'model.decoder.block.16.layer.0.SelfAttention.o.weight', 'model.decoder.block.16.layer.0.layer_norm.weight', 'model.decoder.block.16.layer.1.EncDecAttention.q.weight', 'model.decoder.block.16.layer.1.EncDecAttention.k.weight', 'model.decoder.block.16.layer.1.EncDecAttention.v.weight', 'model.decoder.block.16.layer.1.EncDecAttention.o.weight', 'model.decoder.block.16.layer.1.layer_norm.weight', 'model.decoder.block.16.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.16.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.16.layer.2.layer_norm.weight', 'model.decoder.block.17.layer.0.SelfAttention.q.weight', 'model.decoder.block.17.layer.0.SelfAttention.k.weight', 'model.decoder.block.17.layer.0.SelfAttention.v.weight', 'model.decoder.block.17.layer.0.SelfAttention.o.weight', 'model.decoder.block.17.layer.0.layer_norm.weight', 'model.decoder.block.17.layer.1.EncDecAttention.q.weight', 'model.decoder.block.17.layer.1.EncDecAttention.k.weight', 'model.decoder.block.17.layer.1.EncDecAttention.v.weight', 'model.decoder.block.17.layer.1.EncDecAttention.o.weight', 'model.decoder.block.17.layer.1.layer_norm.weight', 'model.decoder.block.17.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.17.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.17.layer.2.layer_norm.weight', 'model.decoder.block.18.layer.0.SelfAttention.q.weight', 'model.decoder.block.18.layer.0.SelfAttention.k.weight', 'model.decoder.block.18.layer.0.SelfAttention.v.weight', 'model.decoder.block.18.layer.0.SelfAttention.o.weight', 'model.decoder.block.18.layer.0.layer_norm.weight', 'model.decoder.block.18.layer.1.EncDecAttention.q.weight', 'model.decoder.block.18.layer.1.EncDecAttention.k.weight', 'model.decoder.block.18.layer.1.EncDecAttention.v.weight', 'model.decoder.block.18.layer.1.EncDecAttention.o.weight', 'model.decoder.block.18.layer.1.layer_norm.weight', 'model.decoder.block.18.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.18.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.18.layer.2.layer_norm.weight', 'model.decoder.block.19.layer.0.SelfAttention.q.weight', 'model.decoder.block.19.layer.0.SelfAttention.k.weight', 'model.decoder.block.19.layer.0.SelfAttention.v.weight', 'model.decoder.block.19.layer.0.SelfAttention.o.weight', 'model.decoder.block.19.layer.0.layer_norm.weight', 'model.decoder.block.19.layer.1.EncDecAttention.q.weight', 'model.decoder.block.19.layer.1.EncDecAttention.k.weight', 'model.decoder.block.19.layer.1.EncDecAttention.v.weight', 'model.decoder.block.19.layer.1.EncDecAttention.o.weight', 'model.decoder.block.19.layer.1.layer_norm.weight', 'model.decoder.block.19.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.19.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.19.layer.2.layer_norm.weight', 'model.decoder.block.20.layer.0.SelfAttention.q.weight', 'model.decoder.block.20.layer.0.SelfAttention.k.weight', 'model.decoder.block.20.layer.0.SelfAttention.v.weight', 'model.decoder.block.20.layer.0.SelfAttention.o.weight', 'model.decoder.block.20.layer.0.layer_norm.weight', 'model.decoder.block.20.layer.1.EncDecAttention.q.weight', 'model.decoder.block.20.layer.1.EncDecAttention.k.weight', 'model.decoder.block.20.layer.1.EncDecAttention.v.weight', 'model.decoder.block.20.layer.1.EncDecAttention.o.weight', 'model.decoder.block.20.layer.1.layer_norm.weight', 'model.decoder.block.20.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.20.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.20.layer.2.layer_norm.weight', 'model.decoder.block.21.layer.0.SelfAttention.q.weight', 'model.decoder.block.21.layer.0.SelfAttention.k.weight', 'model.decoder.block.21.layer.0.SelfAttention.v.weight', 'model.decoder.block.21.layer.0.SelfAttention.o.weight', 'model.decoder.block.21.layer.0.layer_norm.weight', 'model.decoder.block.21.layer.1.EncDecAttention.q.weight', 'model.decoder.block.21.layer.1.EncDecAttention.k.weight', 'model.decoder.block.21.layer.1.EncDecAttention.v.weight', 'model.decoder.block.21.layer.1.EncDecAttention.o.weight', 'model.decoder.block.21.layer.1.layer_norm.weight', 'model.decoder.block.21.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.21.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.21.layer.2.layer_norm.weight', 'model.decoder.block.22.layer.0.SelfAttention.q.weight', 'model.decoder.block.22.layer.0.SelfAttention.k.weight', 'model.decoder.block.22.layer.0.SelfAttention.v.weight', 'model.decoder.block.22.layer.0.SelfAttention.o.weight', 'model.decoder.block.22.layer.0.layer_norm.weight', 'model.decoder.block.22.layer.1.EncDecAttention.q.weight', 'model.decoder.block.22.layer.1.EncDecAttention.k.weight', 'model.decoder.block.22.layer.1.EncDecAttention.v.weight', 'model.decoder.block.22.layer.1.EncDecAttention.o.weight', 'model.decoder.block.22.layer.1.layer_norm.weight', 'model.decoder.block.22.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.22.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.22.layer.2.layer_norm.weight', 'model.decoder.block.23.layer.0.SelfAttention.q.weight', 'model.decoder.block.23.layer.0.SelfAttention.k.weight', 'model.decoder.block.23.layer.0.SelfAttention.v.weight', 'model.decoder.block.23.layer.0.SelfAttention.o.weight', 'model.decoder.block.23.layer.0.layer_norm.weight', 'model.decoder.block.23.layer.1.EncDecAttention.q.weight', 'model.decoder.block.23.layer.1.EncDecAttention.k.weight', 'model.decoder.block.23.layer.1.EncDecAttention.v.weight', 'model.decoder.block.23.layer.1.EncDecAttention.o.weight', 'model.decoder.block.23.layer.1.layer_norm.weight', 'model.decoder.block.23.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.23.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.23.layer.2.layer_norm.weight', 'model.decoder.final_layer_norm.weight', 'model.lm_head.weight'])
hparams.learning_rate = 0.002
split is 0
Length of dataset retrieving is.. 500000
Index(['id', 'date', 'input', 'output'], dtype='object')
----------Sampler init----------
mid epoch = False
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 10000
Index(['id', 'date', 'input', 'output'], dtype='object')
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.010 MB uploaded (0.000 MB deduped)
wandb: - 0.004 MB of 0.058 MB uploaded (0.000 MB deduped)
wandb: \ 0.058 MB of 0.058 MB uploaded (0.000 MB deduped)
wandb: | 0.058 MB of 0.058 MB uploaded (0.000 MB deduped)
wandb: / 0.058 MB of 0.058 MB uploaded (0.000 MB deduped)
wandb: - 0.058 MB of 0.058 MB uploaded (0.000 MB deduped)
wandb: \ 0.058 MB of 0.058 MB uploaded (0.000 MB deduped)
wandb: | 0.058 MB of 0.058 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced kadapter_2011: https://wandb.ai/tjung2/temporal_questions/runs/i1gim1yv
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20221115_070232-i1gim1yv/logs
Traceback (most recent call last):
  File "run.py", line 273, in <module>
    main()
  File "run.py", line 263, in main
    trainer.fit(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 460, in fit
    self._run(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 758, in _run
    self.dispatch()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 799, in dispatch
    self.accelerator.start_training(self)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/accelerator.py", line 96, in start_training
    self.training_type_plugin.start_training(trainer)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/plugins/training_type/training_type_plugin.py", line 144, in start_training
    self._results = trainer.run_stage()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 809, in run_stage
    return self.run_train()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 844, in run_train
    self.run_sanity_check(self.lightning_module)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 1112, in run_sanity_check
    self.run_evaluation()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 967, in run_evaluation
    output = self.evaluation_loop.evaluation_step(batch, batch_idx, dataloader_idx)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/evaluation_loop.py", line 174, in evaluation_step
    output = self.trainer.accelerator.validation_step(args)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/accelerator.py", line 226, in validation_step
    return self.training_type_plugin.validation_step(*args)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/plugins/training_type/training_type_plugin.py", line 161, in validation_step
    return self.lightning_module.validation_step(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 428, in validation_step
    answer_list = self.ids_to_answers[str(ids)]
KeyError: '0'
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.5 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20221115_070401-2kedrh5t
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_2012
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/2kedrh5t
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-large-ssm and are newly initialized: ['enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.5.down_project.bias', 'enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.3.up_project.bias', 'enc_kadapter.adapter.4.up_project.bias', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.3.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.adapter.5.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.4.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.5.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.4.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.4.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.5.down_project.weight', 'enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.3.down_project.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.4.down_project.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.3.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.3.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.4.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.5.up_project.bias', 'enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.3.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.5.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.k.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Set SLURM handle signals.
  | Name  | Type                       | Params
-----------------------------------------------------
0 | model | T5ForConditionalGeneration | 748 M 
-----------------------------------------------------
11.0 M    Trainable params
737 M     Non-trainable params
748 M     Total params
2,994.763 Total estimated model params size (MB)
checkpoint path = outputs/wmtkadapter_full_2freeze_11221222324_128/epoch=0-f1_score=0.2566-em_score=0.2175.ckpt
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 12, 21, 22, 23, 24], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': None, 'years_to_paths': None, 'load_adapters': None}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 12, 21, 22, 23, 24], check_validation_only=False, checkpoint_dir='outputs/wmtkadapter_full_2freeze_11221222324_128', checkpoint_path='outputs/wmtkadapter_full_2freeze_11221222324_128/epoch=0-f1_score=0.2566-em_score=0.2175.ckpt', dataset='wmt', dataset_version='2012', early_stop_callback=False, eval_batch_size=32, find_lr=False, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.002, load_adapters=None, max_grad_norm=0.5, max_input_length=100, max_output_length=50, method='kadapter', mode='pretrain', model_name_or_path='google/t5-large-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=1, num_workers=4, opt_level='O1', output_dir='outputs/wmtkadapter_2012_2freeze_11221222324_128', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-large-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=2500, val_data='2012', wandb_log=True, warmup_steps=0, weight_decay=0.0, years_to_paths=None)
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
    12,
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
  "load_adapters": null,
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
  "vocab_size": 32128,
  "years_to_paths": null
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
enc_kadapter.pool.weight
enc_kadapter.pool.bias
odict_keys(['model.shared.weight', 'model.encoder.embed_tokens.weight', 'model.encoder.block.0.layer.0.SelfAttention.q.weight', 'model.encoder.block.0.layer.0.SelfAttention.k.weight', 'model.encoder.block.0.layer.0.SelfAttention.v.weight', 'model.encoder.block.0.layer.0.SelfAttention.o.weight', 'model.encoder.block.0.layer.0.SelfAttention.relative_attention_bias.weight', 'model.encoder.block.0.layer.0.layer_norm.weight', 'model.encoder.block.0.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.0.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.0.layer.1.layer_norm.weight', 'model.encoder.block.1.layer.0.SelfAttention.q.weight', 'model.encoder.block.1.layer.0.SelfAttention.k.weight', 'model.encoder.block.1.layer.0.SelfAttention.v.weight', 'model.encoder.block.1.layer.0.SelfAttention.o.weight', 'model.encoder.block.1.layer.0.layer_norm.weight', 'model.encoder.block.1.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.1.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.1.layer.1.layer_norm.weight', 'model.encoder.block.2.layer.0.SelfAttention.q.weight', 'model.encoder.block.2.layer.0.SelfAttention.k.weight', 'model.encoder.block.2.layer.0.SelfAttention.v.weight', 'model.encoder.block.2.layer.0.SelfAttention.o.weight', 'model.encoder.block.2.layer.0.layer_norm.weight', 'model.encoder.block.2.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.2.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.2.layer.1.layer_norm.weight', 'model.encoder.block.3.layer.0.SelfAttention.q.weight', 'model.encoder.block.3.layer.0.SelfAttention.k.weight', 'model.encoder.block.3.layer.0.SelfAttention.v.weight', 'model.encoder.block.3.layer.0.SelfAttention.o.weight', 'model.encoder.block.3.layer.0.layer_norm.weight', 'model.encoder.block.3.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.3.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.3.layer.1.layer_norm.weight', 'model.encoder.block.4.layer.0.SelfAttention.q.weight', 'model.encoder.block.4.layer.0.SelfAttention.k.weight', 'model.encoder.block.4.layer.0.SelfAttention.v.weight', 'model.encoder.block.4.layer.0.SelfAttention.o.weight', 'model.encoder.block.4.layer.0.layer_norm.weight', 'model.encoder.block.4.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.4.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.4.layer.1.layer_norm.weight', 'model.encoder.block.5.layer.0.SelfAttention.q.weight', 'model.encoder.block.5.layer.0.SelfAttention.k.weight', 'model.encoder.block.5.layer.0.SelfAttention.v.weight', 'model.encoder.block.5.layer.0.SelfAttention.o.weight', 'model.encoder.block.5.layer.0.layer_norm.weight', 'model.encoder.block.5.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.5.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.5.layer.1.layer_norm.weight', 'model.encoder.block.6.layer.0.SelfAttention.q.weight', 'model.encoder.block.6.layer.0.SelfAttention.k.weight', 'model.encoder.block.6.layer.0.SelfAttention.v.weight', 'model.encoder.block.6.layer.0.SelfAttention.o.weight', 'model.encoder.block.6.layer.0.layer_norm.weight', 'model.encoder.block.6.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.6.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.6.layer.1.layer_norm.weight', 'model.encoder.block.7.layer.0.SelfAttention.q.weight', 'model.encoder.block.7.layer.0.SelfAttention.k.weight', 'model.encoder.block.7.layer.0.SelfAttention.v.weight', 'model.encoder.block.7.layer.0.SelfAttention.o.weight', 'model.encoder.block.7.layer.0.layer_norm.weight', 'model.encoder.block.7.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.7.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.7.layer.1.layer_norm.weight', 'model.encoder.block.8.layer.0.SelfAttention.q.weight', 'model.encoder.block.8.layer.0.SelfAttention.k.weight', 'model.encoder.block.8.layer.0.SelfAttention.v.weight', 'model.encoder.block.8.layer.0.SelfAttention.o.weight', 'model.encoder.block.8.layer.0.layer_norm.weight', 'model.encoder.block.8.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.8.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.8.layer.1.layer_norm.weight', 'model.encoder.block.9.layer.0.SelfAttention.q.weight', 'model.encoder.block.9.layer.0.SelfAttention.k.weight', 'model.encoder.block.9.layer.0.SelfAttention.v.weight', 'model.encoder.block.9.layer.0.SelfAttention.o.weight', 'model.encoder.block.9.layer.0.layer_norm.weight', 'model.encoder.block.9.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.9.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.9.layer.1.layer_norm.weight', 'model.encoder.block.10.layer.0.SelfAttention.q.weight', 'model.encoder.block.10.layer.0.SelfAttention.k.weight', 'model.encoder.block.10.layer.0.SelfAttention.v.weight', 'model.encoder.block.10.layer.0.SelfAttention.o.weight', 'model.encoder.block.10.layer.0.layer_norm.weight', 'model.encoder.block.10.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.10.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.10.layer.1.layer_norm.weight', 'model.encoder.block.11.layer.0.SelfAttention.q.weight', 'model.encoder.block.11.layer.0.SelfAttention.k.weight', 'model.encoder.block.11.layer.0.SelfAttention.v.weight', 'model.encoder.block.11.layer.0.SelfAttention.o.weight', 'model.encoder.block.11.layer.0.layer_norm.weight', 'model.encoder.block.11.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.11.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.11.layer.1.layer_norm.weight', 'model.encoder.block.12.layer.0.SelfAttention.q.weight', 'model.encoder.block.12.layer.0.SelfAttention.k.weight', 'model.encoder.block.12.layer.0.SelfAttention.v.weight', 'model.encoder.block.12.layer.0.SelfAttention.o.weight', 'model.encoder.block.12.layer.0.layer_norm.weight', 'model.encoder.block.12.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.12.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.12.layer.1.layer_norm.weight', 'model.encoder.block.13.layer.0.SelfAttention.q.weight', 'model.encoder.block.13.layer.0.SelfAttention.k.weight', 'model.encoder.block.13.layer.0.SelfAttention.v.weight', 'model.encoder.block.13.layer.0.SelfAttention.o.weight', 'model.encoder.block.13.layer.0.layer_norm.weight', 'model.encoder.block.13.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.13.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.13.layer.1.layer_norm.weight', 'model.encoder.block.14.layer.0.SelfAttention.q.weight', 'model.encoder.block.14.layer.0.SelfAttention.k.weight', 'model.encoder.block.14.layer.0.SelfAttention.v.weight', 'model.encoder.block.14.layer.0.SelfAttention.o.weight', 'model.encoder.block.14.layer.0.layer_norm.weight', 'model.encoder.block.14.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.14.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.14.layer.1.layer_norm.weight', 'model.encoder.block.15.layer.0.SelfAttention.q.weight', 'model.encoder.block.15.layer.0.SelfAttention.k.weight', 'model.encoder.block.15.layer.0.SelfAttention.v.weight', 'model.encoder.block.15.layer.0.SelfAttention.o.weight', 'model.encoder.block.15.layer.0.layer_norm.weight', 'model.encoder.block.15.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.15.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.15.layer.1.layer_norm.weight', 'model.encoder.block.16.layer.0.SelfAttention.q.weight', 'model.encoder.block.16.layer.0.SelfAttention.k.weight', 'model.encoder.block.16.layer.0.SelfAttention.v.weight', 'model.encoder.block.16.layer.0.SelfAttention.o.weight', 'model.encoder.block.16.layer.0.layer_norm.weight', 'model.encoder.block.16.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.16.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.16.layer.1.layer_norm.weight', 'model.encoder.block.17.layer.0.SelfAttention.q.weight', 'model.encoder.block.17.layer.0.SelfAttention.k.weight', 'model.encoder.block.17.layer.0.SelfAttention.v.weight', 'model.encoder.block.17.layer.0.SelfAttention.o.weight', 'model.encoder.block.17.layer.0.layer_norm.weight', 'model.encoder.block.17.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.17.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.17.layer.1.layer_norm.weight', 'model.encoder.block.18.layer.0.SelfAttention.q.weight', 'model.encoder.block.18.layer.0.SelfAttention.k.weight', 'model.encoder.block.18.layer.0.SelfAttention.v.weight', 'model.encoder.block.18.layer.0.SelfAttention.o.weight', 'model.encoder.block.18.layer.0.layer_norm.weight', 'model.encoder.block.18.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.18.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.18.layer.1.layer_norm.weight', 'model.encoder.block.19.layer.0.SelfAttention.q.weight', 'model.encoder.block.19.layer.0.SelfAttention.k.weight', 'model.encoder.block.19.layer.0.SelfAttention.v.weight', 'model.encoder.block.19.layer.0.SelfAttention.o.weight', 'model.encoder.block.19.layer.0.layer_norm.weight', 'model.encoder.block.19.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.19.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.19.layer.1.layer_norm.weight', 'model.encoder.block.20.layer.0.SelfAttention.q.weight', 'model.encoder.block.20.layer.0.SelfAttention.k.weight', 'model.encoder.block.20.layer.0.SelfAttention.v.weight', 'model.encoder.block.20.layer.0.SelfAttention.o.weight', 'model.encoder.block.20.layer.0.layer_norm.weight', 'model.encoder.block.20.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.20.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.20.layer.1.layer_norm.weight', 'model.encoder.block.21.layer.0.SelfAttention.q.weight', 'model.encoder.block.21.layer.0.SelfAttention.k.weight', 'model.encoder.block.21.layer.0.SelfAttention.v.weight', 'model.encoder.block.21.layer.0.SelfAttention.o.weight', 'model.encoder.block.21.layer.0.layer_norm.weight', 'model.encoder.block.21.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.21.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.21.layer.1.layer_norm.weight', 'model.encoder.block.22.layer.0.SelfAttention.q.weight', 'model.encoder.block.22.layer.0.SelfAttention.k.weight', 'model.encoder.block.22.layer.0.SelfAttention.v.weight', 'model.encoder.block.22.layer.0.SelfAttention.o.weight', 'model.encoder.block.22.layer.0.layer_norm.weight', 'model.encoder.block.22.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.22.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.22.layer.1.layer_norm.weight', 'model.encoder.block.23.layer.0.SelfAttention.q.weight', 'model.encoder.block.23.layer.0.SelfAttention.k.weight', 'model.encoder.block.23.layer.0.SelfAttention.v.weight', 'model.encoder.block.23.layer.0.SelfAttention.o.weight', 'model.encoder.block.23.layer.0.layer_norm.weight', 'model.encoder.block.23.layer.1.DenseReluDense.wi.weight', 'model.encoder.block.23.layer.1.DenseReluDense.wo.weight', 'model.encoder.block.23.layer.1.layer_norm.weight', 'model.encoder.final_layer_norm.weight', 'model.enc_kadapter.layer_norm.weight', 'model.enc_kadapter.adapter.0.down_project.weight', 'model.enc_kadapter.adapter.0.down_project.bias', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.0.up_project.weight', 'model.enc_kadapter.adapter.0.up_project.bias', 'model.enc_kadapter.adapter.1.down_project.weight', 'model.enc_kadapter.adapter.1.down_project.bias', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.1.up_project.weight', 'model.enc_kadapter.adapter.1.up_project.bias', 'model.enc_kadapter.adapter.2.down_project.weight', 'model.enc_kadapter.adapter.2.down_project.bias', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.2.up_project.weight', 'model.enc_kadapter.adapter.2.up_project.bias', 'model.enc_kadapter.adapter.3.down_project.weight', 'model.enc_kadapter.adapter.3.down_project.bias', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.3.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.3.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.3.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.3.up_project.weight', 'model.enc_kadapter.adapter.3.up_project.bias', 'model.enc_kadapter.adapter.4.down_project.weight', 'model.enc_kadapter.adapter.4.down_project.bias', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.4.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.4.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.4.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.4.up_project.weight', 'model.enc_kadapter.adapter.4.up_project.bias', 'model.enc_kadapter.adapter.5.down_project.weight', 'model.enc_kadapter.adapter.5.down_project.bias', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.q.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.k.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.v.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.o.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'model.enc_kadapter.adapter.5.encoder.layer.0.layer_norm.weight', 'model.enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wi.weight', 'model.enc_kadapter.adapter.5.encoder.layer.1.DenseReluDense.wo.weight', 'model.enc_kadapter.adapter.5.encoder.layer.1.layer_norm.weight', 'model.enc_kadapter.adapter.5.up_project.weight', 'model.enc_kadapter.adapter.5.up_project.bias', 'model.enc_kadapter.pool.weight', 'model.enc_kadapter.pool.bias', 'model.decoder.embed_tokens.weight', 'model.decoder.block.0.layer.0.SelfAttention.q.weight', 'model.decoder.block.0.layer.0.SelfAttention.k.weight', 'model.decoder.block.0.layer.0.SelfAttention.v.weight', 'model.decoder.block.0.layer.0.SelfAttention.o.weight', 'model.decoder.block.0.layer.0.SelfAttention.relative_attention_bias.weight', 'model.decoder.block.0.layer.0.layer_norm.weight', 'model.decoder.block.0.layer.1.EncDecAttention.q.weight', 'model.decoder.block.0.layer.1.EncDecAttention.k.weight', 'model.decoder.block.0.layer.1.EncDecAttention.v.weight', 'model.decoder.block.0.layer.1.EncDecAttention.o.weight', 'model.decoder.block.0.layer.1.layer_norm.weight', 'model.decoder.block.0.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.0.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.0.layer.2.layer_norm.weight', 'model.decoder.block.1.layer.0.SelfAttention.q.weight', 'model.decoder.block.1.layer.0.SelfAttention.k.weight', 'model.decoder.block.1.layer.0.SelfAttention.v.weight', 'model.decoder.block.1.layer.0.SelfAttention.o.weight', 'model.decoder.block.1.layer.0.layer_norm.weight', 'model.decoder.block.1.layer.1.EncDecAttention.q.weight', 'model.decoder.block.1.layer.1.EncDecAttention.k.weight', 'model.decoder.block.1.layer.1.EncDecAttention.v.weight', 'model.decoder.block.1.layer.1.EncDecAttention.o.weight', 'model.decoder.block.1.layer.1.layer_norm.weight', 'model.decoder.block.1.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.1.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.1.layer.2.layer_norm.weight', 'model.decoder.block.2.layer.0.SelfAttention.q.weight', 'model.decoder.block.2.layer.0.SelfAttention.k.weight', 'model.decoder.block.2.layer.0.SelfAttention.v.weight', 'model.decoder.block.2.layer.0.SelfAttention.o.weight', 'model.decoder.block.2.layer.0.layer_norm.weight', 'model.decoder.block.2.layer.1.EncDecAttention.q.weight', 'model.decoder.block.2.layer.1.EncDecAttention.k.weight', 'model.decoder.block.2.layer.1.EncDecAttention.v.weight', 'model.decoder.block.2.layer.1.EncDecAttention.o.weight', 'model.decoder.block.2.layer.1.layer_norm.weight', 'model.decoder.block.2.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.2.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.2.layer.2.layer_norm.weight', 'model.decoder.block.3.layer.0.SelfAttention.q.weight', 'model.decoder.block.3.layer.0.SelfAttention.k.weight', 'model.decoder.block.3.layer.0.SelfAttention.v.weight', 'model.decoder.block.3.layer.0.SelfAttention.o.weight', 'model.decoder.block.3.layer.0.layer_norm.weight', 'model.decoder.block.3.layer.1.EncDecAttention.q.weight', 'model.decoder.block.3.layer.1.EncDecAttention.k.weight', 'model.decoder.block.3.layer.1.EncDecAttention.v.weight', 'model.decoder.block.3.layer.1.EncDecAttention.o.weight', 'model.decoder.block.3.layer.1.layer_norm.weight', 'model.decoder.block.3.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.3.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.3.layer.2.layer_norm.weight', 'model.decoder.block.4.layer.0.SelfAttention.q.weight', 'model.decoder.block.4.layer.0.SelfAttention.k.weight', 'model.decoder.block.4.layer.0.SelfAttention.v.weight', 'model.decoder.block.4.layer.0.SelfAttention.o.weight', 'model.decoder.block.4.layer.0.layer_norm.weight', 'model.decoder.block.4.layer.1.EncDecAttention.q.weight', 'model.decoder.block.4.layer.1.EncDecAttention.k.weight', 'model.decoder.block.4.layer.1.EncDecAttention.v.weight', 'model.decoder.block.4.layer.1.EncDecAttention.o.weight', 'model.decoder.block.4.layer.1.layer_norm.weight', 'model.decoder.block.4.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.4.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.4.layer.2.layer_norm.weight', 'model.decoder.block.5.layer.0.SelfAttention.q.weight', 'model.decoder.block.5.layer.0.SelfAttention.k.weight', 'model.decoder.block.5.layer.0.SelfAttention.v.weight', 'model.decoder.block.5.layer.0.SelfAttention.o.weight', 'model.decoder.block.5.layer.0.layer_norm.weight', 'model.decoder.block.5.layer.1.EncDecAttention.q.weight', 'model.decoder.block.5.layer.1.EncDecAttention.k.weight', 'model.decoder.block.5.layer.1.EncDecAttention.v.weight', 'model.decoder.block.5.layer.1.EncDecAttention.o.weight', 'model.decoder.block.5.layer.1.layer_norm.weight', 'model.decoder.block.5.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.5.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.5.layer.2.layer_norm.weight', 'model.decoder.block.6.layer.0.SelfAttention.q.weight', 'model.decoder.block.6.layer.0.SelfAttention.k.weight', 'model.decoder.block.6.layer.0.SelfAttention.v.weight', 'model.decoder.block.6.layer.0.SelfAttention.o.weight', 'model.decoder.block.6.layer.0.layer_norm.weight', 'model.decoder.block.6.layer.1.EncDecAttention.q.weight', 'model.decoder.block.6.layer.1.EncDecAttention.k.weight', 'model.decoder.block.6.layer.1.EncDecAttention.v.weight', 'model.decoder.block.6.layer.1.EncDecAttention.o.weight', 'model.decoder.block.6.layer.1.layer_norm.weight', 'model.decoder.block.6.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.6.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.6.layer.2.layer_norm.weight', 'model.decoder.block.7.layer.0.SelfAttention.q.weight', 'model.decoder.block.7.layer.0.SelfAttention.k.weight', 'model.decoder.block.7.layer.0.SelfAttention.v.weight', 'model.decoder.block.7.layer.0.SelfAttention.o.weight', 'model.decoder.block.7.layer.0.layer_norm.weight', 'model.decoder.block.7.layer.1.EncDecAttention.q.weight', 'model.decoder.block.7.layer.1.EncDecAttention.k.weight', 'model.decoder.block.7.layer.1.EncDecAttention.v.weight', 'model.decoder.block.7.layer.1.EncDecAttention.o.weight', 'model.decoder.block.7.layer.1.layer_norm.weight', 'model.decoder.block.7.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.7.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.7.layer.2.layer_norm.weight', 'model.decoder.block.8.layer.0.SelfAttention.q.weight', 'model.decoder.block.8.layer.0.SelfAttention.k.weight', 'model.decoder.block.8.layer.0.SelfAttention.v.weight', 'model.decoder.block.8.layer.0.SelfAttention.o.weight', 'model.decoder.block.8.layer.0.layer_norm.weight', 'model.decoder.block.8.layer.1.EncDecAttention.q.weight', 'model.decoder.block.8.layer.1.EncDecAttention.k.weight', 'model.decoder.block.8.layer.1.EncDecAttention.v.weight', 'model.decoder.block.8.layer.1.EncDecAttention.o.weight', 'model.decoder.block.8.layer.1.layer_norm.weight', 'model.decoder.block.8.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.8.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.8.layer.2.layer_norm.weight', 'model.decoder.block.9.layer.0.SelfAttention.q.weight', 'model.decoder.block.9.layer.0.SelfAttention.k.weight', 'model.decoder.block.9.layer.0.SelfAttention.v.weight', 'model.decoder.block.9.layer.0.SelfAttention.o.weight', 'model.decoder.block.9.layer.0.layer_norm.weight', 'model.decoder.block.9.layer.1.EncDecAttention.q.weight', 'model.decoder.block.9.layer.1.EncDecAttention.k.weight', 'model.decoder.block.9.layer.1.EncDecAttention.v.weight', 'model.decoder.block.9.layer.1.EncDecAttention.o.weight', 'model.decoder.block.9.layer.1.layer_norm.weight', 'model.decoder.block.9.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.9.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.9.layer.2.layer_norm.weight', 'model.decoder.block.10.layer.0.SelfAttention.q.weight', 'model.decoder.block.10.layer.0.SelfAttention.k.weight', 'model.decoder.block.10.layer.0.SelfAttention.v.weight', 'model.decoder.block.10.layer.0.SelfAttention.o.weight', 'model.decoder.block.10.layer.0.layer_norm.weight', 'model.decoder.block.10.layer.1.EncDecAttention.q.weight', 'model.decoder.block.10.layer.1.EncDecAttention.k.weight', 'model.decoder.block.10.layer.1.EncDecAttention.v.weight', 'model.decoder.block.10.layer.1.EncDecAttention.o.weight', 'model.decoder.block.10.layer.1.layer_norm.weight', 'model.decoder.block.10.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.10.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.10.layer.2.layer_norm.weight', 'model.decoder.block.11.layer.0.SelfAttention.q.weight', 'model.decoder.block.11.layer.0.SelfAttention.k.weight', 'model.decoder.block.11.layer.0.SelfAttention.v.weight', 'model.decoder.block.11.layer.0.SelfAttention.o.weight', 'model.decoder.block.11.layer.0.layer_norm.weight', 'model.decoder.block.11.layer.1.EncDecAttention.q.weight', 'model.decoder.block.11.layer.1.EncDecAttention.k.weight', 'model.decoder.block.11.layer.1.EncDecAttention.v.weight', 'model.decoder.block.11.layer.1.EncDecAttention.o.weight', 'model.decoder.block.11.layer.1.layer_norm.weight', 'model.decoder.block.11.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.11.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.11.layer.2.layer_norm.weight', 'model.decoder.block.12.layer.0.SelfAttention.q.weight', 'model.decoder.block.12.layer.0.SelfAttention.k.weight', 'model.decoder.block.12.layer.0.SelfAttention.v.weight', 'model.decoder.block.12.layer.0.SelfAttention.o.weight', 'model.decoder.block.12.layer.0.layer_norm.weight', 'model.decoder.block.12.layer.1.EncDecAttention.q.weight', 'model.decoder.block.12.layer.1.EncDecAttention.k.weight', 'model.decoder.block.12.layer.1.EncDecAttention.v.weight', 'model.decoder.block.12.layer.1.EncDecAttention.o.weight', 'model.decoder.block.12.layer.1.layer_norm.weight', 'model.decoder.block.12.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.12.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.12.layer.2.layer_norm.weight', 'model.decoder.block.13.layer.0.SelfAttention.q.weight', 'model.decoder.block.13.layer.0.SelfAttention.k.weight', 'model.decoder.block.13.layer.0.SelfAttention.v.weight', 'model.decoder.block.13.layer.0.SelfAttention.o.weight', 'model.decoder.block.13.layer.0.layer_norm.weight', 'model.decoder.block.13.layer.1.EncDecAttention.q.weight', 'model.decoder.block.13.layer.1.EncDecAttention.k.weight', 'model.decoder.block.13.layer.1.EncDecAttention.v.weight', 'model.decoder.block.13.layer.1.EncDecAttention.o.weight', 'model.decoder.block.13.layer.1.layer_norm.weight', 'model.decoder.block.13.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.13.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.13.layer.2.layer_norm.weight', 'model.decoder.block.14.layer.0.SelfAttention.q.weight', 'model.decoder.block.14.layer.0.SelfAttention.k.weight', 'model.decoder.block.14.layer.0.SelfAttention.v.weight', 'model.decoder.block.14.layer.0.SelfAttention.o.weight', 'model.decoder.block.14.layer.0.layer_norm.weight', 'model.decoder.block.14.layer.1.EncDecAttention.q.weight', 'model.decoder.block.14.layer.1.EncDecAttention.k.weight', 'model.decoder.block.14.layer.1.EncDecAttention.v.weight', 'model.decoder.block.14.layer.1.EncDecAttention.o.weight', 'model.decoder.block.14.layer.1.layer_norm.weight', 'model.decoder.block.14.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.14.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.14.layer.2.layer_norm.weight', 'model.decoder.block.15.layer.0.SelfAttention.q.weight', 'model.decoder.block.15.layer.0.SelfAttention.k.weight', 'model.decoder.block.15.layer.0.SelfAttention.v.weight', 'model.decoder.block.15.layer.0.SelfAttention.o.weight', 'model.decoder.block.15.layer.0.layer_norm.weight', 'model.decoder.block.15.layer.1.EncDecAttention.q.weight', 'model.decoder.block.15.layer.1.EncDecAttention.k.weight', 'model.decoder.block.15.layer.1.EncDecAttention.v.weight', 'model.decoder.block.15.layer.1.EncDecAttention.o.weight', 'model.decoder.block.15.layer.1.layer_norm.weight', 'model.decoder.block.15.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.15.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.15.layer.2.layer_norm.weight', 'model.decoder.block.16.layer.0.SelfAttention.q.weight', 'model.decoder.block.16.layer.0.SelfAttention.k.weight', 'model.decoder.block.16.layer.0.SelfAttention.v.weight', 'model.decoder.block.16.layer.0.SelfAttention.o.weight', 'model.decoder.block.16.layer.0.layer_norm.weight', 'model.decoder.block.16.layer.1.EncDecAttention.q.weight', 'model.decoder.block.16.layer.1.EncDecAttention.k.weight', 'model.decoder.block.16.layer.1.EncDecAttention.v.weight', 'model.decoder.block.16.layer.1.EncDecAttention.o.weight', 'model.decoder.block.16.layer.1.layer_norm.weight', 'model.decoder.block.16.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.16.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.16.layer.2.layer_norm.weight', 'model.decoder.block.17.layer.0.SelfAttention.q.weight', 'model.decoder.block.17.layer.0.SelfAttention.k.weight', 'model.decoder.block.17.layer.0.SelfAttention.v.weight', 'model.decoder.block.17.layer.0.SelfAttention.o.weight', 'model.decoder.block.17.layer.0.layer_norm.weight', 'model.decoder.block.17.layer.1.EncDecAttention.q.weight', 'model.decoder.block.17.layer.1.EncDecAttention.k.weight', 'model.decoder.block.17.layer.1.EncDecAttention.v.weight', 'model.decoder.block.17.layer.1.EncDecAttention.o.weight', 'model.decoder.block.17.layer.1.layer_norm.weight', 'model.decoder.block.17.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.17.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.17.layer.2.layer_norm.weight', 'model.decoder.block.18.layer.0.SelfAttention.q.weight', 'model.decoder.block.18.layer.0.SelfAttention.k.weight', 'model.decoder.block.18.layer.0.SelfAttention.v.weight', 'model.decoder.block.18.layer.0.SelfAttention.o.weight', 'model.decoder.block.18.layer.0.layer_norm.weight', 'model.decoder.block.18.layer.1.EncDecAttention.q.weight', 'model.decoder.block.18.layer.1.EncDecAttention.k.weight', 'model.decoder.block.18.layer.1.EncDecAttention.v.weight', 'model.decoder.block.18.layer.1.EncDecAttention.o.weight', 'model.decoder.block.18.layer.1.layer_norm.weight', 'model.decoder.block.18.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.18.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.18.layer.2.layer_norm.weight', 'model.decoder.block.19.layer.0.SelfAttention.q.weight', 'model.decoder.block.19.layer.0.SelfAttention.k.weight', 'model.decoder.block.19.layer.0.SelfAttention.v.weight', 'model.decoder.block.19.layer.0.SelfAttention.o.weight', 'model.decoder.block.19.layer.0.layer_norm.weight', 'model.decoder.block.19.layer.1.EncDecAttention.q.weight', 'model.decoder.block.19.layer.1.EncDecAttention.k.weight', 'model.decoder.block.19.layer.1.EncDecAttention.v.weight', 'model.decoder.block.19.layer.1.EncDecAttention.o.weight', 'model.decoder.block.19.layer.1.layer_norm.weight', 'model.decoder.block.19.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.19.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.19.layer.2.layer_norm.weight', 'model.decoder.block.20.layer.0.SelfAttention.q.weight', 'model.decoder.block.20.layer.0.SelfAttention.k.weight', 'model.decoder.block.20.layer.0.SelfAttention.v.weight', 'model.decoder.block.20.layer.0.SelfAttention.o.weight', 'model.decoder.block.20.layer.0.layer_norm.weight', 'model.decoder.block.20.layer.1.EncDecAttention.q.weight', 'model.decoder.block.20.layer.1.EncDecAttention.k.weight', 'model.decoder.block.20.layer.1.EncDecAttention.v.weight', 'model.decoder.block.20.layer.1.EncDecAttention.o.weight', 'model.decoder.block.20.layer.1.layer_norm.weight', 'model.decoder.block.20.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.20.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.20.layer.2.layer_norm.weight', 'model.decoder.block.21.layer.0.SelfAttention.q.weight', 'model.decoder.block.21.layer.0.SelfAttention.k.weight', 'model.decoder.block.21.layer.0.SelfAttention.v.weight', 'model.decoder.block.21.layer.0.SelfAttention.o.weight', 'model.decoder.block.21.layer.0.layer_norm.weight', 'model.decoder.block.21.layer.1.EncDecAttention.q.weight', 'model.decoder.block.21.layer.1.EncDecAttention.k.weight', 'model.decoder.block.21.layer.1.EncDecAttention.v.weight', 'model.decoder.block.21.layer.1.EncDecAttention.o.weight', 'model.decoder.block.21.layer.1.layer_norm.weight', 'model.decoder.block.21.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.21.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.21.layer.2.layer_norm.weight', 'model.decoder.block.22.layer.0.SelfAttention.q.weight', 'model.decoder.block.22.layer.0.SelfAttention.k.weight', 'model.decoder.block.22.layer.0.SelfAttention.v.weight', 'model.decoder.block.22.layer.0.SelfAttention.o.weight', 'model.decoder.block.22.layer.0.layer_norm.weight', 'model.decoder.block.22.layer.1.EncDecAttention.q.weight', 'model.decoder.block.22.layer.1.EncDecAttention.k.weight', 'model.decoder.block.22.layer.1.EncDecAttention.v.weight', 'model.decoder.block.22.layer.1.EncDecAttention.o.weight', 'model.decoder.block.22.layer.1.layer_norm.weight', 'model.decoder.block.22.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.22.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.22.layer.2.layer_norm.weight', 'model.decoder.block.23.layer.0.SelfAttention.q.weight', 'model.decoder.block.23.layer.0.SelfAttention.k.weight', 'model.decoder.block.23.layer.0.SelfAttention.v.weight', 'model.decoder.block.23.layer.0.SelfAttention.o.weight', 'model.decoder.block.23.layer.0.layer_norm.weight', 'model.decoder.block.23.layer.1.EncDecAttention.q.weight', 'model.decoder.block.23.layer.1.EncDecAttention.k.weight', 'model.decoder.block.23.layer.1.EncDecAttention.v.weight', 'model.decoder.block.23.layer.1.EncDecAttention.o.weight', 'model.decoder.block.23.layer.1.layer_norm.weight', 'model.decoder.block.23.layer.2.DenseReluDense.wi.weight', 'model.decoder.block.23.layer.2.DenseReluDense.wo.weight', 'model.decoder.block.23.layer.2.layer_norm.weight', 'model.decoder.final_layer_norm.weight', 'model.lm_head.weight'])
hparams.learning_rate = 0.002
split is 0
Length of dataset retrieving is.. 500000
Index(['id', 'date', 'input', 'output'], dtype='object')
----------Sampler init----------
mid epoch = False
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 10000
Index(['id', 'date', 'input', 'output'], dtype='object')
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]
Validation sanity check:  50%|█████     | 1/2 [00:02<00:02,  2.12s/it]
Validation sanity check: 100%|██████████| 2/2 [00:03<00:00,  1.63s/it]
split is 0
Length of dataset retrieving is.. 500000
Index(['id', 'date', 'input', 'output'], dtype='object')
Training: 0it [00:00, ?it/s]
Training:   0%|          | 0/17503 [00:00<?, ?it/s]
Epoch 0:   0%|          | 0/17503 [00:00<?, ?it/s] cuda memory allocated: 6589654016
----------Sampler iter----------
_____not mid epoch_____
Epoch 0:   0%|          | 1/17503 [00:01<7:03:30,  1.45s/it]
Epoch 0:   0%|          | 1/17503 [00:01<7:03:42,  1.45s/it, loss=1.18, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 2/17503 [00:01<4:13:44,  1.15it/s, loss=1.18, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 2/17503 [00:01<4:13:49,  1.15it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 3/17503 [00:02<3:17:06,  1.48it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 3/17503 [00:02<3:17:08,  1.48it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 4/17503 [00:02<2:48:46,  1.73it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 4/17503 [00:02<2:48:47,  1.73it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 5/17503 [00:02<2:31:45,  1.92it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 5/17503 [00:02<2:31:48,  1.92it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 6/17503 [00:02<2:20:29,  2.08it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 6/17503 [00:02<2:20:31,  2.08it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 7/17503 [00:03<2:12:23,  2.20it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 7/17503 [00:03<2:12:25,  2.20it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 8/17503 [00:03<2:06:18,  2.31it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 8/17503 [00:03<2:06:19,  2.31it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 9/17503 [00:03<2:01:34,  2.40it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 9/17503 [00:03<2:01:36,  2.40it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 10/17503 [00:04<1:57:48,  2.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 10/17503 [00:04<1:57:48,  2.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 11/17503 [00:04<1:54:41,  2.54it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 11/17503 [00:04<1:54:42,  2.54it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 12/17503 [00:04<1:52:08,  2.60it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 12/17503 [00:04<1:52:09,  2.60it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 13/17503 [00:04<1:49:57,  2.65it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 13/17503 [00:04<1:49:58,  2.65it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 14/17503 [00:05<1:48:05,  2.70it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 14/17503 [00:05<1:48:05,  2.70it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   0%|          | 15/17503 [00:05<1:46:27,  2.74it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 15/17503 [00:05<1:46:28,  2.74it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 16/17503 [00:05<1:45:02,  2.77it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 16/17503 [00:05<1:45:03,  2.77it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 17/17503 [00:06<1:43:47,  2.81it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 17/17503 [00:06<1:43:48,  2.81it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 18/17503 [00:06<1:42:40,  2.84it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 18/17503 [00:06<1:42:40,  2.84it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 19/17503 [00:06<1:41:39,  2.87it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 19/17503 [00:06<1:41:39,  2.87it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   0%|          | 20/17503 [00:06<1:40:45,  2.89it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 20/17503 [00:06<1:40:46,  2.89it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 21/17503 [00:07<1:39:56,  2.92it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 21/17503 [00:07<1:39:57,  2.92it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 22/17503 [00:07<1:39:12,  2.94it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 22/17503 [00:07<1:39:12,  2.94it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 23/17503 [00:07<1:38:32,  2.96it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 23/17503 [00:07<1:38:33,  2.96it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 24/17503 [00:08<1:37:55,  2.97it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 24/17503 [00:08<1:37:56,  2.97it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 25/17503 [00:08<1:37:21,  2.99it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 25/17503 [00:08<1:37:22,  2.99it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 26/17503 [00:08<1:36:50,  3.01it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 26/17503 [00:08<1:36:50,  3.01it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 27/17503 [00:08<1:36:21,  3.02it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 27/17503 [00:08<1:36:21,  3.02it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 28/17503 [00:09<1:35:54,  3.04it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 28/17503 [00:09<1:35:54,  3.04it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 29/17503 [00:09<1:35:28,  3.05it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 29/17503 [00:09<1:35:28,  3.05it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 30/17503 [00:09<1:35:04,  3.06it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 30/17503 [00:09<1:35:04,  3.06it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 31/17503 [00:10<1:34:42,  3.07it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 31/17503 [00:10<1:34:43,  3.07it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 32/17503 [00:10<1:34:21,  3.09it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 32/17503 [00:10<1:34:21,  3.09it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 33/17503 [00:10<1:34:01,  3.10it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 33/17503 [00:10<1:34:02,  3.10it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 34/17503 [00:10<1:33:44,  3.11it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 34/17503 [00:10<1:33:44,  3.11it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   0%|          | 35/17503 [00:11<1:33:26,  3.12it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 35/17503 [00:11<1:33:27,  3.12it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 36/17503 [00:11<1:33:10,  3.12it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 36/17503 [00:11<1:33:10,  3.12it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 37/17503 [00:11<1:32:54,  3.13it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 37/17503 [00:11<1:32:54,  3.13it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 38/17503 [00:12<1:32:39,  3.14it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 38/17503 [00:12<1:32:40,  3.14it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 39/17503 [00:12<1:32:25,  3.15it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 39/17503 [00:12<1:32:26,  3.15it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 40/17503 [00:12<1:32:12,  3.16it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 40/17503 [00:12<1:32:12,  3.16it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 41/17503 [00:12<1:32:00,  3.16it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 41/17503 [00:12<1:32:00,  3.16it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 42/17503 [00:13<1:31:48,  3.17it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 42/17503 [00:13<1:31:48,  3.17it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 43/17503 [00:13<1:31:36,  3.18it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 43/17503 [00:13<1:31:36,  3.18it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 44/17503 [00:13<1:31:25,  3.18it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 44/17503 [00:13<1:31:25,  3.18it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 45/17503 [00:14<1:31:15,  3.19it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 45/17503 [00:14<1:31:15,  3.19it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 46/17503 [00:14<1:31:04,  3.19it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 46/17503 [00:14<1:31:05,  3.19it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 47/17503 [00:14<1:30:55,  3.20it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 47/17503 [00:14<1:30:55,  3.20it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 48/17503 [00:14<1:30:46,  3.21it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 48/17503 [00:14<1:30:46,  3.20it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 49/17503 [00:15<1:30:37,  3.21it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 49/17503 [00:15<1:30:37,  3.21it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 50/17503 [00:15<1:30:29,  3.21it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 50/17503 [00:15<1:30:29,  3.21it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 51/17503 [00:15<1:30:20,  3.22it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 51/17503 [00:15<1:30:21,  3.22it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 52/17503 [00:16<1:30:12,  3.22it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 52/17503 [00:16<1:30:12,  3.22it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 53/17503 [00:16<1:30:05,  3.23it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 53/17503 [00:16<1:30:05,  3.23it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 54/17503 [00:16<1:29:57,  3.23it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 54/17503 [00:16<1:29:57,  3.23it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 55/17503 [00:16<1:29:50,  3.24it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 55/17503 [00:16<1:29:50,  3.24it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 56/17503 [00:17<1:29:44,  3.24it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 56/17503 [00:17<1:29:44,  3.24it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 57/17503 [00:17<1:29:37,  3.24it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 57/17503 [00:17<1:29:37,  3.24it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 58/17503 [00:17<1:29:30,  3.25it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 58/17503 [00:17<1:29:30,  3.25it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 59/17503 [00:18<1:29:24,  3.25it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 59/17503 [00:18<1:29:24,  3.25it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 60/17503 [00:18<1:29:18,  3.26it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 60/17503 [00:18<1:29:18,  3.26it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   0%|          | 61/17503 [00:18<1:29:12,  3.26it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 61/17503 [00:18<1:29:12,  3.26it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 62/17503 [00:19<1:29:06,  3.26it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 62/17503 [00:19<1:29:07,  3.26it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 63/17503 [00:19<1:29:01,  3.27it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 63/17503 [00:19<1:29:01,  3.27it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 64/17503 [00:19<1:28:55,  3.27it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 64/17503 [00:19<1:28:56,  3.27it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 65/17503 [00:19<1:28:50,  3.27it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 65/17503 [00:19<1:28:50,  3.27it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 66/17503 [00:20<1:28:45,  3.27it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 66/17503 [00:20<1:28:45,  3.27it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 67/17503 [00:20<1:28:40,  3.28it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 67/17503 [00:20<1:28:41,  3.28it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 68/17503 [00:20<1:28:36,  3.28it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 68/17503 [00:20<1:28:36,  3.28it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 69/17503 [00:21<1:28:31,  3.28it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 69/17503 [00:21<1:28:31,  3.28it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 70/17503 [00:21<1:28:26,  3.28it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 70/17503 [00:21<1:28:27,  3.28it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 71/17503 [00:21<1:28:22,  3.29it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 71/17503 [00:21<1:28:22,  3.29it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 72/17503 [00:21<1:28:18,  3.29it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 72/17503 [00:21<1:28:18,  3.29it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 73/17503 [00:22<1:28:14,  3.29it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 73/17503 [00:22<1:28:14,  3.29it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 74/17503 [00:22<1:28:09,  3.29it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 74/17503 [00:22<1:28:09,  3.29it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 75/17503 [00:22<1:28:05,  3.30it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 75/17503 [00:22<1:28:06,  3.30it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 76/17503 [00:23<1:28:02,  3.30it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 76/17503 [00:23<1:28:02,  3.30it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 77/17503 [00:23<1:27:58,  3.30it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 77/17503 [00:23<1:27:58,  3.30it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 78/17503 [00:23<1:27:54,  3.30it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 78/17503 [00:23<1:27:54,  3.30it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 79/17503 [00:23<1:27:50,  3.31it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 79/17503 [00:23<1:27:50,  3.31it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 80/17503 [00:24<1:27:47,  3.31it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 80/17503 [00:24<1:27:47,  3.31it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 81/17503 [00:24<1:27:43,  3.31it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 81/17503 [00:24<1:27:43,  3.31it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 82/17503 [00:24<1:27:40,  3.31it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 82/17503 [00:24<1:27:40,  3.31it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   0%|          | 83/17503 [00:25<1:27:37,  3.31it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 83/17503 [00:25<1:27:37,  3.31it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 84/17503 [00:25<1:27:33,  3.32it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 84/17503 [00:25<1:27:34,  3.32it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 85/17503 [00:25<1:27:30,  3.32it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 85/17503 [00:25<1:27:30,  3.32it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 86/17503 [00:25<1:27:27,  3.32it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 86/17503 [00:25<1:27:27,  3.32it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 87/17503 [00:26<1:27:24,  3.32it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   0%|          | 87/17503 [00:26<1:27:24,  3.32it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 88/17503 [00:26<1:27:21,  3.32it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 88/17503 [00:26<1:27:21,  3.32it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 89/17503 [00:26<1:27:18,  3.32it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 89/17503 [00:26<1:27:18,  3.32it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 90/17503 [00:27<1:27:15,  3.33it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 90/17503 [00:27<1:27:15,  3.33it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 91/17503 [00:27<1:27:12,  3.33it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 91/17503 [00:27<1:27:12,  3.33it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 92/17503 [00:27<1:27:09,  3.33it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 92/17503 [00:27<1:27:09,  3.33it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 93/17503 [00:27<1:27:07,  3.33it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 93/17503 [00:27<1:27:07,  3.33it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 94/17503 [00:28<1:27:04,  3.33it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 94/17503 [00:28<1:27:04,  3.33it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 95/17503 [00:28<1:27:02,  3.33it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 95/17503 [00:28<1:27:02,  3.33it/s, loss=1.43, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 96/17503 [00:28<1:26:59,  3.33it/s, loss=1.43, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 96/17503 [00:28<1:26:59,  3.33it/s, loss=1.43, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 97/17503 [00:29<1:26:57,  3.34it/s, loss=1.43, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 97/17503 [00:29<1:26:57,  3.34it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 98/17503 [00:29<1:26:54,  3.34it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 98/17503 [00:29<1:26:54,  3.34it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 99/17503 [00:29<1:26:52,  3.34it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 99/17503 [00:29<1:26:52,  3.34it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 100/17503 [00:29<1:26:49,  3.34it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 100/17503 [00:29<1:26:50,  3.34it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 101/17503 [00:30<1:26:47,  3.34it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 101/17503 [00:30<1:26:47,  3.34it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 102/17503 [00:30<1:26:45,  3.34it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 102/17503 [00:30<1:26:45,  3.34it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 103/17503 [00:30<1:26:42,  3.34it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 103/17503 [00:30<1:26:43,  3.34it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 104/17503 [00:31<1:26:40,  3.35it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 104/17503 [00:31<1:26:41,  3.35it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 105/17503 [00:31<1:26:38,  3.35it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 105/17503 [00:31<1:26:39,  3.35it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 106/17503 [00:31<1:26:36,  3.35it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 106/17503 [00:31<1:26:36,  3.35it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 107/17503 [00:31<1:26:34,  3.35it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 107/17503 [00:31<1:26:34,  3.35it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 108/17503 [00:32<1:26:32,  3.35it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 108/17503 [00:32<1:26:32,  3.35it/s, loss=1.43, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 109/17503 [00:32<1:26:30,  3.35it/s, loss=1.43, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 109/17503 [00:32<1:26:30,  3.35it/s, loss=1.45, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 110/17503 [00:32<1:26:28,  3.35it/s, loss=1.45, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 110/17503 [00:32<1:26:28,  3.35it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 111/17503 [00:33<1:26:26,  3.35it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 111/17503 [00:33<1:26:26,  3.35it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 112/17503 [00:33<1:26:24,  3.35it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 112/17503 [00:33<1:26:24,  3.35it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 113/17503 [00:33<1:26:22,  3.36it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 113/17503 [00:33<1:26:22,  3.36it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 114/17503 [00:33<1:26:20,  3.36it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 114/17503 [00:33<1:26:20,  3.36it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 115/17503 [00:34<1:26:18,  3.36it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 115/17503 [00:34<1:26:18,  3.36it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 116/17503 [00:34<1:26:15,  3.36it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 116/17503 [00:34<1:26:15,  3.36it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 117/17503 [00:34<1:26:13,  3.36it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 117/17503 [00:34<1:26:13,  3.36it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 118/17503 [00:35<1:26:11,  3.36it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 118/17503 [00:35<1:26:11,  3.36it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 119/17503 [00:35<1:26:08,  3.36it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 119/17503 [00:35<1:26:09,  3.36it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 120/17503 [00:35<1:26:06,  3.36it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 120/17503 [00:35<1:26:06,  3.36it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 121/17503 [00:35<1:26:04,  3.37it/s, loss=1.42, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 121/17503 [00:35<1:26:04,  3.37it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 122/17503 [00:36<1:26:02,  3.37it/s, loss=1.41, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 122/17503 [00:36<1:26:02,  3.37it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 123/17503 [00:36<1:26:00,  3.37it/s, loss=1.4, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 123/17503 [00:36<1:26:00,  3.37it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 124/17503 [00:36<1:25:58,  3.37it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 124/17503 [00:36<1:25:58,  3.37it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 125/17503 [00:37<1:25:55,  3.37it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 125/17503 [00:37<1:25:56,  3.37it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 126/17503 [00:37<1:25:53,  3.37it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 126/17503 [00:37<1:25:53,  3.37it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 127/17503 [00:37<1:25:51,  3.37it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 127/17503 [00:37<1:25:51,  3.37it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 128/17503 [00:37<1:25:49,  3.37it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 128/17503 [00:37<1:25:49,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 129/17503 [00:38<1:25:47,  3.38it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 129/17503 [00:38<1:25:47,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 130/17503 [00:38<1:25:46,  3.38it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 130/17503 [00:38<1:25:46,  3.38it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 131/17503 [00:38<1:25:44,  3.38it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 131/17503 [00:38<1:25:44,  3.38it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 132/17503 [00:39<1:25:42,  3.38it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 132/17503 [00:39<1:25:42,  3.38it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 133/17503 [00:39<1:25:40,  3.38it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 133/17503 [00:39<1:25:40,  3.38it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 134/17503 [00:39<1:25:38,  3.38it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 134/17503 [00:39<1:25:38,  3.38it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 135/17503 [00:39<1:25:36,  3.38it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 135/17503 [00:39<1:25:36,  3.38it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 136/17503 [00:40<1:25:34,  3.38it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 136/17503 [00:40<1:25:35,  3.38it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 137/17503 [00:40<1:25:33,  3.38it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 137/17503 [00:40<1:25:33,  3.38it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 138/17503 [00:40<1:25:31,  3.38it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 138/17503 [00:40<1:25:31,  3.38it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 139/17503 [00:41<1:25:29,  3.39it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 139/17503 [00:41<1:25:29,  3.38it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 140/17503 [00:41<1:25:27,  3.39it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 140/17503 [00:41<1:25:27,  3.39it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 141/17503 [00:41<1:25:26,  3.39it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 141/17503 [00:41<1:25:26,  3.39it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 142/17503 [00:41<1:25:24,  3.39it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 142/17503 [00:41<1:25:24,  3.39it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 143/17503 [00:42<1:25:22,  3.39it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 143/17503 [00:42<1:25:22,  3.39it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 144/17503 [00:42<1:25:21,  3.39it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 144/17503 [00:42<1:25:21,  3.39it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 145/17503 [00:42<1:25:19,  3.39it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 145/17503 [00:42<1:25:19,  3.39it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 146/17503 [00:43<1:25:18,  3.39it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 146/17503 [00:43<1:25:18,  3.39it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 147/17503 [00:43<1:25:16,  3.39it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 147/17503 [00:43<1:25:16,  3.39it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 148/17503 [00:43<1:25:14,  3.39it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 148/17503 [00:43<1:25:14,  3.39it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 149/17503 [00:43<1:25:13,  3.39it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 149/17503 [00:43<1:25:13,  3.39it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 150/17503 [00:44<1:25:12,  3.39it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 150/17503 [00:44<1:25:12,  3.39it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 151/17503 [00:44<1:25:10,  3.40it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 151/17503 [00:44<1:25:10,  3.40it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 152/17503 [00:44<1:25:08,  3.40it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 152/17503 [00:44<1:25:09,  3.40it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 153/17503 [00:45<1:25:07,  3.40it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 153/17503 [00:45<1:25:07,  3.40it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 154/17503 [00:45<1:25:06,  3.40it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 154/17503 [00:45<1:25:06,  3.40it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 155/17503 [00:45<1:25:04,  3.40it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 155/17503 [00:45<1:25:04,  3.40it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 156/17503 [00:45<1:25:03,  3.40it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 156/17503 [00:45<1:25:03,  3.40it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 157/17503 [00:46<1:25:02,  3.40it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 157/17503 [00:46<1:25:02,  3.40it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 158/17503 [00:46<1:25:00,  3.40it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 158/17503 [00:46<1:25:00,  3.40it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 159/17503 [00:46<1:24:59,  3.40it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 159/17503 [00:46<1:24:59,  3.40it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 160/17503 [00:47<1:24:57,  3.40it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 160/17503 [00:47<1:24:58,  3.40it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 161/17503 [00:47<1:24:56,  3.40it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 161/17503 [00:47<1:24:56,  3.40it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 162/17503 [00:47<1:24:55,  3.40it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 162/17503 [00:47<1:24:55,  3.40it/s, loss=1.21, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 163/17503 [00:47<1:24:53,  3.40it/s, loss=1.21, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 163/17503 [00:47<1:24:53,  3.40it/s, loss=1.21, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 164/17503 [00:48<1:24:52,  3.40it/s, loss=1.21, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 164/17503 [00:48<1:24:52,  3.40it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 165/17503 [00:48<1:24:51,  3.41it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 165/17503 [00:48<1:24:51,  3.41it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 166/17503 [00:48<1:24:49,  3.41it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 166/17503 [00:48<1:24:49,  3.41it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 167/17503 [00:49<1:24:48,  3.41it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 167/17503 [00:49<1:24:48,  3.41it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 168/17503 [00:49<1:24:47,  3.41it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 168/17503 [00:49<1:24:47,  3.41it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 169/17503 [00:49<1:24:46,  3.41it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 169/17503 [00:49<1:24:46,  3.41it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 170/17503 [00:49<1:24:44,  3.41it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 170/17503 [00:49<1:24:44,  3.41it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 171/17503 [00:50<1:24:43,  3.41it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 171/17503 [00:50<1:24:43,  3.41it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 172/17503 [00:50<1:24:42,  3.41it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 172/17503 [00:50<1:24:42,  3.41it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 173/17503 [00:50<1:24:41,  3.41it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 173/17503 [00:50<1:24:41,  3.41it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 174/17503 [00:51<1:24:39,  3.41it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 174/17503 [00:51<1:24:39,  3.41it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 175/17503 [00:51<1:24:38,  3.41it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 175/17503 [00:51<1:24:38,  3.41it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 176/17503 [00:51<1:24:37,  3.41it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 176/17503 [00:51<1:24:37,  3.41it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 177/17503 [00:51<1:24:36,  3.41it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 177/17503 [00:51<1:24:36,  3.41it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 178/17503 [00:52<1:24:35,  3.41it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 178/17503 [00:52<1:24:35,  3.41it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 179/17503 [00:52<1:24:34,  3.41it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 179/17503 [00:52<1:24:34,  3.41it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 180/17503 [00:52<1:24:33,  3.41it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 180/17503 [00:52<1:24:33,  3.41it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 181/17503 [00:53<1:24:32,  3.42it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 181/17503 [00:53<1:24:32,  3.41it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 182/17503 [00:53<1:24:31,  3.42it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 182/17503 [00:53<1:24:31,  3.42it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 183/17503 [00:53<1:24:30,  3.42it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 183/17503 [00:53<1:24:30,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 184/17503 [00:53<1:24:29,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 184/17503 [00:53<1:24:29,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 185/17503 [00:54<1:24:28,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 185/17503 [00:54<1:24:28,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 186/17503 [00:54<1:24:27,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 186/17503 [00:54<1:24:27,  3.42it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 187/17503 [00:54<1:24:26,  3.42it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 187/17503 [00:54<1:24:26,  3.42it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 188/17503 [00:54<1:24:25,  3.42it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 188/17503 [00:54<1:24:25,  3.42it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 189/17503 [00:55<1:24:23,  3.42it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 189/17503 [00:55<1:24:24,  3.42it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 190/17503 [00:55<1:24:23,  3.42it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 190/17503 [00:55<1:24:23,  3.42it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 191/17503 [00:55<1:24:21,  3.42it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 191/17503 [00:55<1:24:22,  3.42it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 192/17503 [00:56<1:24:20,  3.42it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 192/17503 [00:56<1:24:20,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 193/17503 [00:56<1:24:20,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 193/17503 [00:56<1:24:20,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 194/17503 [00:56<1:24:19,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 194/17503 [00:56<1:24:19,  3.42it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 195/17503 [00:56<1:24:18,  3.42it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 195/17503 [00:56<1:24:18,  3.42it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 196/17503 [00:57<1:24:17,  3.42it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 196/17503 [00:57<1:24:17,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 197/17503 [00:57<1:24:16,  3.42it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 197/17503 [00:57<1:24:16,  3.42it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 198/17503 [00:57<1:24:15,  3.42it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 198/17503 [00:57<1:24:15,  3.42it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 199/17503 [00:58<1:24:14,  3.42it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 199/17503 [00:58<1:24:14,  3.42it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 200/17503 [00:58<1:24:13,  3.42it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 200/17503 [00:58<1:24:13,  3.42it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 201/17503 [00:58<1:24:12,  3.42it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 201/17503 [00:58<1:24:12,  3.42it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 202/17503 [00:58<1:24:11,  3.42it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 202/17503 [00:58<1:24:11,  3.42it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 203/17503 [00:59<1:24:10,  3.43it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 203/17503 [00:59<1:24:10,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 204/17503 [00:59<1:24:09,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 204/17503 [00:59<1:24:10,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 205/17503 [00:59<1:24:09,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 205/17503 [00:59<1:24:09,  3.43it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 206/17503 [01:00<1:24:08,  3.43it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 206/17503 [01:00<1:24:08,  3.43it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 207/17503 [01:00<1:24:07,  3.43it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 207/17503 [01:00<1:24:07,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 208/17503 [01:00<1:24:06,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 208/17503 [01:00<1:24:06,  3.43it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 209/17503 [01:00<1:24:05,  3.43it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 209/17503 [01:00<1:24:05,  3.43it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|          | 210/17503 [01:01<1:24:04,  3.43it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 210/17503 [01:01<1:24:04,  3.43it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 211/17503 [01:01<1:24:03,  3.43it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 211/17503 [01:01<1:24:03,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 212/17503 [01:01<1:24:03,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 212/17503 [01:01<1:24:03,  3.43it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 213/17503 [01:02<1:24:02,  3.43it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 213/17503 [01:02<1:24:02,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 214/17503 [01:02<1:24:01,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 214/17503 [01:02<1:24:01,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 215/17503 [01:02<1:24:00,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 215/17503 [01:02<1:24:00,  3.43it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 216/17503 [01:02<1:23:59,  3.43it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 216/17503 [01:02<1:23:59,  3.43it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 217/17503 [01:03<1:23:58,  3.43it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 217/17503 [01:03<1:23:59,  3.43it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 218/17503 [01:03<1:23:58,  3.43it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|          | 218/17503 [01:03<1:23:58,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 219/17503 [01:03<1:23:57,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 219/17503 [01:03<1:23:57,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 220/17503 [01:04<1:23:56,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 220/17503 [01:04<1:23:56,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 221/17503 [01:04<1:23:55,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 221/17503 [01:04<1:23:55,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 222/17503 [01:04<1:23:54,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 222/17503 [01:04<1:23:54,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 223/17503 [01:04<1:23:54,  3.43it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 223/17503 [01:04<1:23:54,  3.43it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 224/17503 [01:05<1:23:53,  3.43it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 224/17503 [01:05<1:23:53,  3.43it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 225/17503 [01:05<1:23:52,  3.43it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 225/17503 [01:05<1:23:52,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 226/17503 [01:05<1:23:51,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 226/17503 [01:05<1:23:51,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 227/17503 [01:06<1:23:50,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 227/17503 [01:06<1:23:51,  3.43it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|▏         | 228/17503 [01:06<1:23:50,  3.43it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 228/17503 [01:06<1:23:50,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 229/17503 [01:06<1:23:49,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 229/17503 [01:06<1:23:49,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 230/17503 [01:06<1:23:48,  3.43it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 230/17503 [01:06<1:23:48,  3.43it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|▏         | 231/17503 [01:07<1:23:47,  3.44it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 231/17503 [01:07<1:23:47,  3.44it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 232/17503 [01:07<1:23:46,  3.44it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 232/17503 [01:07<1:23:47,  3.44it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|▏         | 233/17503 [01:07<1:23:46,  3.44it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 233/17503 [01:07<1:23:46,  3.44it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 234/17503 [01:08<1:23:45,  3.44it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 234/17503 [01:08<1:23:45,  3.44it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 235/17503 [01:08<1:23:44,  3.44it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 235/17503 [01:08<1:23:44,  3.44it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   1%|▏         | 236/17503 [01:08<1:23:43,  3.44it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 236/17503 [01:08<1:23:43,  3.44it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 237/17503 [01:08<1:23:43,  3.44it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 237/17503 [01:08<1:23:43,  3.44it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 238/17503 [01:09<1:23:42,  3.44it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 238/17503 [01:09<1:23:42,  3.44it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 239/17503 [01:09<1:23:41,  3.44it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 239/17503 [01:09<1:23:41,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 240/17503 [01:09<1:23:40,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 240/17503 [01:09<1:23:40,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 241/17503 [01:10<1:23:39,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 241/17503 [01:10<1:23:40,  3.44it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 242/17503 [01:10<1:23:39,  3.44it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 242/17503 [01:10<1:23:39,  3.44it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 243/17503 [01:10<1:23:38,  3.44it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 243/17503 [01:10<1:23:38,  3.44it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 244/17503 [01:10<1:23:37,  3.44it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 244/17503 [01:10<1:23:37,  3.44it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 245/17503 [01:11<1:23:36,  3.44it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 245/17503 [01:11<1:23:37,  3.44it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 246/17503 [01:11<1:23:36,  3.44it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 246/17503 [01:11<1:23:36,  3.44it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 247/17503 [01:11<1:23:35,  3.44it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 247/17503 [01:11<1:23:35,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 248/17503 [01:12<1:23:34,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 248/17503 [01:12<1:23:34,  3.44it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 249/17503 [01:12<1:23:33,  3.44it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 249/17503 [01:12<1:23:33,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 250/17503 [01:12<1:23:33,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 250/17503 [01:12<1:23:33,  3.44it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 251/17503 [01:12<1:23:32,  3.44it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 251/17503 [01:12<1:23:32,  3.44it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 252/17503 [01:13<1:23:32,  3.44it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 252/17503 [01:13<1:23:32,  3.44it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 253/17503 [01:13<1:23:31,  3.44it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 253/17503 [01:13<1:23:31,  3.44it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 254/17503 [01:13<1:23:30,  3.44it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 254/17503 [01:13<1:23:30,  3.44it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 255/17503 [01:14<1:23:30,  3.44it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 255/17503 [01:14<1:23:30,  3.44it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 256/17503 [01:14<1:23:29,  3.44it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 256/17503 [01:14<1:23:29,  3.44it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 257/17503 [01:14<1:23:28,  3.44it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 257/17503 [01:14<1:23:28,  3.44it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 258/17503 [01:14<1:23:27,  3.44it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 258/17503 [01:14<1:23:27,  3.44it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 259/17503 [01:15<1:23:27,  3.44it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 259/17503 [01:15<1:23:27,  3.44it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 260/17503 [01:15<1:23:26,  3.44it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 260/17503 [01:15<1:23:26,  3.44it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 261/17503 [01:15<1:23:25,  3.44it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 261/17503 [01:15<1:23:25,  3.44it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 262/17503 [01:16<1:23:25,  3.44it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   1%|▏         | 262/17503 [01:16<1:23:25,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 263/17503 [01:16<1:23:24,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 263/17503 [01:16<1:23:24,  3.44it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 264/17503 [01:16<1:23:23,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 264/17503 [01:16<1:23:23,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 265/17503 [01:16<1:23:23,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 265/17503 [01:16<1:23:23,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 266/17503 [01:17<1:23:22,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 266/17503 [01:17<1:23:22,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 267/17503 [01:17<1:23:21,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 267/17503 [01:17<1:23:21,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 268/17503 [01:17<1:23:21,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 268/17503 [01:17<1:23:21,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 269/17503 [01:18<1:23:20,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 269/17503 [01:18<1:23:20,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 270/17503 [01:18<1:23:19,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 270/17503 [01:18<1:23:19,  3.45it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 271/17503 [01:18<1:23:19,  3.45it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 271/17503 [01:18<1:23:19,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 272/17503 [01:18<1:23:18,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 272/17503 [01:18<1:23:18,  3.45it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 273/17503 [01:19<1:23:17,  3.45it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 273/17503 [01:19<1:23:17,  3.45it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 274/17503 [01:19<1:23:17,  3.45it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 274/17503 [01:19<1:23:17,  3.45it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 275/17503 [01:19<1:23:16,  3.45it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 275/17503 [01:19<1:23:16,  3.45it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 276/17503 [01:20<1:23:16,  3.45it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 276/17503 [01:20<1:23:16,  3.45it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 277/17503 [01:20<1:23:15,  3.45it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 277/17503 [01:20<1:23:15,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 278/17503 [01:20<1:23:14,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 278/17503 [01:20<1:23:14,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 279/17503 [01:20<1:23:14,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 279/17503 [01:20<1:23:14,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 280/17503 [01:21<1:23:13,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 280/17503 [01:21<1:23:13,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 281/17503 [01:21<1:23:13,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 281/17503 [01:21<1:23:13,  3.45it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 282/17503 [01:21<1:23:12,  3.45it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 282/17503 [01:21<1:23:12,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 283/17503 [01:22<1:23:11,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 283/17503 [01:22<1:23:12,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 284/17503 [01:22<1:23:16,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 284/17503 [01:22<1:23:16,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 285/17503 [01:22<1:23:15,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 285/17503 [01:22<1:23:15,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 286/17503 [01:22<1:23:15,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 286/17503 [01:22<1:23:15,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 287/17503 [01:23<1:23:14,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 287/17503 [01:23<1:23:14,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 288/17503 [01:23<1:23:14,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 288/17503 [01:23<1:23:14,  3.45it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 289/17503 [01:23<1:23:13,  3.45it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 289/17503 [01:23<1:23:13,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 290/17503 [01:24<1:23:12,  3.45it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 290/17503 [01:24<1:23:12,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 291/17503 [01:24<1:23:12,  3.45it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 291/17503 [01:24<1:23:12,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 292/17503 [01:24<1:23:11,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 292/17503 [01:24<1:23:11,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 293/17503 [01:24<1:23:11,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 293/17503 [01:24<1:23:11,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 294/17503 [01:25<1:23:10,  3.45it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 294/17503 [01:25<1:23:10,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 295/17503 [01:25<1:23:09,  3.45it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 295/17503 [01:25<1:23:09,  3.45it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 296/17503 [01:25<1:23:09,  3.45it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 296/17503 [01:25<1:23:09,  3.45it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 297/17503 [01:26<1:23:08,  3.45it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 297/17503 [01:26<1:23:08,  3.45it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 298/17503 [01:26<1:23:08,  3.45it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 298/17503 [01:26<1:23:08,  3.45it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 299/17503 [01:26<1:23:07,  3.45it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 299/17503 [01:26<1:23:07,  3.45it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 300/17503 [01:26<1:23:06,  3.45it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 300/17503 [01:26<1:23:06,  3.45it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 301/17503 [01:27<1:23:06,  3.45it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 301/17503 [01:27<1:23:06,  3.45it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 302/17503 [01:27<1:23:05,  3.45it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 302/17503 [01:27<1:23:05,  3.45it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 303/17503 [01:27<1:23:05,  3.45it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 303/17503 [01:27<1:23:05,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 304/17503 [01:28<1:23:04,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 304/17503 [01:28<1:23:04,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 305/17503 [01:28<1:23:03,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 305/17503 [01:28<1:23:04,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 306/17503 [01:28<1:23:03,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 306/17503 [01:28<1:23:03,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 307/17503 [01:28<1:23:02,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 307/17503 [01:28<1:23:02,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 308/17503 [01:29<1:23:02,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 308/17503 [01:29<1:23:02,  3.45it/s, loss=1.2, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 309/17503 [01:29<1:23:01,  3.45it/s, loss=1.2, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 309/17503 [01:29<1:23:01,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 310/17503 [01:29<1:23:01,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 310/17503 [01:29<1:23:01,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 311/17503 [01:30<1:23:00,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 311/17503 [01:30<1:23:00,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 312/17503 [01:30<1:22:59,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 312/17503 [01:30<1:23:00,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 313/17503 [01:30<1:22:59,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 313/17503 [01:30<1:22:59,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 314/17503 [01:30<1:22:58,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 314/17503 [01:30<1:22:58,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 315/17503 [01:31<1:22:58,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 315/17503 [01:31<1:22:58,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 316/17503 [01:31<1:22:57,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 316/17503 [01:31<1:22:57,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 317/17503 [01:31<1:22:57,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 317/17503 [01:31<1:22:57,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 318/17503 [01:32<1:22:56,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 318/17503 [01:32<1:22:56,  3.45it/s, loss=1.21, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 319/17503 [01:32<1:22:56,  3.45it/s, loss=1.21, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 319/17503 [01:32<1:22:56,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 320/17503 [01:32<1:22:55,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 320/17503 [01:32<1:22:55,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 321/17503 [01:32<1:22:55,  3.45it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 321/17503 [01:32<1:22:55,  3.45it/s, loss=1.2, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 322/17503 [01:33<1:22:54,  3.45it/s, loss=1.2, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 322/17503 [01:33<1:22:54,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 323/17503 [01:33<1:22:54,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 323/17503 [01:33<1:22:54,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 324/17503 [01:33<1:22:53,  3.45it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 324/17503 [01:33<1:22:53,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 325/17503 [01:34<1:22:53,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 325/17503 [01:34<1:22:53,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 326/17503 [01:34<1:22:52,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 326/17503 [01:34<1:22:52,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 327/17503 [01:34<1:22:51,  3.45it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 327/17503 [01:34<1:22:51,  3.45it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 328/17503 [01:34<1:22:51,  3.45it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 328/17503 [01:34<1:22:51,  3.45it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 329/17503 [01:35<1:22:50,  3.45it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 329/17503 [01:35<1:22:51,  3.45it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 330/17503 [01:35<1:22:50,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 330/17503 [01:35<1:22:50,  3.45it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 331/17503 [01:35<1:22:49,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 331/17503 [01:35<1:22:49,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 332/17503 [01:36<1:22:49,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 332/17503 [01:36<1:22:49,  3.46it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 333/17503 [01:36<1:22:48,  3.46it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 333/17503 [01:36<1:22:48,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 334/17503 [01:36<1:22:48,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 334/17503 [01:36<1:22:48,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 335/17503 [01:36<1:22:47,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 335/17503 [01:36<1:22:47,  3.46it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 336/17503 [01:37<1:22:47,  3.46it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 336/17503 [01:37<1:22:47,  3.46it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 337/17503 [01:37<1:22:46,  3.46it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 337/17503 [01:37<1:22:46,  3.46it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 338/17503 [01:37<1:22:46,  3.46it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 338/17503 [01:37<1:22:46,  3.46it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 339/17503 [01:38<1:22:45,  3.46it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 339/17503 [01:38<1:22:45,  3.46it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 340/17503 [01:38<1:22:45,  3.46it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 340/17503 [01:38<1:22:45,  3.46it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 341/17503 [01:38<1:22:44,  3.46it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 341/17503 [01:38<1:22:44,  3.46it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 342/17503 [01:38<1:22:44,  3.46it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 342/17503 [01:38<1:22:44,  3.46it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 343/17503 [01:39<1:22:43,  3.46it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 343/17503 [01:39<1:22:43,  3.46it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 344/17503 [01:39<1:22:43,  3.46it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 344/17503 [01:39<1:22:43,  3.46it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 345/17503 [01:39<1:22:42,  3.46it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 345/17503 [01:39<1:22:42,  3.46it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 346/17503 [01:40<1:22:42,  3.46it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 346/17503 [01:40<1:22:42,  3.46it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 347/17503 [01:40<1:22:41,  3.46it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 347/17503 [01:40<1:22:41,  3.46it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 348/17503 [01:40<1:22:41,  3.46it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 348/17503 [01:40<1:22:41,  3.46it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 349/17503 [01:40<1:22:40,  3.46it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 349/17503 [01:40<1:22:40,  3.46it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 350/17503 [01:41<1:22:40,  3.46it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 350/17503 [01:41<1:22:40,  3.46it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 351/17503 [01:41<1:22:39,  3.46it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 351/17503 [01:41<1:22:39,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 352/17503 [01:41<1:22:39,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 352/17503 [01:41<1:22:39,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 353/17503 [01:42<1:22:38,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 353/17503 [01:42<1:22:38,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 354/17503 [01:42<1:22:38,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 354/17503 [01:42<1:22:38,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 355/17503 [01:42<1:22:37,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 355/17503 [01:42<1:22:37,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 356/17503 [01:42<1:22:37,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 356/17503 [01:42<1:22:37,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 357/17503 [01:43<1:22:36,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 357/17503 [01:43<1:22:36,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 358/17503 [01:43<1:22:36,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 358/17503 [01:43<1:22:36,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 359/17503 [01:43<1:22:35,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 359/17503 [01:43<1:22:36,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 360/17503 [01:44<1:22:35,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 360/17503 [01:44<1:22:35,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 361/17503 [01:44<1:22:35,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 361/17503 [01:44<1:22:35,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 362/17503 [01:44<1:22:34,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 362/17503 [01:44<1:22:34,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 363/17503 [01:44<1:22:33,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 363/17503 [01:44<1:22:34,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 364/17503 [01:45<1:22:33,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 364/17503 [01:45<1:22:33,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 365/17503 [01:45<1:22:32,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 365/17503 [01:45<1:22:32,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 366/17503 [01:45<1:22:32,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 366/17503 [01:45<1:22:32,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 367/17503 [01:46<1:22:31,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 367/17503 [01:46<1:22:31,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 368/17503 [01:46<1:22:31,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 368/17503 [01:46<1:22:31,  3.46it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 369/17503 [01:46<1:22:31,  3.46it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 369/17503 [01:46<1:22:31,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 370/17503 [01:46<1:22:30,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 370/17503 [01:46<1:22:30,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 371/17503 [01:47<1:22:30,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 371/17503 [01:47<1:22:30,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 372/17503 [01:47<1:22:29,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 372/17503 [01:47<1:22:29,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 373/17503 [01:47<1:22:29,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 373/17503 [01:47<1:22:29,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 374/17503 [01:48<1:22:28,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 374/17503 [01:48<1:22:28,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 375/17503 [01:48<1:22:28,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 375/17503 [01:48<1:22:28,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 376/17503 [01:48<1:22:27,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 376/17503 [01:48<1:22:27,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 377/17503 [01:48<1:22:27,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 377/17503 [01:48<1:22:27,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 378/17503 [01:49<1:22:26,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 378/17503 [01:49<1:22:26,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 379/17503 [01:49<1:22:26,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 379/17503 [01:49<1:22:26,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 380/17503 [01:49<1:22:25,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 380/17503 [01:49<1:22:25,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 381/17503 [01:50<1:22:25,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 381/17503 [01:50<1:22:25,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 382/17503 [01:50<1:22:25,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 382/17503 [01:50<1:22:25,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 383/17503 [01:50<1:22:24,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 383/17503 [01:50<1:22:24,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 384/17503 [01:50<1:22:24,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 384/17503 [01:50<1:22:24,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 385/17503 [01:51<1:22:23,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 385/17503 [01:51<1:22:23,  3.46it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 386/17503 [01:51<1:22:23,  3.46it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 386/17503 [01:51<1:22:23,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 387/17503 [01:51<1:22:22,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 387/17503 [01:51<1:22:22,  3.46it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 388/17503 [01:52<1:22:22,  3.46it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 388/17503 [01:52<1:22:22,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 389/17503 [01:52<1:22:21,  3.46it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 389/17503 [01:52<1:22:21,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 390/17503 [01:52<1:22:21,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 390/17503 [01:52<1:22:21,  3.46it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 391/17503 [01:52<1:22:20,  3.46it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 391/17503 [01:52<1:22:20,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 392/17503 [01:53<1:22:20,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 392/17503 [01:53<1:22:20,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 393/17503 [01:53<1:22:19,  3.46it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 393/17503 [01:53<1:22:19,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 394/17503 [01:53<1:22:19,  3.46it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 394/17503 [01:53<1:22:19,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 395/17503 [01:54<1:22:18,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 395/17503 [01:54<1:22:19,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 396/17503 [01:54<1:22:18,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 396/17503 [01:54<1:22:18,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 397/17503 [01:54<1:22:18,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 397/17503 [01:54<1:22:18,  3.46it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 398/17503 [01:54<1:22:17,  3.46it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 398/17503 [01:54<1:22:17,  3.46it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 399/17503 [01:55<1:22:17,  3.46it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 399/17503 [01:55<1:22:17,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 400/17503 [01:55<1:22:16,  3.46it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 400/17503 [01:55<1:22:16,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 401/17503 [01:55<1:22:16,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 401/17503 [01:55<1:22:16,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 402/17503 [01:56<1:22:15,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 402/17503 [01:56<1:22:16,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 403/17503 [01:56<1:22:15,  3.46it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 403/17503 [01:56<1:22:15,  3.46it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 404/17503 [01:56<1:22:15,  3.46it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 404/17503 [01:56<1:22:15,  3.46it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 405/17503 [01:56<1:22:14,  3.46it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 405/17503 [01:56<1:22:14,  3.46it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 406/17503 [01:57<1:22:14,  3.47it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 406/17503 [01:57<1:22:14,  3.46it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 407/17503 [01:57<1:22:13,  3.47it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 407/17503 [01:57<1:22:13,  3.46it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 408/17503 [01:57<1:22:13,  3.47it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 408/17503 [01:57<1:22:13,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 409/17503 [01:58<1:22:13,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 409/17503 [01:58<1:22:13,  3.47it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 410/17503 [01:58<1:22:12,  3.47it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 410/17503 [01:58<1:22:12,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 411/17503 [01:58<1:22:12,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 411/17503 [01:58<1:22:12,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 412/17503 [01:58<1:22:11,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 412/17503 [01:58<1:22:11,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 413/17503 [01:59<1:22:11,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 413/17503 [01:59<1:22:11,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 414/17503 [01:59<1:22:10,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 414/17503 [01:59<1:22:10,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 415/17503 [01:59<1:22:10,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 415/17503 [01:59<1:22:10,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 416/17503 [02:00<1:22:09,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 416/17503 [02:00<1:22:09,  3.47it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 417/17503 [02:00<1:22:09,  3.47it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 417/17503 [02:00<1:22:09,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 418/17503 [02:00<1:22:09,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 418/17503 [02:00<1:22:09,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 419/17503 [02:00<1:22:08,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 419/17503 [02:00<1:22:08,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 420/17503 [02:01<1:22:08,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 420/17503 [02:01<1:22:08,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 421/17503 [02:01<1:22:07,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 421/17503 [02:01<1:22:07,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 422/17503 [02:01<1:22:07,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 422/17503 [02:01<1:22:07,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 423/17503 [02:02<1:22:06,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 423/17503 [02:02<1:22:06,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 424/17503 [02:02<1:22:06,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 424/17503 [02:02<1:22:06,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 425/17503 [02:02<1:22:06,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 425/17503 [02:02<1:22:06,  3.47it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 426/17503 [02:02<1:22:05,  3.47it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 426/17503 [02:02<1:22:05,  3.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 427/17503 [02:03<1:22:05,  3.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 427/17503 [02:03<1:22:05,  3.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 428/17503 [02:03<1:22:04,  3.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 428/17503 [02:03<1:22:04,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 429/17503 [02:03<1:22:04,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 429/17503 [02:03<1:22:04,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 430/17503 [02:04<1:22:03,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 430/17503 [02:04<1:22:03,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 431/17503 [02:04<1:22:03,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 431/17503 [02:04<1:22:03,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 432/17503 [02:04<1:22:03,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 432/17503 [02:04<1:22:03,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 433/17503 [02:04<1:22:02,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 433/17503 [02:04<1:22:02,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   2%|▏         | 434/17503 [02:05<1:22:02,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 434/17503 [02:05<1:22:02,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 435/17503 [02:05<1:22:01,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 435/17503 [02:05<1:22:01,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 436/17503 [02:05<1:22:01,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 436/17503 [02:05<1:22:01,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 437/17503 [02:06<1:22:01,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   2%|▏         | 437/17503 [02:06<1:22:01,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 438/17503 [02:06<1:22:00,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 438/17503 [02:06<1:22:00,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 439/17503 [02:06<1:22:00,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 439/17503 [02:06<1:22:00,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 440/17503 [02:06<1:21:59,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 440/17503 [02:06<1:21:59,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 441/17503 [02:07<1:21:59,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 441/17503 [02:07<1:21:59,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 442/17503 [02:07<1:21:59,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 442/17503 [02:07<1:21:59,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 443/17503 [02:07<1:21:58,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 443/17503 [02:07<1:21:58,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 444/17503 [02:08<1:21:58,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 444/17503 [02:08<1:21:58,  3.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 445/17503 [02:08<1:21:57,  3.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 445/17503 [02:08<1:21:57,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 446/17503 [02:08<1:21:57,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 446/17503 [02:08<1:21:57,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 447/17503 [02:08<1:21:56,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 447/17503 [02:08<1:21:56,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 448/17503 [02:09<1:21:56,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 448/17503 [02:09<1:21:56,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 449/17503 [02:09<1:21:56,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 449/17503 [02:09<1:21:56,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 450/17503 [02:09<1:21:55,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 450/17503 [02:09<1:21:55,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 451/17503 [02:10<1:21:55,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 451/17503 [02:10<1:21:55,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 452/17503 [02:10<1:21:54,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 452/17503 [02:10<1:21:54,  3.47it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 453/17503 [02:10<1:21:54,  3.47it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 453/17503 [02:10<1:21:54,  3.47it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 454/17503 [02:10<1:21:54,  3.47it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 454/17503 [02:10<1:21:54,  3.47it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 455/17503 [02:11<1:21:53,  3.47it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 455/17503 [02:11<1:21:53,  3.47it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 456/17503 [02:11<1:21:53,  3.47it/s, loss=1.39, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 456/17503 [02:11<1:21:53,  3.47it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 457/17503 [02:11<1:21:52,  3.47it/s, loss=1.38, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 457/17503 [02:11<1:21:52,  3.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 458/17503 [02:11<1:21:52,  3.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 458/17503 [02:11<1:21:52,  3.47it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 459/17503 [02:12<1:21:51,  3.47it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 459/17503 [02:12<1:21:51,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 460/17503 [02:12<1:21:51,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 460/17503 [02:12<1:21:51,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 461/17503 [02:12<1:21:51,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 461/17503 [02:12<1:21:51,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 462/17503 [02:13<1:21:50,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 462/17503 [02:13<1:21:50,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 463/17503 [02:13<1:21:50,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 463/17503 [02:13<1:21:50,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 464/17503 [02:13<1:21:49,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 464/17503 [02:13<1:21:49,  3.47it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 465/17503 [02:13<1:21:49,  3.47it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 465/17503 [02:13<1:21:49,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 466/17503 [02:14<1:21:49,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 466/17503 [02:14<1:21:49,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 467/17503 [02:14<1:21:48,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 467/17503 [02:14<1:21:48,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 468/17503 [02:14<1:21:48,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 468/17503 [02:14<1:21:48,  3.47it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 469/17503 [02:15<1:21:47,  3.47it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 469/17503 [02:15<1:21:47,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 470/17503 [02:15<1:21:47,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 470/17503 [02:15<1:21:47,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 471/17503 [02:15<1:21:47,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 471/17503 [02:15<1:21:47,  3.47it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 472/17503 [02:15<1:21:46,  3.47it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 472/17503 [02:15<1:21:46,  3.47it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 473/17503 [02:16<1:21:46,  3.47it/s, loss=1.23, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 473/17503 [02:16<1:21:46,  3.47it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 474/17503 [02:16<1:21:45,  3.47it/s, loss=1.22, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 474/17503 [02:16<1:21:46,  3.47it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 475/17503 [02:16<1:21:45,  3.47it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 475/17503 [02:16<1:21:45,  3.47it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 476/17503 [02:17<1:21:45,  3.47it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 476/17503 [02:17<1:21:45,  3.47it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 477/17503 [02:17<1:21:44,  3.47it/s, loss=1.24, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 477/17503 [02:17<1:21:44,  3.47it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 478/17503 [02:17<1:21:44,  3.47it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 478/17503 [02:17<1:21:44,  3.47it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 479/17503 [02:17<1:21:43,  3.47it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 479/17503 [02:17<1:21:44,  3.47it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 480/17503 [02:18<1:21:43,  3.47it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 480/17503 [02:18<1:21:43,  3.47it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 481/17503 [02:18<1:21:43,  3.47it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 481/17503 [02:18<1:21:43,  3.47it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 482/17503 [02:18<1:21:42,  3.47it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 482/17503 [02:18<1:21:42,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 483/17503 [02:19<1:21:42,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 483/17503 [02:19<1:21:42,  3.47it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 484/17503 [02:19<1:21:42,  3.47it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 484/17503 [02:19<1:21:42,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 485/17503 [02:19<1:21:41,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 485/17503 [02:19<1:21:41,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 486/17503 [02:19<1:21:41,  3.47it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 486/17503 [02:19<1:21:41,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 487/17503 [02:20<1:21:40,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 487/17503 [02:20<1:21:40,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 488/17503 [02:20<1:21:40,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 488/17503 [02:20<1:21:40,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 489/17503 [02:20<1:21:40,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 489/17503 [02:20<1:21:40,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 490/17503 [02:21<1:21:39,  3.47it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 490/17503 [02:21<1:21:39,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 491/17503 [02:21<1:21:39,  3.47it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 491/17503 [02:21<1:21:39,  3.47it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 492/17503 [02:21<1:21:38,  3.47it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 492/17503 [02:21<1:21:38,  3.47it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 493/17503 [02:21<1:21:38,  3.47it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 493/17503 [02:21<1:21:38,  3.47it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 494/17503 [02:22<1:21:38,  3.47it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 494/17503 [02:22<1:21:38,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 495/17503 [02:22<1:21:37,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 495/17503 [02:22<1:21:37,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 496/17503 [02:22<1:21:37,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 496/17503 [02:22<1:21:37,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 497/17503 [02:23<1:21:37,  3.47it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 497/17503 [02:23<1:21:37,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 498/17503 [02:23<1:21:36,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 498/17503 [02:23<1:21:36,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 499/17503 [02:23<1:21:36,  3.47it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 499/17503 [02:23<1:21:36,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 500/17503 [02:23<1:21:35,  3.47it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 500/17503 [02:23<1:21:35,  3.47it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]saving checkpoint, epoch =0
Epoch 0:   3%|▎         | 501/17503 [02:29<1:24:39,  3.35it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 501/17503 [02:29<1:24:39,  3.35it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 502/17503 [02:29<1:24:39,  3.35it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 502/17503 [02:29<1:24:39,  3.35it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 503/17503 [02:30<1:24:38,  3.35it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 503/17503 [02:30<1:24:38,  3.35it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 504/17503 [02:30<1:24:37,  3.35it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 504/17503 [02:30<1:24:37,  3.35it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 505/17503 [02:30<1:24:36,  3.35it/s, loss=1.36, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 505/17503 [02:30<1:24:36,  3.35it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 506/17503 [02:31<1:24:35,  3.35it/s, loss=1.37, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 506/17503 [02:31<1:24:35,  3.35it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 507/17503 [02:31<1:24:35,  3.35it/s, loss=1.35, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 507/17503 [02:31<1:24:35,  3.35it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 508/17503 [02:31<1:24:34,  3.35it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 508/17503 [02:31<1:24:34,  3.35it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 509/17503 [02:31<1:24:33,  3.35it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 509/17503 [02:31<1:24:33,  3.35it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 510/17503 [02:32<1:24:32,  3.35it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 510/17503 [02:32<1:24:32,  3.35it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 511/17503 [02:32<1:24:32,  3.35it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 511/17503 [02:32<1:24:32,  3.35it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 512/17503 [02:32<1:24:31,  3.35it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 512/17503 [02:32<1:24:31,  3.35it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 513/17503 [02:33<1:24:30,  3.35it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 513/17503 [02:33<1:24:30,  3.35it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 514/17503 [02:33<1:24:29,  3.35it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 514/17503 [02:33<1:24:29,  3.35it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 515/17503 [02:33<1:24:29,  3.35it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 515/17503 [02:33<1:24:29,  3.35it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 516/17503 [02:33<1:24:28,  3.35it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 516/17503 [02:33<1:24:28,  3.35it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 517/17503 [02:34<1:24:27,  3.35it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 517/17503 [02:34<1:24:27,  3.35it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 518/17503 [02:34<1:24:26,  3.35it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 518/17503 [02:34<1:24:26,  3.35it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 519/17503 [02:34<1:24:26,  3.35it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 519/17503 [02:34<1:24:26,  3.35it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 520/17503 [02:35<1:24:25,  3.35it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 520/17503 [02:35<1:24:25,  3.35it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 521/17503 [02:35<1:24:24,  3.35it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 521/17503 [02:35<1:24:24,  3.35it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 522/17503 [02:35<1:24:23,  3.35it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 522/17503 [02:35<1:24:23,  3.35it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 523/17503 [02:35<1:24:23,  3.35it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 523/17503 [02:35<1:24:23,  3.35it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 524/17503 [02:36<1:24:22,  3.35it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 524/17503 [02:36<1:24:22,  3.35it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 525/17503 [02:36<1:24:21,  3.35it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 525/17503 [02:36<1:24:21,  3.35it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 526/17503 [02:36<1:24:20,  3.35it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 526/17503 [02:36<1:24:20,  3.35it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 527/17503 [02:37<1:24:20,  3.35it/s, loss=1.25, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 527/17503 [02:37<1:24:20,  3.35it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 528/17503 [02:37<1:24:19,  3.36it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 528/17503 [02:37<1:24:19,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 529/17503 [02:37<1:24:18,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 529/17503 [02:37<1:24:18,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 530/17503 [02:37<1:24:17,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 530/17503 [02:37<1:24:17,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 531/17503 [02:38<1:24:17,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 531/17503 [02:38<1:24:17,  3.36it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 532/17503 [02:38<1:24:16,  3.36it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 532/17503 [02:38<1:24:16,  3.36it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 533/17503 [02:38<1:24:15,  3.36it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 533/17503 [02:38<1:24:15,  3.36it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 534/17503 [02:39<1:24:15,  3.36it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 534/17503 [02:39<1:24:15,  3.36it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 535/17503 [02:39<1:24:14,  3.36it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 535/17503 [02:39<1:24:14,  3.36it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 536/17503 [02:39<1:24:13,  3.36it/s, loss=1.34, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 536/17503 [02:39<1:24:13,  3.36it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 537/17503 [02:39<1:24:13,  3.36it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 537/17503 [02:39<1:24:13,  3.36it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 538/17503 [02:40<1:24:12,  3.36it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 538/17503 [02:40<1:24:12,  3.36it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 539/17503 [02:40<1:24:11,  3.36it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 539/17503 [02:40<1:24:11,  3.36it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 540/17503 [02:40<1:24:10,  3.36it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 540/17503 [02:40<1:24:10,  3.36it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 541/17503 [02:41<1:24:10,  3.36it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 541/17503 [02:41<1:24:10,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 542/17503 [02:41<1:24:09,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 542/17503 [02:41<1:24:09,  3.36it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 543/17503 [02:41<1:24:08,  3.36it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 543/17503 [02:41<1:24:08,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 544/17503 [02:41<1:24:08,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 544/17503 [02:41<1:24:08,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 545/17503 [02:42<1:24:07,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 545/17503 [02:42<1:24:07,  3.36it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 546/17503 [02:42<1:24:06,  3.36it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 546/17503 [02:42<1:24:06,  3.36it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 547/17503 [02:42<1:24:06,  3.36it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 547/17503 [02:42<1:24:06,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 548/17503 [02:43<1:24:05,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 548/17503 [02:43<1:24:05,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 549/17503 [02:43<1:24:04,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 549/17503 [02:43<1:24:04,  3.36it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 550/17503 [02:43<1:24:03,  3.36it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 550/17503 [02:43<1:24:03,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 551/17503 [02:43<1:24:03,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 551/17503 [02:43<1:24:03,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 552/17503 [02:44<1:24:02,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 552/17503 [02:44<1:24:02,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 553/17503 [02:44<1:24:01,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 553/17503 [02:44<1:24:01,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 554/17503 [02:44<1:24:01,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 554/17503 [02:44<1:24:01,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 555/17503 [02:45<1:24:00,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 555/17503 [02:45<1:24:00,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 556/17503 [02:45<1:23:59,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 556/17503 [02:45<1:23:59,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 557/17503 [02:45<1:23:59,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 557/17503 [02:45<1:23:59,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 558/17503 [02:45<1:23:58,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 558/17503 [02:45<1:23:58,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 559/17503 [02:46<1:23:57,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 559/17503 [02:46<1:23:57,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 560/17503 [02:46<1:23:57,  3.36it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 560/17503 [02:46<1:23:57,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 561/17503 [02:46<1:23:56,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 561/17503 [02:46<1:23:56,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 562/17503 [02:47<1:23:55,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 562/17503 [02:47<1:23:55,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 563/17503 [02:47<1:23:55,  3.36it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 563/17503 [02:47<1:23:55,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 564/17503 [02:47<1:23:54,  3.36it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 564/17503 [02:47<1:23:54,  3.36it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 565/17503 [02:47<1:23:53,  3.36it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 565/17503 [02:47<1:23:53,  3.36it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 566/17503 [02:48<1:23:53,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 566/17503 [02:48<1:23:53,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 567/17503 [02:48<1:23:52,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 567/17503 [02:48<1:23:52,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 568/17503 [02:48<1:23:51,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 568/17503 [02:48<1:23:51,  3.37it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 569/17503 [02:49<1:23:51,  3.37it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 569/17503 [02:49<1:23:51,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 570/17503 [02:49<1:23:50,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 570/17503 [02:49<1:23:50,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 571/17503 [02:49<1:23:49,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 571/17503 [02:49<1:23:49,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 572/17503 [02:49<1:23:49,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 572/17503 [02:49<1:23:49,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 573/17503 [02:50<1:23:48,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 573/17503 [02:50<1:23:48,  3.37it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 574/17503 [02:50<1:23:48,  3.37it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 574/17503 [02:50<1:23:48,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 575/17503 [02:50<1:23:47,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 575/17503 [02:50<1:23:47,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 576/17503 [02:51<1:23:46,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 576/17503 [02:51<1:23:46,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 577/17503 [02:51<1:23:46,  3.37it/s, loss=1.26, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 577/17503 [02:51<1:23:46,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 578/17503 [02:51<1:23:45,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 578/17503 [02:51<1:23:45,  3.37it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 579/17503 [02:51<1:23:44,  3.37it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 579/17503 [02:51<1:23:44,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 580/17503 [02:52<1:23:44,  3.37it/s, loss=1.27, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 580/17503 [02:52<1:23:44,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 581/17503 [02:52<1:23:43,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 581/17503 [02:52<1:23:43,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 582/17503 [02:52<1:23:42,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 582/17503 [02:52<1:23:42,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 583/17503 [02:53<1:23:42,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 583/17503 [02:53<1:23:42,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 584/17503 [02:53<1:23:41,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 584/17503 [02:53<1:23:41,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 585/17503 [02:53<1:23:40,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 585/17503 [02:53<1:23:40,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 586/17503 [02:53<1:23:40,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 586/17503 [02:53<1:23:40,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 587/17503 [02:54<1:23:39,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 587/17503 [02:54<1:23:39,  3.37it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 588/17503 [02:54<1:23:39,  3.37it/s, loss=1.33, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 588/17503 [02:54<1:23:39,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 589/17503 [02:54<1:23:38,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 589/17503 [02:54<1:23:38,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 590/17503 [02:55<1:23:37,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 590/17503 [02:55<1:23:37,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 591/17503 [02:55<1:23:37,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 591/17503 [02:55<1:23:37,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 592/17503 [02:55<1:23:36,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 592/17503 [02:55<1:23:36,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 593/17503 [02:55<1:23:35,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 593/17503 [02:55<1:23:35,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 594/17503 [02:56<1:23:35,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 594/17503 [02:56<1:23:35,  3.37it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 595/17503 [02:56<1:23:34,  3.37it/s, loss=1.28, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 595/17503 [02:56<1:23:34,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 596/17503 [02:56<1:23:33,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 596/17503 [02:56<1:23:33,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 597/17503 [02:57<1:23:33,  3.37it/s, loss=1.32, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 597/17503 [02:57<1:23:33,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 598/17503 [02:57<1:23:32,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 598/17503 [02:57<1:23:32,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 599/17503 [02:57<1:23:32,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 599/17503 [02:57<1:23:32,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 600/17503 [02:57<1:23:31,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 600/17503 [02:57<1:23:31,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 601/17503 [02:58<1:23:30,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 601/17503 [02:58<1:23:30,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 602/17503 [02:58<1:23:30,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 602/17503 [02:58<1:23:30,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 603/17503 [02:58<1:23:29,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 603/17503 [02:58<1:23:29,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 604/17503 [02:59<1:23:29,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 604/17503 [02:59<1:23:29,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290] 
Epoch 0:   3%|▎         | 605/17503 [02:59<1:23:28,  3.37it/s, loss=1.3, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 605/17503 [02:59<1:23:28,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 606/17503 [02:59<1:23:27,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 606/17503 [02:59<1:23:27,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 607/17503 [02:59<1:23:27,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 607/17503 [02:59<1:23:27,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 608/17503 [03:00<1:23:26,  3.37it/s, loss=1.31, v_num=rh5t, em_score=0.250, f1_score=0.290]
Epoch 0:   3%|▎         | 608/17503 [03:00<1:23:26,  3.37it/s, loss=1.29, v_num=rh5t, em_score=0.250, f1_score=0.290]slurmstepd: error: *** JOB 7490624 ON g3043 CANCELLED AT 2022-11-15T07:07:53 ***
