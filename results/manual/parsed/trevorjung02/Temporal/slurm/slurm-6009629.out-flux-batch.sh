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
python run.py --config configs/templama/training/t5_kadapters_2010_2freeze.json
--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.2 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220831_000337-3nmto2er
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapters_2010
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/3nmto2er
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/kadapters_2010_2freeze_158_32 exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['dec_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'dec_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'dec_kadapter.adapter.2.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.pool.weight', 'dec_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'dec_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'dec_kadapter.adapter.1.encoder.layer.1.EncDecAttention.o.weight', 'dec_kadapter.adapter.0.down_project.bias', 'dec_kadapter.adapter.0.encoder.layer.1.EncDecAttention.k.weight', 'dec_kadapter.adapter.2.encoder.layer.2.layer_norm.weight', 'dec_kadapter.adapter.2.encoder.layer.2.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.pool.bias', 'dec_kadapter.adapter.0.encoder.layer.2.DenseReluDense.wi_1.weight', 'dec_kadapter.layer_norm.weight', 'dec_kadapter.pool.weight', 'dec_kadapter.adapter.0.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'dec_kadapter.adapter.0.encoder.layer.2.layer_norm.weight', 'dec_kadapter.adapter.0.encoder.layer.1.EncDecAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'dec_kadapter.adapter.0.encoder.layer.2.DenseReluDense.wi_0.weight', 'dec_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'dec_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.1.down_project.bias', 'dec_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'dec_kadapter.adapter.2.encoder.layer.1.EncDecAttention.q.weight', 'dec_kadapter.adapter.1.encoder.layer.2.layer_norm.weight', 'enc_kadapter.layer_norm.weight', 'dec_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.0.encoder.layer.1.DenseReluDense.wo.weight', 'dec_kadapter.adapter.1.encoder.layer.1.EncDecAttention.q.weight', 'dec_kadapter.adapter.1.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.up_project.bias', 'dec_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'dec_kadapter.adapter.1.encoder.layer.2.DenseReluDense.wi_0.weight', 'dec_kadapter.adapter.2.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.1.encoder.layer.0.layer_norm.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.0.down_project.bias', 'dec_kadapter.adapter.1.encoder.layer.2.DenseReluDense.wo.weight', 'dec_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.2.up_project.weight', 'dec_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'dec_kadapter.adapter.0.encoder.layer.2.DenseReluDense.wo.weight', 'dec_kadapter.adapter.1.encoder.layer.2.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.2.up_project.bias', 'dec_kadapter.adapter.2.encoder.layer.1.EncDecAttention.o.weight', 'dec_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'dec_kadapter.adapter.1.up_project.bias', 'dec_kadapter.adapter.2.encoder.layer.0.layer_norm.weight', 'dec_kadapter.adapter.0.encoder.layer.1.EncDecAttention.v.weight', 'dec_kadapter.adapter.1.down_project.weight', 'dec_kadapter.adapter.1.encoder.layer.1.EncDecAttention.k.weight', 'dec_kadapter.pool.bias', 'dec_kadapter.adapter.2.encoder.layer.2.DenseReluDense.wi_0.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'dec_kadapter.adapter.0.encoder.layer.1.EncDecAttention.o.weight', 'dec_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'dec_kadapter.adapter.0.up_project.bias', 'enc_kadapter.adapter.2.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.1.encoder.layer.1.layer_norm.weight', 'dec_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'dec_kadapter.adapter.2.encoder.layer.2.DenseReluDense.wo.weight', 'dec_kadapter.adapter.2.encoder.layer.1.EncDecAttention.k.weight', 'enc_kadapter.adapter.2.encoder.layer.1.DenseReluDense.wo.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.v.weight', 'dec_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'dec_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.1.encoder.layer.0.SelfAttention.k.weight', 'dec_kadapter.adapter.1.encoder.layer.1.EncDecAttention.v.weight', 'dec_kadapter.adapter.0.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.k.weight', 'dec_kadapter.adapter.1.encoder.layer.0.SelfAttention.v.weight', 'enc_kadapter.adapter.1.up_project.weight', 'dec_kadapter.adapter.2.encoder.layer.1.EncDecAttention.v.weight', 'dec_kadapter.adapter.0.encoder.layer.1.layer_norm.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.q.weight', 'enc_kadapter.adapter.2.down_project.bias', 'dec_kadapter.adapter.2.down_project.bias', 'dec_kadapter.adapter.1.up_project.weight', 'dec_kadapter.adapter.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'enc_kadapter.adapter.2.encoder.layer.0.SelfAttention.k.weight', 'enc_kadapter.adapter.1.up_project.bias', 'dec_kadapter.adapter.2.encoder.layer.0.SelfAttention.o.weight', 'enc_kadapter.adapter.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'dec_kadapter.adapter.0.up_project.weight', 'enc_kadapter.adapter.0.up_project.weight']
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
0 | model | T5ForConditionalGeneration | 78.2 M
-----------------------------------------------------
1.2 M     Trainable params
77.0 M    Non-trainable params
78.2 M    Total params
312.784   Total estimated model params size (MB)
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_hidden_size': 32, 'adapter_list': [1, 5, 8]}, check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='templama', dataset_version='2010', early_stop_callback=False, enc_dec=None, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=90, num_workers=4, opt_level='O1', output_dir='outputs/kadapters_2010_2freeze', output_log=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_hidden_size": 32,
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
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_hidden_size": 32,
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
  "is_decoder": true,
  "is_encoder_decoder": false,
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
  "use_cache": true,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 2866
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 410
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]Decoder Adapter
wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.023 MB uploaded (0.000 MB deduped)
wandb: - 0.001 MB of 0.023 MB uploaded (0.000 MB deduped)
wandb: \ 0.023 MB of 0.023 MB uploaded (0.000 MB deduped)
wandb: | 0.023 MB of 0.023 MB uploaded (0.000 MB deduped)
wandb: / 0.023 MB of 0.023 MB uploaded (0.000 MB deduped)
wandb: - 0.023 MB of 0.023 MB uploaded (0.000 MB deduped)
wandb: \ 0.023 MB of 0.023 MB uploaded (0.000 MB deduped)
wandb: | 0.023 MB of 0.023 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced kadapters_2010: https://wandb.ai/tjung2/temporal_questions/runs/3nmto2er
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220831_000337-3nmto2er/logs
Traceback (most recent call last):
  File "run.py", line 188, in <module>
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
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/plugins/training_type/ddp.py", line 340, in validation_step
    return self.model(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/parallel/distributed.py", line 799, in forward
    output = self.module(*inputs[0], **kwargs[0])
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/overrides/base.py", line 57, in forward
    output = self.module.validation_step(*inputs, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 361, in validation_step
    preds = self._generative_step(batch)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 322, in _generative_step
    generated_ids = self.model.generate(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/autograd/grad_mode.py", line 28, in decorate_context
    return func(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/transformers/generation_utils.py", line 1054, in generate
    return self.beam_search(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/transformers/generation_utils.py", line 1791, in beam_search
    outputs = self(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5.py", line 1708, in forward
    sequence_output = self.dec_kadapter(decoder_outputs[0])
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5.py", line 1851, in forward
    sequence_output = outputs.last_hidden_state
AttributeError: 'Tensor' object has no attribute 'last_hidden_state'
