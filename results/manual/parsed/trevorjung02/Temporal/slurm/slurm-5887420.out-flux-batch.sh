#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=8
#FLUX: --queue=gpu-a40
#FLUX: -t=17940
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/templama/training/t5_kadapters_soft_full_prefixed.json
--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220819_035004-ziy7693r
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run T5_small_templama(full)_lr.001_kadapters_soft_prefixed
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/ziy7693r
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.0.0.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.1.layer.0.layer_norm.weight', 'kadapter.adapters.1.1.layer.0.layer_norm.weight', 'kadapter.adapters.1.0.layer.1.layer_norm.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.1.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.0.layer.0.layer_norm.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.2.layer.1.layer_norm.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.2.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.2.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.2.layer.0.layer_norm.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.0.layer.0.layer_norm.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.2.layer.1.layer_norm.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.2.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.0.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.2.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.0.layer.1.layer_norm.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.0.layer.1.DenseReluDense.wo.weight', 'kadapter.ff.bias', 'kadapter.adapters.0.0.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.1.layer.1.layer_norm.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.2.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.2.layer.1.DenseReluDense.wi_0.weight', 'kadapter.ff.weight', 'kadapter.adapters.0.0.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.0.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.1.layer.1.layer_norm.weight', 'kadapter.adapters.0.2.layer.0.layer_norm.weight']
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
0 | model | T5ForConditionalGeneration | 91.1 M
-----------------------------------------------------
55.8 M    Trainable params
35.3 M    Non-trainable params
91.1 M    Total params
364.496   Total estimated model params size (MB)
Namespace(accelerator='ddp', adam_epsilon=1e-08, check_validation_only=False, checkpoint_path='', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=1, learning_rate=0.003, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=8, num_workers=4, opt_level='O1', output_dir='outputs/T5_small_templama(full)_lr.001_kadapters_soft_prefixed', output_log=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, warmup_steps=0, weight_decay=0.0)
split is 0
Length of dataset retrieving is.. 35226
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 5037
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]
Validation sanity check:  50%|█████     | 1/2 [00:01<00:01,  1.09s/it]
Validation sanity check: 100%|██████████| 2/2 [00:01<00:00,  1.18it/s]
split is 0
Length of dataset retrieving is.. 35226
Training: 0it [00:00, ?it/s]
Training:   0%|          | 0/1258 [00:00<?, ?it/s]
Epoch 0:   0%|          | 0/1258 [00:00<?, ?it/s] wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.009 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb: \ 0.016 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb: | 0.016 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb: / 0.016 MB of 0.037 MB uploaded (0.000 MB deduped)
wandb: - 0.034 MB of 0.037 MB uploaded (0.000 MB deduped)
wandb: \ 0.037 MB of 0.037 MB uploaded (0.000 MB deduped)
wandb: | 0.037 MB of 0.037 MB uploaded (0.000 MB deduped)
wandb: / 0.037 MB of 0.037 MB uploaded (0.000 MB deduped)
wandb: - 0.037 MB of 0.037 MB uploaded (0.000 MB deduped)
wandb: \ 0.037 MB of 0.037 MB uploaded (0.000 MB deduped)
wandb: | 0.037 MB of 0.037 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced T5_small_templama(full)_lr.001_kadapters_soft_prefixed: https://wandb.ai/tjung2/temporal_questions/runs/ziy7693r
wandb: Synced 6 W&B file(s), 1 media file(s), 1 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220819_035004-ziy7693r/logs
Traceback (most recent call last):
  File "run.py", line 164, in <module>
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
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 871, in run_train
    self.train_loop.run_training_epoch()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/training_loop.py", line 499, in run_training_epoch
    batch_output = self.run_training_batch(batch, batch_idx, dataloader_idx)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/training_loop.py", line 738, in run_training_batch
    self.optimizer_step(optimizer, opt_idx, batch_idx, train_step_and_backward_closure)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/training_loop.py", line 434, in optimizer_step
    model_ref.optimizer_step(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/core/lightning.py", line 1403, in optimizer_step
    optimizer.step(closure=optimizer_closure)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/core/optimizer.py", line 214, in step
    self.__optimizer_step(*args, closure=closure, profiler_name=profiler_name, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/core/optimizer.py", line 134, in __optimizer_step
    trainer.accelerator.optimizer_step(optimizer, self._optimizer_idx, lambda_closure=closure, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/accelerator.py", line 329, in optimizer_step
    self.run_optimizer_step(optimizer, opt_idx, lambda_closure, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/accelerator.py", line 336, in run_optimizer_step
    self.training_type_plugin.optimizer_step(optimizer, lambda_closure=lambda_closure, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/plugins/training_type/training_type_plugin.py", line 193, in optimizer_step
    optimizer.step(closure=lambda_closure, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/optim/lr_scheduler.py", line 65, in wrapper
    return wrapped(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/optim/optimizer.py", line 88, in wrapper
    return func(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/autograd/grad_mode.py", line 28, in decorate_context
    return func(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/optim/adamw.py", line 65, in step
    loss = closure()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/training_loop.py", line 732, in train_step_and_backward_closure
    result = self.training_step_and_backward(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/training_loop.py", line 823, in training_step_and_backward
    result = self.training_step(split_batch, batch_idx, opt_idx, hiddens)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/training_loop.py", line 290, in training_step
    training_step_output = self.trainer.accelerator.training_step(args)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/accelerator.py", line 204, in training_step
    return self.training_type_plugin.training_step(*args)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/plugins/training_type/ddp.py", line 337, in training_step
    return self.model(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/parallel/distributed.py", line 799, in forward
    output = self.module(*inputs[0], **kwargs[0])
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/overrides/base.py", line 46, in forward
    output = self.module.training_step(*inputs, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 298, in training_step
    loss = self._step(batch)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 264, in _step
    outputs = self(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 253, in forward
    return self.model(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5_soft.py", line 1581, in forward
    hidden_states = self.kadapter(encoder_outputs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5_soft.py", line 1752, in forward
    outputs = (scale_factor * self.layer_norm(pooled_outputs)) + sequence_output
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5_soft.py", line 247, in forward
    return self.weight * hidden_states
RuntimeError: The size of tensor a (512) must match the size of tensor b (50) at non-singleton dimension 2
