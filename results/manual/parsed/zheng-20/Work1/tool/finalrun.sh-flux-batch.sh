#!/bin/bash
#FLUX: --job-name=goodbye-kerfuffle-7804
#FLUX: --priority=16

export PYTHONPATH='./'

module load anaconda/2021.11
source activate pt
 #python程序运行，需在.py文件指定调用GPU，并设置合适的线程数，batch_size大小等
export PYTHONPATH=./
PYTHON=python
TRAIN_CODE=final.py
dataset=abc
exp_name=7input_pretrained
exp_dir=exp/final/${exp_name}
model_dir=${exp_dir}/model
config=config/abc/final.yaml
mkdir -p ${model_dir}
cp tool/run.sh model/pointtransformer/pointtransformer.py tool/${TRAIN_CODE} ${config} ${exp_dir}
$PYTHON ${exp_dir}/${TRAIN_CODE} \
  --config=${config} \
  save_path ${exp_dir}
