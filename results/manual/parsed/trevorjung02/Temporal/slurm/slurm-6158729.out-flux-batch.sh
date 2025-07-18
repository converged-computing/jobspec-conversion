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
python run.py --config configs/wmt/training/t5_baseline_yearly.json--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': None, 'adapter_hidden_size': None, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=None, adapter_list=None, check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='wmt', dataset_version='2010', early_stop_callback=False, eval_batch_size=64, freeze_embeds=False, freeze_encoder=False, freeze_level=0, learning_rate=0.0001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='baseline', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=2, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/wmtbaseline_2010', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=64, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2010', wandb_log=False, warmup_steps=0, weight_decay=0.0)
Not freezing any parameters!
Traceback (most recent call last):
  File "run.py", line 221, in <module>
    trainer = pl.Trainer(**train_params)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/connectors/env_vars_connector.py", line 40, in insert_env_defaults
    return fn(self, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 321, in __init__
    self.accelerator_connector = AcceleratorConnector(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/connectors/accelerator_connector.py", line 131, in __init__
    self.parallel_device_ids = device_parser.parse_gpu_ids(self.gpus)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/utilities/device_parser.py", line 87, in parse_gpu_ids
    gpus = _sanitize_gpu_ids(gpus)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/utilities/device_parser.py", line 154, in _sanitize_gpu_ids
    raise MisconfigurationException(
pytorch_lightning.utilities.exceptions.MisconfigurationException: You requested GPUs: [0, 1]
 But your machine only has: [0]
