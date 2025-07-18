#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=8
#FLUX: --queue=gpu-a40
#FLUX: -t=3600
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/debug.json
--------------------
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
wandb: wandb version 0.13.4 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.13.1
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20221011_034540-2mfw7r73
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run baseline_debug
wandb: ⭐️ View project at https://wandb.ai/tjung2/temporal_questions
wandb: 🚀 View run at https://wandb.ai/tjung2/temporal_questions/runs/2mfw7r73
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': None, 'adapter_hidden_size': None, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=None, adapter_list=None, check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='templama', dataset_version='debug', early_stop_callback=False, eval_batch_size=1, find_lr=False, freeze_embeds=False, freeze_encoder=False, freeze_level=0, learning_rate=1e-05, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='baseline', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=60, num_workers=4, opt_level='O1', output_dir='outputs/debugbaseline_debug', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=1, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='debug', wandb_log=True, warmup_steps=0, weight_decay=0.0)
Not freezing any parameters!
hparams.learning_rate = 1e-05
split is 0
wandb: Waiting for W&B process to finish... (failed 1). Press Control-C to abort syncing.
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb: - 0.001 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb: \ 0.012 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb: | 0.012 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb: / 0.014 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb: - 0.014 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb: \ 0.014 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb: | 0.014 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb: / 0.014 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb: - 0.014 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb: \ 0.014 MB of 0.014 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced baseline_debug: https://wandb.ai/tjung2/temporal_questions/runs/2mfw7r73
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20221011_034540-2mfw7r73/logs
Traceback (most recent call last):
  File "run.py", line 254, in <module>
    trainer.fit(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 460, in fit
    self._run(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/trainer.py", line 717, in _run
    self.accelerator.setup(self, model)  # note: this sets up self.lightning_module
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/gpu.py", line 41, in setup
    return super().setup(trainer, model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/accelerator.py", line 92, in setup
    self.setup_optimizers(trainer)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/accelerators/accelerator.py", line 374, in setup_optimizers
    optimizers, lr_schedulers, optimizer_frequencies = self.training_type_plugin.init_optimizers(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/plugins/training_type/training_type_plugin.py", line 190, in init_optimizers
    return trainer.init_optimizers(model)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/trainer/optimizers.py", line 34, in init_optimizers
    optim_conf = model.configure_optimizers()
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 450, in configure_optimizers
    len_data = len(self.train_dataloader())
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 458, in train_dataloader
    train_dataset = self.get_dataset(tokenizer=self.tokenizer, type_path="train", num_samples=n_samples, args=self.hparams)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 256, in get_dataset
    dataset = Pretrain(tokenizer=tokenizer, type_path=type_path, num_samples=num_samples,  input_length=args.max_input_length,
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/Datasets.py", line 72, in __init__
    self.dataset= pd.read_csv(f'data/templama/templama_train_{self.dataset_version}_prefixed.csv')
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/util/_decorators.py", line 311, in wrapper
    return func(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/io/parsers/readers.py", line 680, in read_csv
    return _read(filepath_or_buffer, kwds)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/io/parsers/readers.py", line 575, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/io/parsers/readers.py", line 934, in __init__
    self._engine = self._make_engine(f, self.engine)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/io/parsers/readers.py", line 1218, in _make_engine
    self.handles = get_handle(  # type: ignore[call-overload]
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pandas/io/common.py", line 786, in get_handle
    handle = open(
FileNotFoundError: [Errno 2] No such file or directory: 'data/templama/templama_train_debug_prefixed.csv'
