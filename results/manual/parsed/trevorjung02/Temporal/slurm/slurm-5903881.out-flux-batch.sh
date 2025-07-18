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
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapters.1.2.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.0.layer.1.DenseReluDense.wo.weight', 'kadapter.layer_norm.weight', 'kadapter.adapters.1.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.2.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.0.layer.1.layer_norm.weight', 'kadapter.adapters.1.1.layer.0.layer_norm.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.0.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.0.layer.0.layer_norm.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.0.layer.1.layer_norm.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.2.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.2.layer.1.layer_norm.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.1.layer.1.layer_norm.weight', 'kadapter.adapters.0.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.0.layer.0.layer_norm.weight', 'kadapter.adapters.1.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.0.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.1.layer.1.layer_norm.weight', 'kadapter.adapters.1.2.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.2.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.2.layer.0.layer_norm.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.0.2.layer.1.layer_norm.weight', 'kadapter.adapters.1.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.0.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.2.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.2.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.2.layer.0.layer_norm.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.k.weight', 'kadapter.year_embed.weight', 'kadapter.adapters.0.1.layer.0.layer_norm.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.o.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, check_validation_only=False, checkpoint_path='', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/T5_small_templama(full)_lr.001_kadapters_parallel_prefixed', output_log=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, wandb_log=False, warmup_steps=0, weight_decay=0.0)
split is 0
Length of dataset retrieving is.. 35226
Traceback (most recent call last):
  File "run.py", line 165, in <module>
    trainer.fit(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 460, in fit
    self._run(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 755, in _run
    self.pre_dispatch()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 780, in pre_dispatch
    self.accelerator.pre_dispatch(self)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/accelerator.py", line 108, in pre_dispatch
    self.training_type_plugin.pre_dispatch()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/plugins/training_type/ddp.py", line 290, in pre_dispatch
    self.configure_ddp()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/plugins/training_type/ddp.py", line 254, in configure_ddp
    self._model = DistributedDataParallel(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/parallel/distributed.py", line 393, in __init__
    assert any((p.requires_grad for p in module.parameters())), (
AssertionError: DistributedDataParallel is not needed when a module doesn't have any parameter that requires a gradient.
