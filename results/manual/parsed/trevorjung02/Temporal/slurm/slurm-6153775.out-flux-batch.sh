#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=4
#FLUX: --queue=gpu-rtx6k
#FLUX: -t=39600
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/situatedqa/training/t5_kadapters_soft_yearly_2freeze.json --------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220915_053723-1p7j6iia
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_2018-
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/1p7j6iia
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.year_embeds.0.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.up_project.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.0.down_project.bias', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.8.up_project.bias', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.pool.bias', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.pool.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='situatedqa', dataset_version='2018-', early_stop_callback=False, eval_batch_size=64, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=60, num_workers=4, opt_level='O1', output_dir='outputs/situatedqakadapter_soft_2018-_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=64, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2018-', wandb_log=True, warmup_steps=0, weight_decay=0.0)
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
wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.000 MB of 0.000 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.022 MB uploaded (0.000 MB deduped)
wandb: - 0.001 MB of 0.022 MB uploaded (0.000 MB deduped)
wandb: \ 0.022 MB of 0.022 MB uploaded (0.000 MB deduped)
wandb: | 0.022 MB of 0.022 MB uploaded (0.000 MB deduped)
wandb: / 0.022 MB of 0.022 MB uploaded (0.000 MB deduped)
wandb: - 0.022 MB of 0.022 MB uploaded (0.000 MB deduped)
wandb: \ 0.022 MB of 0.022 MB uploaded (0.000 MB deduped)
wandb: | 0.022 MB of 0.022 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced kadapter_soft_2018-: https://wandb.ai/tjung2/temporal_questions/runs/1p7j6iia
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220915_053723-1p7j6iia/logs
Traceback (most recent call last):
  File "run.py", line 219, in <module>
    trainer.fit(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 460, in fit
    self._run(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 717, in _run
    self.accelerator.setup(self, model)  # note: this sets up self.lightning_module
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/gpu.py", line 41, in setup
    return super().setup(trainer, model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/accelerator.py", line 92, in setup
    self.setup_optimizers(trainer)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/accelerator.py", line 374, in setup_optimizers
    optimizers, lr_schedulers, optimizer_frequencies = self.training_type_plugin.init_optimizers(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/plugins/training_type/training_type_plugin.py", line 190, in init_optimizers
    return trainer.init_optimizers(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/optimizers.py", line 34, in init_optimizers
    optim_conf = model.configure_optimizers()
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 442, in configure_optimizers
    len_data = len(self.train_dataloader())
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 450, in train_dataloader
    train_dataset = self.get_dataset(tokenizer=self.tokenizer, type_path="train", num_samples=n_samples, args=self.hparams)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 256, in get_dataset
    dataset = Pretrain(tokenizer=tokenizer, type_path=type_path, num_samples=num_samples,  input_length=args.max_input_length,
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/Datasets.py", line 90, in __init__
    self.dataset= pd.read_csv(f'data/situatedqa/sqa_train_{self.dataset_version}_prefixed.csv')
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/util/_decorators.py", line 311, in wrapper
    return func(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/io/parsers/readers.py", line 680, in read_csv
    return _read(filepath_or_buffer, kwds)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/io/parsers/readers.py", line 575, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/io/parsers/readers.py", line 934, in __init__
    self._engine = self._make_engine(f, self.engine)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/io/parsers/readers.py", line 1218, in _make_engine
    self.handles = get_handle(  # type: ignore[call-overload]
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/io/common.py", line 786, in get_handle
    handle = open(
FileNotFoundError: [Errno 2] No such file or directory: 'data/situatedqa/sqa_train_2018-_prefixed.csv'
