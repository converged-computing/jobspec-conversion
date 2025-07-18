#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: --queue=gpu-rtx6k
#FLUX: -t=86400
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/templama/training/t5_kadapters_load.json
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/templamakadapter_full_2freeze_158_128 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-large-ssm and are newly initialized: ['enc_kadapter.pool.bias', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.pool.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Set SLURM handle signals.
  | Name  | Type                       | Params
-----------------------------------------------------
0 | model | T5ForConditionalGeneration | 743 M 
-----------------------------------------------------
5.5 M     Trainable params
737 M     Non-trainable params
743 M     Total params
2,972.720 Total estimated model params size (MB)
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=32, find_lr=False, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.003, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter', mode='pretrain', model_name_or_path='google/t5-large-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=0, opt_level='O1', output_dir='outputs/templamakadapter_full_2freeze_158_128', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=True, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-large-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=False, val_check_interval=1.0, val_data='full', wandb_log=False, warmup_steps=0, weight_decay=0.0)
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
enc_kadapter.pool.weight
enc_kadapter.pool.bias
hparams.learning_rate = 0.003
Traceback (most recent call last):
  File "run.py", line 265, in <module>
    main()
  File "run.py", line 255, in main
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
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/connectors/checkpoint_connector.py", line 92, in restore
    checkpoint, load_optimizer_states = self.trainer.training_type_plugin.restore_model_state_from_ckpt_path(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/plugins/training_type/training_type_plugin.py", line 222, in restore_model_state_from_ckpt_path
    ckpt = pl_load(ckpt_path, map_location=map_location)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/utilities/cloud_io.py", line 32, in load
    with fs.open(path_or_url, "rb") as f:
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/fsspec/spec.py", line 1034, in open
    f = self._open(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/fsspec/implementations/local.py", line 162, in _open
    return LocalFileOpener(path, mode, fs=self, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/fsspec/implementations/local.py", line 260, in __init__
    self._open()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/fsspec/implementations/local.py", line 265, in _open
    self.f = open(self.path, mode=self.mode)
IsADirectoryError: [Errno 21] Is a directory: '/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning'
