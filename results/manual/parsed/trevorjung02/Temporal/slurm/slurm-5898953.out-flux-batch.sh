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
python run.py --config configs/templama/training/t5_kadapters_2010_prefixed.json
--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/T5_small_templama(2010)_lr.001_adapters_prefixed exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['kadapter.adapter.1.layer.0.layer_norm.weight', 'kadapter.adapter.0.layer.0.SelfAttention.v.weight', 'kadapter.adapter.1.layer.0.SelfAttention.k.weight', 'kadapter.adapter.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapter.1.layer.0.SelfAttention.q.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.0.layer.0.SelfAttention.k.weight', 'kadapter.adapter.0.layer.1.layer_norm.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi_1.weight', 'kadapter.adapter.0.layer.0.layer_norm.weight', 'kadapter.adapter.0.layer.0.SelfAttention.q.weight', 'kadapter.adapter.1.layer.0.SelfAttention.v.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi_0.weight', 'kadapter.layer_norm.weight', 'kadapter.adapter.1.layer.0.SelfAttention.o.weight', 'kadapter.adapter.1.layer.1.layer_norm.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi_0.weight', 'kadapter.adapter.0.layer.0.SelfAttention.o.weight']
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
0 | model | T5ForConditionalGeneration | 81.7 M
-----------------------------------------------------
4.7 M     Trainable params
77.0 M    Non-trainable params
81.7 M    Total params
326.730   Total estimated model params size (MB)
Namespace(accelerator='ddp', adam_epsilon=1e-08, check_validation_only=False, checkpoint_path='', dataset='templama', dataset_version='2010', early_stop_callback=False, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=2, learning_rate=0.1, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/T5_small_templama(2010)_lr.001_adapters_prefixed', output_log=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, wandb_log=False, warmup_steps=0, weight_decay=0.0)
config.num_layers = 8
config.num_layers = 8
split is 0
Length of dataset retrieving is.. 2866
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 410
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]output_hidden_states = False
output_hidden_states = True
i = 0, hidden_states size = torch.Size([32, 50, 512])
i = 0, hidden_states size = torch.Size([32, 50, 512])
i = 1, hidden_states size = torch.Size([32, 50, 512])
i = 1, hidden_states size = torch.Size([32, 50, 512])
i = 2, hidden_states size = torch.Size([32, 50, 512])
i = 2, hidden_states size = torch.Size([32, 50, 512])
i = 3, hidden_states size = torch.Size([32, 50, 512])
i = 3, hidden_states size = torch.Size([32, 50, 512])
i = 4, hidden_states size = torch.Size([32, 50, 512])
i = 4, hidden_states size = torch.Size([32, 50, 512])
i = 5, hidden_states size = torch.Size([32, 50, 512])
i = 5, hidden_states size = torch.Size([32, 50, 512])
i = 6, hidden_states size = torch.Size([32, 50, 512])
i = 6, hidden_states size = torch.Size([32, 50, 512])
i = 7, hidden_states size = torch.Size([32, 50, 512])
i = 7, hidden_states size = torch.Size([32, 50, 512])
hidden_states size = torch.Size([32, 50, 512])
encoder_outputs are None = False
last_hidden_state = tensor([[[ 9.7558e-02, -2.5035e-01,  2.0037e-01,  ..., -4.6349e-02,
           3.1209e-02,  1.3815e-01],
         [ 1.1342e-02,  7.6886e-03,  1.0924e-01,  ..., -1.4596e-01,
           8.0698e-03,  4.0887e-02],
         [ 6.5895e-02, -2.8374e-01,  1.0504e-01,  ..., -3.7779e-02,
           2.0632e-01, -2.6836e-01],
         ...,
         [ 9.1724e-02, -6.4078e-02,  3.1343e-01,  ..., -1.8335e-03,
          -1.4536e-01,  1.5180e-02],
         [ 1.0187e-01, -5.6857e-02,  3.1535e-01,  ...,  5.4652e-04,
          -1.4281e-01,  2.5087e-02],
         [ 8.8810e-02, -1.1717e-01,  3.3323e-01,  ..., -2.0132e-02,
          -9.9177e-02,  3.6396e-02]],
        [[ 9.7558e-02, -2.5035e-01,  2.0037e-01,  ..., -4.6349e-02,
           3.1209e-02,  1.3815e-01],
         [ 1.1342e-02,  7.6886e-03,  1.0924e-01,  ..., -1.4596e-01,
           8.0698e-03,  4.0887e-02],
         [ 6.5895e-02, -2.8374e-01,  1.0504e-01,  ..., -3.7779e-02,
           2.0632e-01, -2.6836e-01],
         ...,
         [ 9.1724e-02, -6.4078e-02,  3.1343e-01,  ..., -1.8335e-03,
          -1.4536e-01,  1.5180e-02],
         [ 1.0187e-01, -5.6857e-02,  3.1535e-01,  ...,  5.4652e-04,
          -1.4281e-01,  2.5087e-02],
         [ 8.8810e-02, -1.1717e-01,  3.3323e-01,  ..., -2.0132e-02,
          -9.9177e-02,  3.6396e-02]],
        [[ 3.4918e-02, -1.8451e-01,  1.0227e-01,  ...,  6.6409e-02,
          -5.7116e-02,  1.5346e-03],
         [-9.8693e-03,  2.6510e-02,  1.4532e-01,  ..., -1.0365e-03,
          -2.9635e-02, -2.4314e-02],
         [ 8.1717e-03, -1.7127e-01,  2.6586e-01,  ...,  3.8682e-02,
           8.6241e-02, -2.3119e-01],
         ...,
         [-4.6509e-02, -8.7623e-02, -7.7191e-02,  ...,  1.4618e-01,
           3.2222e-02,  6.3243e-02],
         [ 1.7365e-02, -9.2976e-02, -8.7583e-02,  ...,  2.0634e-01,
           3.0816e-02,  7.2429e-02],
         [-4.4206e-02, -8.3237e-02, -8.7031e-02,  ...,  2.0128e-01,
          -5.4339e-03,  5.1337e-02]],
        ...,
        [[ 4.1461e-02, -2.3062e-01,  1.4030e-01,  ...,  3.9117e-02,
           8.0473e-02, -4.0550e-02],
         [ 2.8080e-02,  6.2212e-02,  1.0014e-01,  ..., -4.9993e-02,
           3.5224e-02,  1.3274e-03],
         [-4.7108e-03, -1.9315e-01,  7.3718e-02,  ..., -1.3822e-01,
          -1.0156e-01, -2.4319e-01],
         ...,
         [ 1.5650e-01, -4.6298e-02,  1.2935e-01,  ..., -1.7920e-01,
          -4.8330e-02, -1.7780e-01],
         [ 1.4684e-01, -3.6660e-02,  1.3812e-01,  ..., -1.6102e-01,
          -3.5572e-02, -1.7293e-01],
         [ 1.5821e-01, -1.5442e-02,  1.2402e-01,  ..., -1.5847e-01,
          -3.9889e-02, -1.5849e-01]],
        [[-5.4919e-02, -2.0765e-01,  1.1168e-01,  ..., -7.5966e-03,
           2.6684e-02, -1.3542e-01],
         [ 1.2203e-01, -1.7974e-02,  2.2193e-02,  ..., -1.1589e-02,
          -7.1121e-03, -2.0653e-01],
         [-8.3475e-02, -7.4703e-02,  7.5080e-02,  ...,  2.7939e-02,
           5.9308e-02, -5.6672e-02],
         ...,
         [-5.7866e-05, -5.5752e-03,  6.4749e-03,  ..., -5.7553e-03,
           4.6426e-03,  8.0341e-02],
         [-2.6292e-03, -1.3815e-02,  1.9409e-02,  ..., -1.6243e-02,
           1.6529e-02,  6.5747e-02],
         [-8.0499e-04, -9.6827e-03,  1.3452e-02,  ..., -1.1305e-02,
           1.1351e-02,  7.2100e-02]],
        [[-5.4919e-02, -2.0765e-01,  1.1168e-01,  ..., -7.5966e-03,
           2.6684e-02, -1.3542e-01],
         [ 1.2203e-01, -1.7974e-02,  2.2193e-02,  ..., -1.1589e-02,
          -7.1121e-03, -2.0653e-01],
         [-8.3475e-02, -7.4703e-02,  7.5080e-02,  ...,  2.7939e-02,
           5.9308e-02, -5.6672e-02],
         ...,
         [-5.7866e-05, -5.5752e-03,  6.4749e-03,  ..., -5.7553e-03,
           4.6426e-03,  8.0341e-02],
         [-2.6292e-03, -1.3815e-02,  1.9409e-02,  ..., -1.6243e-02,
           1.6529e-02,  6.5747e-02],
         [-8.0499e-04, -9.6827e-03,  1.3452e-02,  ..., -1.1305e-02,
           1.1351e-02,  7.2100e-02]]], device='cuda:0')
Adapter forward()
sequence_output size = torch.Size([64, 50, 512])
hidden_states length = 9
hidden_states[1] size = torch.Size([32, 50, 512])
Traceback (most recent call last):
  File "run.py", line 165, in <module>
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
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 356, in validation_step
    preds = self._generative_step(batch)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 317, in _generative_step
    generated_ids = self.model.generate(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/autograd/grad_mode.py", line 28, in decorate_context
    return func(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/transformers/generation_utils.py", line 1054, in generate
    return self.beam_search(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/transformers/generation_utils.py", line 1791, in beam_search
    outputs = self(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5.py", line 1592, in forward
    hidden_states = self.kadapter(encoder_outputs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5.py", line 1759, in forward
    fusion_state = pretrained_hidden_state + hidden_states_last
RuntimeError: The size of tensor a (32) must match the size of tensor b (64) at non-singleton dimension 0
