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
python run.py --config configs/templama/evaluation/t5_kadapters_large.json
--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-large-ssm and are newly initialized: ['kadapter.adapter.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapter.1.layer.0.SelfAttention.q.weight', 'kadapter.adapter.0.layer.1.layer_norm.weight', 'kadapter.adapter.1.layer.0.layer_norm.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi.weight', 'kadapter.adapter.1.layer.0.SelfAttention.o.weight', 'kadapter.adapter.0.layer.0.SelfAttention.v.weight', 'kadapter.adapter.0.layer.0.SelfAttention.k.weight', 'kadapter.layer_norm.weight', 'kadapter.adapter.0.layer.0.SelfAttention.o.weight', 'kadapter.adapter.0.layer.0.SelfAttention.q.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi.weight', 'kadapter.adapter.1.layer.0.SelfAttention.v.weight', 'kadapter.adapter.1.layer.1.layer_norm.weight', 'kadapter.adapter.1.layer.0.SelfAttention.k.weight', 'kadapter.adapter.0.layer.0.layer_norm.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Some weights of T5ForConditionalGeneration were not initialized from the model checkpoint at google/t5-large-ssm and are newly initialized: ['kadapter.adapter.0.layer.0.SelfAttention.relative_attention_bias.weight', 'kadapter.adapter.1.layer.0.SelfAttention.q.weight', 'kadapter.adapter.0.layer.1.layer_norm.weight', 'kadapter.adapter.1.layer.0.layer_norm.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.1.layer.1.DenseReluDense.wi.weight', 'kadapter.adapter.1.layer.0.SelfAttention.o.weight', 'kadapter.adapter.0.layer.0.SelfAttention.v.weight', 'kadapter.adapter.0.layer.0.SelfAttention.k.weight', 'kadapter.layer_norm.weight', 'kadapter.adapter.0.layer.0.SelfAttention.o.weight', 'kadapter.adapter.0.layer.0.SelfAttention.q.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wo.weight', 'kadapter.adapter.0.layer.1.DenseReluDense.wi.weight', 'kadapter.adapter.1.layer.0.SelfAttention.v.weight', 'kadapter.adapter.1.layer.1.layer_norm.weight', 'kadapter.adapter.1.layer.0.SelfAttention.k.weight', 'kadapter.adapter.0.layer.0.layer_norm.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Not freezing any parameters!
Not freezing any parameters!
split is 0
Length of dataset retrieving is.. 376
Length of validation data:  376
log/templama folder already exists.
Number of total validation data: 376
Number of correct predictions: 4. Percentage : 0.010638297872340425
