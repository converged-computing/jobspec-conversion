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
python run.py --config configs/templama/training/t5_padapters_yearly_2freeze.json
--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.2 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220902_045342-2ljtpfkj
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run padapter_2010
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/2ljtpfkj
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['enc_kadapter.pool.weight', 'enc_kadapter.adapter.2.up_project.weight', 'enc_kadapter.adapter.1.up_project.weight', 'enc_kadapter.adapter.0.down_project.weight', 'enc_kadapter.adapter.0.down_project.bias', 'enc_kadapter.layer_norm.weight', 'enc_kadapter.adapter.2.down_project.weight', 'enc_kadapter.adapter.2.down_project.bias', 'enc_kadapter.adapter.1.up_project.bias', 'enc_kadapter.adapter.0.up_project.weight', 'enc_kadapter.pool.bias', 'enc_kadapter.adapter.1.down_project.bias', 'enc_kadapter.adapter.2.up_project.bias', 'enc_kadapter.adapter.1.down_project.weight', 'enc_kadapter.adapter.0.up_project.bias']
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
0 | model | T5ForConditionalGeneration | 80.1 M
-----------------------------------------------------
3.2 M     Trainable params
77.0 M    Non-trainable params
80.1 M    Total params
320.448   Total estimated model params size (MB)
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': [1, 5, 8], 'adapter_hidden_size': 1024, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=1024, adapter_list=[1, 5, 8], check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='templama', dataset_version='2010', early_stop_callback=False, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.003, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='padapter', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=120, num_workers=4, opt_level='O1', output_dir='outputs/padapter_2010', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, wandb_log=True, warmup_steps=0, weight_decay=0.0)
T5Config {
  "_name_or_path": "google/t5-small-ssm",
  "adapter_enc_dec": null,
  "adapter_hidden_size": 1024,
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
  "pool_size": null,
  "relative_attention_num_buckets": 32,
  "tie_word_embeddings": false,
  "transformers_version": "4.12.3",
  "use_cache": false,
  "vocab_size": 32128
}
split is 0
Length of dataset retrieving is.. 2866
Validation sanity check: 0it [00:00, ?it/s]split is 0
wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb: - 0.009 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb: \ 0.016 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb: | 0.016 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb: / 0.016 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb: - 0.016 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb: \ 0.016 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb: | 0.016 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb: / 0.016 MB of 0.016 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced padapter_2010: https://wandb.ai/tjung2/temporal_questions/runs/2ljtpfkj
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220902_045342-2ljtpfkj/logs
Traceback (most recent call last):
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/utilities/parsing.py", line 250, in __getattr__
    return self[key]
KeyError: 'val_data'
The above exception was the direct cause of the following exception:
Traceback (most recent call last):
  File "run.py", line 213, in <module>
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
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 925, in run_evaluation
    dataloaders, max_batches = self.evaluation_loop.get_evaluation_dataloaders()
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/evaluation_loop.py", line 63, in get_evaluation_dataloaders
    self.trainer.reset_val_dataloader(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/data_loading.py", line 409, in reset_val_dataloader
    self.num_val_batches, self.val_dataloaders = self._reset_eval_dataloader(model, 'val')
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/data_loading.py", line 318, in _reset_eval_dataloader
    dataloaders = self.request_dataloader(model, mode)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/data_loading.py", line 442, in request_dataloader
    dataloader: DataLoader = getattr(model, f'{stage}_dataloader')()
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 449, in val_dataloader
    validation_dataset = self.get_dataset(tokenizer=self.tokenizer, type_path="validation", num_samples=n_samples, args=self.hparams)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 248, in get_dataset
    dataset = Pretrain(tokenizer=tokenizer, type_path=type_path, num_samples=num_samples,  input_length=args.max_input_length,
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/Datasets.py", line 72, in __init__
    if self.args.val_data is not None:
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/utilities/parsing.py", line 252, in __getattr__
    raise AttributeError(f'Missing attribute "{key}"') from exp
AttributeError: Missing attribute "val_data"
