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
python run.py --config configs/templama/training/t5_kadapters_soft_full_prefixed.json
--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.2 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220831_214706-24pl19u2
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run kadapter_soft_full
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/24pl19u2
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.7.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.5.down_project.bias', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.2.down_project.weight', 'kadapter.adapters.3.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.1.up_project.bias', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.up_project.weight', 'kadapter.adapters.3.up_project.bias', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.5.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.8.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.3.down_project.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.2.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.4.up_project.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.up_project.weight', 'kadapter.adapters.4.down_project.bias', 'kadapter.adapters.8.down_project.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.2.down_project.bias', 'kadapter.year_embeds.0.weight', 'kadapter.pool.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.o.weight', 'kadapter.year_embeds.1.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.5.up_project.bias', 'kadapter.adapters.5.up_project.weight', 'kadapter.pool.bias', 'kadapter.adapters.6.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.down_project.weight', 'kadapter.adapters.4.up_project.bias', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.2.up_project.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.7.down_project.bias', 'kadapter.adapters.7.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.6.down_project.bias', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.8.down_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.7.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.3.down_project.bias', 'kadapter.adapters.1.down_project.bias', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.3.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.5.down_project.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.up_project.bias', 'kadapter.adapters.5.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.8.up_project.bias', 'kadapter.adapters.0.encoder.layer.0.layer_norm.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.6.up_project.weight', 'kadapter.adapters.8.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.2.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.0.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.6.down_project.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.o.weight', 'kadapter.adapters.3.up_project.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.8.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.2.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.6.up_project.bias', 'kadapter.adapters.1.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.down_project.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.k.weight', 'kadapter.adapters.7.up_project.weight', 'kadapter.adapters.4.encoder.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.down_project.weight', 'kadapter.adapters.3.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.encoder.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.4.encoder.layer.0.SelfAttention.v.weight', 'kadapter.adapters.7.down_project.weight', 'kadapter.adapters.7.up_project.bias', 'kadapter.adapters.1.up_project.weight', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.o.weight', 'kadapter.year_embeds.2.weight', 'kadapter.adapters.0.down_project.bias', 'kadapter.adapters.2.up_project.bias', 'kadapter.adapters.1.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.6.encoder.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.5.encoder.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.6.encoder.layer.0.layer_norm.weight', 'kadapter.adapters.7.encoder.layer.0.SelfAttention.q.weight', 'kadapter.adapters.2.encoder.layer.1.layer_norm.weight', 'kadapter.adapters.4.encoder.layer.0.layer_norm.weight']
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
0 | model | T5ForConditionalGeneration | 83.5 M
-----------------------------------------------------
6.5 M     Trainable params
77.0 M    Non-trainable params
83.5 M    Total params
333.838   Total estimated model params size (MB)
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': 3}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=[1, 5, 8], check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=256, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/kadapter_soft_full_2freeze_158_128', output_log=None, pool_size=3, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=256, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, wandb_log=True, warmup_steps=0, weight_decay=0.0)
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
Length of dataset retrieving is.. 28616
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 4124
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: - 0.001 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: \ 0.016 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: | 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: / 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: - 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: \ 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: | 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: / 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced kadapter_soft_full: https://wandb.ai/tjung2/temporal_questions/runs/24pl19u2
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220831_214706-24pl19u2/logs
Traceback (most recent call last):
  File "run.py", line 210, in <module>
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
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 311, in _generative_step
    generated_ids = self.model.generate(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/autograd/grad_mode.py", line 28, in decorate_context
    return func(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/transformers/generation_utils.py", line 1054, in generate
    return self.beam_search(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/transformers/generation_utils.py", line 1791, in beam_search
    outputs = self(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5_soft.py", line 1661, in forward
    hidden_states = self.kadapter(encoder_outputs, year)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5_soft.py", line 1873, in forward
    hidden_states_last_pooled = torch.mm(permuted, year_embeddings)
RuntimeError: tensors must be 2-D
