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
python run.py --config configs/templama/training/t5_kadapters_2010.json
--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapter.0.layer.0.SelfAttention.q.weight', 'kadapter.adapter.0.layer.0.SelfAttention.o.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.1.layer.0.SelfAttention.o.weight', 'kadapter.adapter.1.layer.1.layer_norm.weight', 'kadapter.adapter.1.layer.0.SelfAttention.k.weight', 'kadapter.adapter.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapter.0.layer.0.SelfAttention.k.weight', 'kadapter.adapter.0.layer.0.layer_norm.weight', 'kadapter.adapter.1.layer.0.layer_norm.weight', 'kadapter.adapter.1.layer.0.SelfAttention.v.weight', 'kadapter.adapter.1.layer.0.SelfAttention.q.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.layer_norm.weight', 'kadapter.adapter.0.layer.0.SelfAttention.v.weight', 'kadapter.adapter.0.layer.1.layer_norm.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wo.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
split is 0
Length of dataset retrieving is.. 2866
wandb: Network error (ReadTimeout), entering retry loop.
wandb: ERROR Error while calling W&B API: internal database error (<Response [500]>)
wandb: ERROR Error communicating with wandb process
wandb: ERROR try: wandb.init(settings=wandb.Settings(start_method='fork'))
wandb: ERROR or:  wandb.init(settings=wandb.Settings(start_method='thread'))
wandb: ERROR For more info see: https://docs.wandb.ai/library/init#init-start-error
Problem at: /mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/loggers/wandb.py 169 experiment
Traceback (most recent call last):
  File "run.py", line 162, in <module>
    trainer.fit(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 460, in fit
    self._run(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 755, in _run
    self.pre_dispatch()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 785, in pre_dispatch
    self.logger.log_hyperparams(self.lightning_module.hparams_initial)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/utilities/distributed.py", line 49, in wrapped_fn
    return fn(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/loggers/wandb.py", line 190, in log_hyperparams
    self.experiment.config.update(params, allow_val_change=True)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/loggers/base.py", line 41, in experiment
    return get_experiment() or DummyExperiment()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/utilities/distributed.py", line 49, in wrapped_fn
    return fn(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/loggers/base.py", line 39, in get_experiment
    return fn(self)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/loggers/wandb.py", line 169, in experiment
    self._experiment = wandb.init(**self._wandb_init) if wandb.run is None else wandb.run
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/wandb/sdk/wandb_init.py", line 1043, in init
    run = wi.init()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/wandb/sdk/wandb_init.py", line 691, in init
    raise UsageError(error_message)
wandb.errors.UsageError: Error communicating with wandb process
try: wandb.init(settings=wandb.Settings(start_method='fork'))
or:  wandb.init(settings=wandb.Settings(start_method='thread'))
For more info see: https://docs.wandb.ai/library/init#init-start-error
