#!/bin/bash
#FLUX: --job-name=faux-sundae-8641
#FLUX: --priority=16

clear
module use ~/environment-modules-lisa
module load 2020
module load TensorFlow/1.15.0-foss-2019b-Python-3.7.4-10.1.243
module list
python -u train_keras.py \
--trainfile train_COVIDx.txt \
--testfile test_COVIDx.txt \
--data_path /nfs/managed_datasets/COVID19/XRAY/covidx_dataset_ext \
--img_size 512 \
--lr 0.00002 \
--bs 16 \
--epochs 50 \
--name efficient-net-pararesent50-0.05- \
--model resnet50v2 \
--datapipeline EfficientNet \
