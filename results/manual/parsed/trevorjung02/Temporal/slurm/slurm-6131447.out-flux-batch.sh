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
python run.py --config configs/templama/training/t5_padapters2_yearly_2freeze.json--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.3 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220908_235953-fmek5e5x
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run padapter2_2010
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/fmek5e5x
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of the model checkpoint at google/t5-small-ssm were not used when initializing T5ForConditionalGeneration: ['decoder.block.6.layer.0.SelfAttention.v.weight', 'decoder.block.2.layer.1.EncDecAttention.q.weight', 'decoder.block.3.layer.2.DenseReluDense.wo.weight', 'decoder.block.6.layer.0.SelfAttention.o.weight', 'decoder.block.5.layer.1.EncDecAttention.q.weight', 'decoder.block.2.layer.2.layer_norm.weight', 'decoder.block.6.layer.1.EncDecAttention.q.weight', 'decoder.block.1.layer.2.DenseReluDense.wi_1.weight', 'decoder.block.7.layer.0.SelfAttention.k.weight', 'decoder.block.1.layer.2.DenseReluDense.wo.weight', 'decoder.block.3.layer.2.DenseReluDense.wi_0.weight', 'decoder.block.7.layer.0.SelfAttention.v.weight', 'decoder.block.1.layer.1.EncDecAttention.q.weight', 'decoder.block.0.layer.2.DenseReluDense.wi_0.weight', 'decoder.block.3.layer.2.layer_norm.weight', 'decoder.block.4.layer.1.layer_norm.weight', 'decoder.block.5.layer.0.SelfAttention.k.weight', 'decoder.block.4.layer.2.DenseReluDense.wi_0.weight', 'decoder.block.1.layer.2.layer_norm.weight', 'decoder.block.5.layer.0.SelfAttention.v.weight', 'decoder.block.1.layer.0.SelfAttention.v.weight', 'decoder.block.3.layer.2.DenseReluDense.wi_1.weight', 'decoder.block.7.layer.2.DenseReluDense.wo.weight', 'decoder.block.1.layer.0.SelfAttention.q.weight', 'decoder.block.7.layer.2.DenseReluDense.wi_0.weight', 'decoder.block.0.layer.2.DenseReluDense.wi_1.weight', 'decoder.block.6.layer.0.layer_norm.weight', 'decoder.block.3.layer.1.EncDecAttention.q.weight', 'decoder.block.7.layer.2.layer_norm.weight', 'decoder.block.7.layer.1.EncDecAttention.o.weight', 'decoder.block.4.layer.0.layer_norm.weight', 'decoder.block.4.layer.1.EncDecAttention.q.weight', 'decoder.block.6.layer.1.EncDecAttention.o.weight', 'decoder.block.4.layer.1.EncDecAttention.k.weight', 'decoder.block.7.layer.0.layer_norm.weight', 'decoder.block.6.layer.1.EncDecAttention.v.weight', 'decoder.block.0.layer.0.SelfAttention.v.weight', 'decoder.block.6.layer.2.layer_norm.weight', 'decoder.block.1.layer.1.layer_norm.weight', 'decoder.block.0.layer.0.SelfAttention.q.weight', 'decoder.block.2.layer.0.SelfAttention.q.weight', 'decoder.block.7.layer.1.EncDecAttention.v.weight', 'decoder.block.3.layer.1.EncDecAttention.o.weight', 'decoder.block.1.layer.1.EncDecAttention.k.weight', 'decoder.block.6.layer.2.DenseReluDense.wi_0.weight', 'decoder.block.7.layer.1.EncDecAttention.q.weight', 'decoder.block.2.layer.2.DenseReluDense.wi_1.weight', 'decoder.block.4.layer.0.SelfAttention.k.weight', 'decoder.block.5.layer.0.SelfAttention.o.weight', 'decoder.block.4.layer.1.EncDecAttention.o.weight', 'decoder.block.6.layer.0.SelfAttention.q.weight', 'decoder.block.4.layer.1.EncDecAttention.v.weight', 'decoder.block.0.layer.2.DenseReluDense.wo.weight', 'decoder.block.1.layer.1.EncDecAttention.o.weight', 'decoder.block.5.layer.1.EncDecAttention.o.weight', 'decoder.block.0.layer.1.EncDecAttention.k.weight', 'decoder.block.1.layer.0.SelfAttention.k.weight', 'decoder.block.3.layer.0.SelfAttention.k.weight', 'decoder.block.2.layer.1.EncDecAttention.v.weight', 'decoder.block.5.layer.1.EncDecAttention.k.weight', 'decoder.block.7.layer.0.SelfAttention.q.weight', 'decoder.block.6.layer.1.EncDecAttention.k.weight', 'decoder.block.5.layer.2.layer_norm.weight', 'decoder.block.2.layer.1.layer_norm.weight', 'decoder.block.5.layer.0.SelfAttention.q.weight', 'decoder.block.5.layer.0.layer_norm.weight', 'decoder.block.5.layer.2.DenseReluDense.wi_0.weight', 'decoder.block.2.layer.0.SelfAttention.o.weight', 'decoder.block.2.layer.0.layer_norm.weight', 'decoder.block.5.layer.1.layer_norm.weight', 'decoder.embed_tokens.weight', 'decoder.block.6.layer.0.SelfAttention.k.weight', 'decoder.block.3.layer.0.SelfAttention.q.weight', 'decoder.block.7.layer.2.DenseReluDense.wi_1.weight', 'decoder.block.7.layer.1.layer_norm.weight', 'decoder.block.2.layer.2.DenseReluDense.wi_0.weight', 'decoder.block.6.layer.2.DenseReluDense.wo.weight', 'decoder.block.0.layer.0.SelfAttention.relative_attention_bias.weight', 'decoder.block.3.layer.1.layer_norm.weight', 'decoder.block.4.layer.2.layer_norm.weight', 'decoder.block.0.layer.1.EncDecAttention.q.weight', 'decoder.block.2.layer.0.SelfAttention.k.weight', 'decoder.final_layer_norm.weight', 'decoder.block.2.layer.0.SelfAttention.v.weight', 'decoder.block.4.layer.0.SelfAttention.v.weight', 'decoder.block.0.layer.0.SelfAttention.o.weight', 'decoder.block.0.layer.1.EncDecAttention.v.weight', 'decoder.block.3.layer.0.SelfAttention.o.weight', 'decoder.block.5.layer.2.DenseReluDense.wi_1.weight', 'decoder.block.7.layer.0.SelfAttention.o.weight', 'decoder.block.3.layer.0.SelfAttention.v.weight', 'decoder.block.4.layer.2.DenseReluDense.wi_1.weight', 'decoder.block.0.layer.1.EncDecAttention.o.weight', 'decoder.block.0.layer.1.layer_norm.weight', 'decoder.block.3.layer.0.layer_norm.weight', 'decoder.block.3.layer.1.EncDecAttention.v.weight', 'decoder.block.1.layer.2.DenseReluDense.wi_0.weight', 'decoder.block.4.layer.0.SelfAttention.o.weight', 'decoder.block.7.layer.1.EncDecAttention.k.weight', 'decoder.block.3.layer.1.EncDecAttention.k.weight', 'decoder.block.5.layer.1.EncDecAttention.v.weight', 'decoder.block.0.layer.0.layer_norm.weight', 'decoder.block.4.layer.2.DenseReluDense.wo.weight', 'decoder.block.0.layer.0.SelfAttention.k.weight', 'decoder.block.5.layer.2.DenseReluDense.wo.weight', 'decoder.block.6.layer.2.DenseReluDense.wi_1.weight', 'decoder.block.4.layer.0.SelfAttention.q.weight', 'decoder.block.0.layer.2.layer_norm.weight', 'decoder.block.2.layer.2.DenseReluDense.wo.weight', 'decoder.block.1.layer.0.layer_norm.weight', 'decoder.block.1.layer.1.EncDecAttention.v.weight', 'decoder.block.2.layer.1.EncDecAttention.o.weight', 'decoder.block.6.layer.1.layer_norm.weight', 'decoder.block.2.layer.1.EncDecAttention.k.weight', 'decoder.block.1.layer.0.SelfAttention.o.weight']
- This IS expected if you are initializing T5ForConditionalGeneration from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing T5ForConditionalGeneration from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['encoder.block.3.adapter_pooling.bias', 'encoder.block.6.adapter.DenseReluDense.wi_1.weight', 'encoder.block.2.adapter.DenseReluDense.wi_1.weight', 'encoder.block.0.adapter.DenseReluDense.wo.weight', 'encoder.block.2.adapter.layer_norm.weight', 'encoder.block.4.adapter_pooling.bias', 'encoder.block.5.adapter.DenseReluDense.wi_0.weight', 'encoder.block.7.adapter.layer_norm.weight', 'encoder.block.1.adapter_pooling.weight', 'encoder.block.2.adapter.DenseReluDense.wo.weight', 'encoder.block.7.adapter.DenseReluDense.wi_1.weight', 'encoder.block.5.adapter.DenseReluDense.wo.weight', 'encoder.block.7.adapter.DenseReluDense.wo.weight', 'encoder.block.7.adapter.DenseReluDense.wi_0.weight', 'encoder.block.5.adapter_pooling.weight', 'encoder.block.6.adapter_pooling.weight', 'encoder.block.2.adapter_pooling.weight', 'encoder.block.5.adapter_pooling.bias', 'encoder.block.4.adapter.DenseReluDense.wo.weight', 'encoder.block.3.adapter_pooling.weight', 'encoder.block.3.adapter.DenseReluDense.wi_1.weight', 'encoder.block.7.adapter_pooling.weight', 'encoder.block.1.adapter_pooling.bias', 'encoder.block.6.adapter.layer_norm.weight', 'encoder.block.0.adapter.DenseReluDense.wi_0.weight', 'encoder.block.4.adapter_pooling.weight', 'encoder.block.6.adapter.DenseReluDense.wo.weight', 'encoder.block.6.adapter_pooling.bias', 'encoder.block.4.adapter.layer_norm.weight', 'encoder.block.2.adapter.DenseReluDense.wi_0.weight', 'encoder.block.1.adapter.DenseReluDense.wi_1.weight', 'encoder.block.6.adapter.DenseReluDense.wi_0.weight', 'encoder.block.5.adapter.layer_norm.weight', 'encoder.block.2.adapter_pooling.bias', 'encoder.block.1.adapter.layer_norm.weight', 'encoder.block.7.adapter_pooling.bias', 'encoder.block.0.adapter_pooling.bias', 'encoder.block.4.adapter.DenseReluDense.wi_1.weight', 'encoder.block.3.adapter.layer_norm.weight', 'encoder.block.4.adapter.DenseReluDense.wi_0.weight', 'encoder.block.0.adapter_pooling.weight', 'encoder.block.1.adapter.DenseReluDense.wo.weight', 'encoder.block.3.adapter.DenseReluDense.wo.weight', 'encoder.block.0.adapter.layer_norm.weight', 'encoder.block.5.adapter.DenseReluDense.wi_1.weight', 'encoder.block.3.adapter.DenseReluDense.wi_0.weight', 'encoder.block.0.adapter.DenseReluDense.wi_1.weight', 'encoder.block.1.adapter.DenseReluDense.wi_0.weight']
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
0 | model | T5ForConditionalGeneration | 53.4 M
-----------------------------------------------------
1.6 M     Trainable params
51.8 M    Non-trainable params
53.4 M    Total params
213.437   Total estimated model params size (MB)
checkpoint path = outputs/baseline_2010/epoch=11-f1_score=0.236-em_score=0.088.ckpt
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': None, 'adapter_hidden_size': 128, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=128, adapter_list=None, check_validation_only=False, checkpoint_dir='outputs/baseline_2010', checkpoint_path='outputs/baseline_2010/epoch=11-f1_score=0.236-em_score=0.088.ckpt', dataset='templama', dataset_version='2010', early_stop_callback=False, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.003, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='padapter2', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=120, num_workers=4, opt_level='O1', output_dir='outputs/padapter2_2010', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2010', wandb_log=True, warmup_steps=0, weight_decay=0.0)
split is 0
Length of dataset retrieving is.. 2866
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 410
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: - 0.001 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: | 0.021 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: / 0.021 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: - 0.021 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: \ 0.021 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: | 0.021 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: / 0.021 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: - 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: \ 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: | 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: / 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: - 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb: \ 0.024 MB of 0.024 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced padapter2_2010: https://wandb.ai/tjung2/temporal_questions/runs/fmek5e5x
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220908_235953-fmek5e5x/logs
Traceback (most recent call last):
  File "run.py", line 219, in <module>
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
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 377, in validation_step
    preds = self._generative_step(batch)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 338, in _generative_step
    generated_ids = self.model.generate(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/autograd/grad_mode.py", line 28, in decorate_context
    return func(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/transformers/generation_utils.py", line 1054, in generate
    return self.beam_search(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/transformers/generation_utils.py", line 1791, in beam_search
    outputs = self(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Padapter2_T5.py", line 1709, in forward
    decoder_outputs = self.decoder(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1130, in __getattr__
    raise AttributeError("'{}' object has no attribute '{}'".format(
AttributeError: 'T5ForConditionalGeneration' object has no attribute 'decoder'
