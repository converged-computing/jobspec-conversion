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
0 | model | T5ForConditionalGeneration | 77.0 M
-----------------------------------------------------
77.0 M    Trainable params
0         Non-trainable params
77.0 M    Total params
307.845   Total estimated model params size (MB)
Namespace(accelerator='ddp', adam_epsilon=1e-08, adapter_config={'adapter_list': None, 'adapter_hidden_size': None, 'adapter_enc_dec': None, 'pool_size': None}, adapter_enc_dec=None, adapter_hidden_size=None, adapter_list=None, check_validation_only=False, checkpoint_dir=None, checkpoint_path='', dataset='wmt', dataset_version='2010', early_stop_callback=False, eval_batch_size=64, freeze_embeds=False, freeze_encoder=False, freeze_level=0, learning_rate=0.0001, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='baseline', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/wmtbaseline_2010', output_log=None, pool_size=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, t5_learning_rate=None, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=64, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, val_data='2010', wandb_log=False, warmup_steps=0, weight_decay=0.0)
Not freezing any parameters!
split is 0
Length of dataset retrieving is.. 2136160
Validation sanity check: 0it [00:00, ?it/s]split is 0
Traceback (most recent call last):
  File "run.py", line 222, in <module>
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
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 457, in val_dataloader
    validation_dataset = self.get_dataset(tokenizer=self.tokenizer, type_path="validation", num_samples=n_samples, args=self.hparams)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 256, in get_dataset
    dataset = Pretrain(tokenizer=tokenizer, type_path=type_path, num_samples=num_samples,  input_length=args.max_input_length, 
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/Datasets.py", line 92, in __init__
    self.dataset = pd.read_csv(f'data/wmt/wmt_val_{dataset_version}.csv') 
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
FileNotFoundError: [Errno 2] No such file or directory: 'data/wmt/wmt_val_2010.csv'
