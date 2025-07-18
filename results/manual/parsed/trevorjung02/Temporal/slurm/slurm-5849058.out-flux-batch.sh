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
python run.py --config configs/templama/training/t5_baseline_2010.json
--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
Not freezing any parameters!
split is 0
Length of dataset retrieving is.. 2866
wandb: wandb version 0.13.1 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.12.21
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220810_235241-28q8wtax
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run T5_small_templama(2010)_lr.001_baseline
wandb: ⭐️ View project at https://wandb.ai/tjung2/continual_learning_3
wandb: 🚀 View run at https://wandb.ai/tjung2/continual_learning_3/runs/28q8wtax
Set SLURM handle signals.
  | Name  | Type                       | Params
-----------------------------------------------------
0 | model | T5ForConditionalGeneration | 77.0 M
-----------------------------------------------------
77.0 M    Trainable params
0         Non-trainable params
77.0 M    Total params
307.845   Total estimated model params size (MB)
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 410
Validation sanity check:   0% 0/2 [00:00<?, ?it/s]preds ["St. Mary's College", 'National Assembly of Pakistan', 'Ssei', 'House of Representatives of Japan', 'Notre Dame']
targets ['University of Washington School of Law;University of Washington College of Education', 'Siumut', 'Minister for Foreign Affairs;Minister of Land, Infrastructure, Transport and Tourism', 'Democratic Party', 'INSEP']
Traceback (most recent call last):
  File "run.py", line 155, in <module>
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
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 346, in validation_step
    return self._generative_step(batch, batch_idx)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 322, in _generative_step
    elif self.hparams.dataset == 'fever' or self.hparams.dataset == 'AY2' or self.args.dataset== 'TREX' or self.args.dataset== 'zsRE':
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1130, in __getattr__
    raise AttributeError("'{}' object has no attribute '{}'".format(
AttributeError: 'T5' object has no attribute 'args'
wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: \ 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: | 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: / 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb: - 0.008 MB of 0.008 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced T5_small_templama(2010)_lr.001_baseline: https://wandb.ai/tjung2/continual_learning_3/runs/28q8wtax
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220810_235241-28q8wtax/logs
