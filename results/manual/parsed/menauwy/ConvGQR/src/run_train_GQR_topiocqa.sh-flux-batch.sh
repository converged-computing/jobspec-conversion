#!/bin/bash
#FLUX: --job-name=train_topiocqa
#FLUX: -c=20
#FLUX: --queue=amd-gpu-long
#FLUX: -t=604800
#FLUX: --priority=16

conda init bash
source ~/.bashrc
conda activate convgqr
echo $CONDA_DEFAULT_ENV
echo $PYTHONPATH
TEST_DIR=$(pwd)
echo "## Current dircectory $TEST_DIR"
echo "## Number of available CUDA devices: $CUDA_VISIBLE_DEVICES"
echo "## Checking status of CUDA device with nvidia-smi"
nvidia-smi
echo "## Running training script on topiocqa dataset!"
dataset_dir='/home/wangym/data1/dataset/'
model_dir='/home/wangym/data1/model/'
train_dataset='topiocqa'
train_file_path="${dataset_dir}${train_dataset}/train_new.json"
log_dir_path="${model_dir}convgqr/train_${train_dataset}"
model_output_path="${model_dir}convgqr/train_${train_dataset}"
decode_type='answer'
/data1/wangym/conda/envs/convgqr/bin/python train_GQR.py \
      --train_from_checkpoint \
      --pretrained_query_encoder="${model_dir}pretrained/t5-base" \
      --pretrained_passage_encoder="${model_dir}pretrained/ance-msmarco-passage" \
      --train_dataset=$train_dataset \
      --train_file_path=$train_file_path \
      --log_dir_path=$log_dir_path \
      --model_output_path=$model_output_path \
      --collate_fn_type="flat_concat_for_train" \
      --decode_type=$decode_type \
      --per_gpu_train_batch_size=8 \
      --num_train_epochs=15 \
      --max_query_length=32 \
      --max_doc_length=384 \
      --max_response_length=32 \
      --max_concat_length=512 \
      --alpha=0.5
echo "## Training Done!"
