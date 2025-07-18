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
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.layer_norm.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.0.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.2.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.1.layer.0.layer_norm.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapters.1.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.2.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.2.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.0.layer.0.layer_norm.weight', 'kadapter.adapters.0.1.layer.1.layer_norm.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.0.layer.1.layer_norm.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.k.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.k.weight', 'kadapter.ff.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.0.layer.1.layer_norm.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.0.layer.1.DenseReluDense.wo.weight', 'kadapter.ff.bias', 'kadapter.adapters.0.0.layer.0.layer_norm.weight', 'kadapter.adapters.0.2.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.o.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.1.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.q.weight', 'kadapter.adapters.0.2.layer.1.layer_norm.weight', 'kadapter.adapters.0.0.layer.0.SelfAttention.o.weight', 'kadapter.adapters.1.2.layer.1.layer_norm.weight', 'kadapter.adapters.0.0.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.1.1.layer.1.layer_norm.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.2.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.0.1.layer.0.SelfAttention.q.weight', 'kadapter.adapters.1.0.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.0.layer.1.DenseReluDense.wo.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.v.weight', 'kadapter.adapters.0.1.layer.0.layer_norm.weight', 'kadapter.adapters.1.2.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapters.0.2.layer.0.layer_norm.weight', 'kadapter.adapters.0.2.layer.0.SelfAttention.v.weight', 'kadapter.adapters.1.2.layer.0.SelfAttention.k.weight', 'kadapter.adapters.1.2.layer.0.layer_norm.weight']
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
Validation sanity check: 100%|██████████| 2/2 [00:01<00:00,  1.19it/s]Traceback (most recent call last):
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
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 844, in run_train
    self.run_sanity_check(self.lightning_module)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 1112, in run_sanity_check
    self.run_evaluation()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 996, in run_evaluation
    self.evaluation_loop.on_evaluation_epoch_end()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/evaluation_loop.py", line 265, in on_evaluation_epoch_end
    model_hook_fx()
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 349, in on_validation_epoch_end
    wandb.log({"table_key": self.test_table})
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/wandb/sdk/lib/preinit.py", line 36, in preinit_wrapper
    raise wandb.Error(f"You must call wandb.init() before {name}()")
wandb.errors.Error: You must call wandb.init() before wandb.log()
