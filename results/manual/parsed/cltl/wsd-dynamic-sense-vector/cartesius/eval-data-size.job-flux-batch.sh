#!/bin/bash
#FLUX: --job-name=fugly-taco-0279
#FLUX: --queue=gpu
#FLUX: -t=432000
#FLUX: --urgency=16

module load cuda/8.0.61
module load cudnn/8.0-v6.0
echo -n 'Started: ' && date
percent=$1
preprocess_version="2017-11-24-a74bda6"
vocab_path=preprocessed-data/$preprocess_version/gigaword-for-lstm-wsd.index.pkl
model_version="2017-11-24-4e4a04a"
model_path=output/$model_version/lstm-wsd-gigaword_${percent}-pc_large-best-model
base_dir=output/`python3 version.py`
mkdir $base_dir 
base_path=$base_dir/lstm-wsd-gigaword_${percent}-pc_large
cd evaluate && \
./evaluate.job ../$model_path ../$vocab_path ../$base_path.results-with-mfs True && \
./evaluate.job ../$model_path ../$vocab_path ../$base_path.results-without-mfs False && \
echo "Output written to $base_path.results-with-mfs" && \
echo "... and $base_path.results-without-mfs"
