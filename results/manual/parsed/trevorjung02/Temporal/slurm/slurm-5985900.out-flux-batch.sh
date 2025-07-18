#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=8
#FLUX: --queue=gpu-a40
#FLUX: -t=39600
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/templama/training/t5_kadapters_2010_prefixed.json
--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/T5_small_templama(2010)_lr.001_adapters_prefixed exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.layer_norm.weight', 'kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapter.1.down_project.weight', 'kadapter.pool.bias', 'kadapter.adapter.2.up_project.weight', 'kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.0.down_project.bias', 'kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.pool.weight', 'kadapter.adapter.1.up_project.weight', 'kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapter.2.up_project.bias', 'kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapter.0.up_project.bias', 'kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapter.2.down_project.weight', 'kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapter.0.down_project.weight', 'kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapter.2.down_project.bias', 'kadapter.adapter.1.up_project.bias', 'kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapter.0.up_project.weight', 'kadapter.adapter.1.down_project.bias']
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
43.8 M    Trainable params
35.3 M    Non-trainable params
79.1 M    Total params
316.510   Total estimated model params size (MB)
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_hidden_size': 128, 'adapter_list': [1, 5, 8]}, check_validation_only=False, checkpoint_path='', dataset='templama', dataset_version='2010', early_stop_callback=False, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=1, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=50, num_workers=4, opt_level='O1', output_dir='outputs/T5_small_templama(2010)_lr.001_adapters_prefixed', output_log=None, prefix=True, resume_from_checkpoint='outputs/T5_small_templama(2010)_lr.001_adapters_prefixed/epoch=21-f1_score=0.22-em_score=0.08.ckpt', seed=42, split=0, split_num=1, t5_learning_rate=0.0001, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, wandb_log=False, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
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
Length of dataset retrieving is.. 2866
<generator object Optimizer.load_state_dict.<locals>.<genexpr> at 0x14ce26ffb040>
<generator object Optimizer.load_state_dict.<locals>.<genexpr> at 0x14ce2b588dd0>
Traceback (most recent call last):
  File "run.py", line 160, in <module>
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
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 839, in run_train
    self._pre_training_routine()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 832, in _pre_training_routine
    self.checkpoint_connector.restore_weights()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/connectors/checkpoint_connector.py", line 73, in restore_weights
    self.restore(self.trainer.resume_from_checkpoint, on_gpu=self.trainer._device_type == DeviceType.GPU)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/connectors/checkpoint_connector.py", line 102, in restore
    self.restore_training_state(checkpoint, load_optimizer_states)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/connectors/checkpoint_connector.py", line 182, in restore_training_state
    optimizer.load_state_dict(opt_state)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/optim/optimizer.py", line 147, in load_state_dict
    raise ValueError("loaded state dict contains a parameter group "
ValueError: loaded state dict contains a parameter group that doesn't match the size of optimizer's group
