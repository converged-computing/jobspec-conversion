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
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:360: UserWarning: Checkpoint directory outputs/T5_small_templama(full)_lr.001_kadapters_parallel_prefixed exists and is not empty.
  rank_zero_warn(f"Checkpoint directory {dirpath} exists and is not empty.")
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-small-ssm and are newly initialized: ['encoder.kadapter.adapters.0.1.layer.0.layer_norm.weight', 'encoder.kadapter.adapters.0.0.layer.0.layer_norm.weight', 'encoder.kadapter.adapters.0.0.layer.0.SelfAttention.k.weight', 'encoder.kadapter.adapters.0.1.layer.0.SelfAttention.k.weight', 'encoder.kadapter.adapters.1.1.layer.0.SelfAttention.o.weight', 'encoder.kadapter.adapters.1.0.layer.0.SelfAttention.relative_attention_bias.weight', 'encoder.kadapter.adapters.1.1.layer.1.DenseReluDense.wo.weight', 'encoder.kadapter.adapters.0.2.layer.0.layer_norm.weight', 'encoder.kadapter.adapters.1.2.layer.0.SelfAttention.q.weight', 'encoder.kadapter.adapters.1.2.layer.1.layer_norm.weight', 'encoder.kadapter.adapters.1.0.layer.0.layer_norm.weight', 'encoder.kadapter.adapters.0.2.layer.0.SelfAttention.k.weight', 'encoder.kadapter.adapters.0.1.layer.1.DenseReluDense.wi_0.weight', 'encoder.kadapter.adapters.0.2.layer.1.DenseReluDense.wi_1.weight', 'encoder.kadapter.adapters.1.1.layer.1.layer_norm.weight', 'encoder.kadapter.year_embed.weight', 'encoder.kadapter.adapters.0.0.layer.0.SelfAttention.q.weight', 'encoder.kadapter.adapters.0.2.layer.0.SelfAttention.v.weight', 'encoder.kadapter.adapters.1.1.layer.1.DenseReluDense.wi_1.weight', 'encoder.kadapter.adapters.0.1.layer.1.layer_norm.weight', 'encoder.kadapter.adapters.1.2.layer.0.SelfAttention.v.weight', 'encoder.kadapter.adapters.0.0.layer.1.DenseReluDense.wi_1.weight', 'encoder.kadapter.adapters.0.0.layer.1.layer_norm.weight', 'encoder.kadapter.adapters.0.1.layer.0.SelfAttention.o.weight', 'encoder.kadapter.adapters.0.2.layer.1.layer_norm.weight', 'encoder.kadapter.adapters.1.2.layer.1.DenseReluDense.wo.weight', 'encoder.kadapter.adapters.1.0.layer.1.DenseReluDense.wi_1.weight', 'encoder.kadapter.adapters.1.2.layer.1.DenseReluDense.wi_0.weight', 'encoder.kadapter.adapters.1.1.layer.0.SelfAttention.v.weight', 'encoder.kadapter.adapters.0.1.layer.1.DenseReluDense.wi_1.weight', 'encoder.kadapter.adapters.1.1.layer.0.layer_norm.weight', 'encoder.kadapter.adapters.1.0.layer.0.SelfAttention.k.weight', 'encoder.kadapter.adapters.0.1.layer.0.SelfAttention.q.weight', 'encoder.kadapter.adapters.0.1.layer.1.DenseReluDense.wo.weight', 'encoder.kadapter.layer_norm.weight', 'encoder.kadapter.adapters.1.0.layer.1.DenseReluDense.wo.weight', 'encoder.kadapter.adapters.0.0.layer.0.SelfAttention.relative_attention_bias.weight', 'encoder.kadapter.adapters.0.0.layer.1.DenseReluDense.wo.weight', 'encoder.kadapter.adapters.0.1.layer.0.SelfAttention.v.weight', 'encoder.kadapter.adapters.0.0.layer.0.SelfAttention.o.weight', 'encoder.kadapter.adapters.1.0.layer.0.SelfAttention.v.weight', 'encoder.kadapter.adapters.1.1.layer.1.DenseReluDense.wi_0.weight', 'encoder.kadapter.adapters.0.2.layer.1.DenseReluDense.wo.weight', 'encoder.kadapter.adapters.1.2.layer.0.layer_norm.weight', 'encoder.kadapter.adapters.0.2.layer.0.SelfAttention.q.weight', 'encoder.kadapter.adapters.1.1.layer.0.SelfAttention.k.weight', 'encoder.kadapter.adapters.1.1.layer.0.SelfAttention.q.weight', 'encoder.kadapter.adapters.1.2.layer.0.SelfAttention.o.weight', 'encoder.kadapter.adapters.1.0.layer.1.DenseReluDense.wi_0.weight', 'encoder.kadapter.adapters.0.0.layer.1.DenseReluDense.wi_0.weight', 'encoder.kadapter.adapters.0.2.layer.0.SelfAttention.o.weight', 'encoder.kadapter.adapters.1.2.layer.1.DenseReluDense.wi_1.weight', 'encoder.kadapter.adapters.1.0.layer.0.SelfAttention.q.weight', 'encoder.kadapter.adapters.0.2.layer.1.DenseReluDense.wi_0.weight', 'encoder.kadapter.adapters.1.2.layer.0.SelfAttention.k.weight', 'encoder.kadapter.adapters.1.0.layer.1.layer_norm.weight', 'encoder.kadapter.adapters.1.0.layer.0.SelfAttention.o.weight', 'encoder.kadapter.adapters.0.0.layer.0.SelfAttention.v.weight']
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
41.6 M    Trainable params
49.5 M    Non-trainable params
91.1 M    Total params
364.496   Total estimated model params size (MB)
Namespace(accelerator='ddp', adam_epsilon=1e-08, check_validation_only=False, checkpoint_path='', dataset='templama', dataset_version='full', early_stop_callback=False, eval_batch_size=32, freeze_embeds=False, freeze_encoder=False, freeze_level=1, learning_rate=0.01, max_grad_norm=0.5, max_input_length=50, max_output_length=25, method='kadapter_soft', mode='pretrain', model_name_or_path='google/t5-small-ssm', n_gpu=1, n_test=-1, n_train=-1, n_val=-1, num_train_epochs=30, num_workers=4, opt_level='O1', output_dir='outputs/T5_small_templama(full)_lr.001_kadapters_parallel_prefixed', output_log=None, prefix=True, resume_from_checkpoint=None, seed=42, split=0, split_num=1, tokenizer_name_or_path='google/t5-small-ssm', train_batch_size=32, use_deepspeed=False, use_lr_scheduling=True, val_check_interval=1.0, wandb_log=False, warmup_steps=0, weight_decay=0.0)
split is 0
Length of dataset retrieving is.. 35226
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 5037
Validation sanity check:   0%|          | 0/2 [00:00<?, ?it/s]BaseModelOutputWithPastAndCrossAttentions(last_hidden_state=tensor([[[ 9.7558e-02, -2.5035e-01,  2.0037e-01,  ..., -4.6349e-02,
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
        [[ 1.1012e-01, -2.6140e-01,  2.0860e-01,  ..., -4.1010e-02,
           4.4636e-02,  1.2069e-01],
         [ 3.2074e-02,  3.2712e-02,  2.8782e-01,  ..., -8.4291e-02,
          -1.6629e-04,  6.6407e-02],
         [ 6.6604e-02, -2.7917e-01,  1.1836e-01,  ..., -5.2783e-02,
           2.0550e-01, -2.7445e-01],
         ...,
         [ 1.0197e-01, -6.2507e-02,  3.1367e-01,  ..., -1.6496e-02,
          -1.4043e-01,  3.1744e-03],
         [ 1.1226e-01, -5.4352e-02,  3.1635e-01,  ..., -1.5018e-02,
          -1.3719e-01,  1.2029e-02],
         [ 8.8930e-02, -1.1984e-01,  3.3359e-01,  ..., -4.0818e-02,
          -9.7565e-02,  2.1386e-02]],
        [[ 6.1322e-02, -2.3150e-01,  1.5637e-01,  ..., -7.9485e-02,
           1.7627e-03,  1.2614e-01],
         [ 1.1022e-01,  2.3010e-02,  1.6280e-01,  ...,  2.4941e-02,
           2.9606e-02,  3.0512e-02],
         [ 1.7387e-02, -1.6161e-01,  1.5291e-01,  ...,  4.7015e-02,
          -2.2000e-02,  8.6250e-02],
         ...,
         [ 1.2843e-01, -2.8607e-02,  3.5665e-01,  ..., -1.8366e-02,
          -1.7350e-01,  3.6228e-02],
         [ 1.2129e-01, -3.7773e-02,  3.4965e-01,  ..., -5.4450e-03,
          -1.6294e-01,  2.7085e-02],
         [ 1.2782e-01, -2.0209e-02,  3.4336e-01,  ..., -1.0749e-02,
          -1.6790e-01,  3.4486e-02]],
        ...,
        [[ 4.3903e-02, -1.9870e-01,  1.2236e-01,  ...,  4.8349e-02,
          -3.2332e-02, -1.4852e-02],
         [ 1.2000e-01,  5.7676e-02,  3.2977e-01,  ...,  1.3239e-01,
           1.5468e-01, -2.5871e-02],
         [-1.1175e-01, -2.6126e-01,  2.1400e-01,  ..., -8.7856e-02,
           2.5169e-02, -1.8079e-01],
         ...,
         [ 4.5230e-03,  1.2821e-01,  1.2217e-01,  ...,  6.7070e-02,
           9.2298e-02, -8.5316e-03],
         [ 5.0015e-03,  1.4046e-01,  1.1006e-01,  ...,  3.9901e-02,
           7.2351e-02, -2.4694e-02],
         [-1.7232e-02,  1.4073e-01,  1.0637e-01,  ...,  5.1043e-02,
           1.0214e-01, -2.2478e-02]],
        [[ 4.0443e-02, -1.8757e-01,  1.3380e-01,  ...,  2.4571e-02,
          -1.0782e-02, -2.1078e-02],
         [ 1.1511e-01,  3.3559e-02,  3.7269e-01,  ...,  1.0951e-01,
           1.0966e-01, -1.7842e-02],
         [-1.2423e-01, -2.5606e-01,  2.0274e-01,  ..., -7.7286e-02,
           3.3107e-02, -1.7329e-01],
         ...,
         [-3.8767e-02,  1.2780e-01,  1.5270e-01,  ...,  5.8312e-02,
           1.4519e-01,  4.9213e-03],
         [-2.7662e-02,  1.3242e-01,  1.3274e-01,  ...,  2.9258e-02,
           1.2208e-01, -1.6092e-02],
         [-4.8526e-02,  1.3118e-01,  1.3125e-01,  ...,  5.1105e-02,
           1.4982e-01, -1.7858e-02]],
        [[-3.0969e-02, -1.5677e-01,  8.7782e-02,  ..., -4.7956e-02,
          -8.1029e-02, -7.0595e-03],
         [ 1.5178e-01, -2.9030e-02,  1.4650e-01,  ..., -2.9822e-02,
           1.7083e-01, -5.3200e-02],
         [-1.1961e-02, -2.3878e-01,  2.5801e-03,  ..., -1.1111e-01,
          -1.1994e-01,  7.3594e-02],
         ...,
         [ 3.6733e-02,  9.8581e-02,  1.5291e-01,  ...,  4.1106e-02,
           5.7754e-02, -5.8642e-02],
         [ 1.8721e-02,  1.0572e-01,  1.5511e-01,  ...,  4.3350e-02,
           7.0884e-02, -3.0606e-02],
         [ 3.8355e-03,  1.0952e-01,  1.5624e-01,  ...,  1.9070e-02,
           5.3935e-02, -5.9933e-02]]], device='cuda:0'), past_key_values=None, hidden_states=None, attentions=None, cross_attentions=None)
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
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/T5_Model.py", line 306, in _generative_step
    generated_ids = self.model.generate(
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/autograd/grad_mode.py", line 28, in decorate_context
    return func(*args, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/transformers/generation_utils.py", line 907, in generate
    model_kwargs = self._prepare_encoder_decoder_kwargs_for_generation(input_ids, model_kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/transformers/generation_utils.py", line 416, in _prepare_encoder_decoder_kwargs_for_generation
    model_kwargs["encoder_outputs"]: ModelOutput = encoder(input_ids, return_dict=True, **encoder_kwargs)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5_soft.py", line 1101, in forward
    hidden_states = self.kadapter(encoder_outputs, year)
  File "/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1051, in _call_impl
    return forward_call(*input, **kwargs)
  File "/mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/models/Kadapter_T5_soft.py", line 1792, in forward
    pretrained_hidden_state = hidden_states[self.adapter_list[i]]
TypeError: 'NoneType' object is not subscriptable
