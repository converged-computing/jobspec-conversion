#!/bin/bash
#FLUX: --job-name=torch750
#FLUX: --queue=high
#FLUX: --urgency=16

module load Tensorflow-gpu/1.12.0-foss-2017a-Python-3.6.4
module load PyTorch/1.1.0-foss-2017a-Python-3.6.4-CUDA-9.0.176
module load scikit-learn/0.19.1-foss-2017a-Python-3.6.4
dataset_folder=/homedtic/lperez/UniParse/datasets/ud2.1/
train_file=$dataset_folder/en-ud-train.conllu
train_file=$dataset_folder/en-ud-train.conllu
dev_file=$dataset_folder/en-ud-dev.conllu
test_file=$dataset_folder/en-ud-test.conllu
results_folder=$(pwd)
output_file=$results_folder/output.out
logging_file=$results_folder/logging.log
model_file=$results_folder/model.model
vocab_file=$results_folder/vocab.pkl
do_training=True
big_dataset=False
only_words=False
hidden_dim=750
cd /homedtic/lperez/UniParse
python kiperwasser_main_pytorch.py --results_folder $results_folder \
                                   --logging_file $logging_file \
                                   --do_training $do_training \
                                   --train_file $train_file \
                                   --dev_file $dev_file \
                                   --test_file $test_file \
                                   --output_file $output_file \
                                   --model_file $model_file \
                                   --vocab_file $vocab_file \
                                   --big_dataset $big_dataset \
                                   --only_words $only_words \
                                   --hidden_dim $hidden_dim
