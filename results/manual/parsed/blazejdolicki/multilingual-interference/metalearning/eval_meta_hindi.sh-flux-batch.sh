#!/bin/bash
#FLUX: --job-name=meta_experiment
#FLUX: --queue=gpu_titanrtx_shared_course
#FLUX: -t=172740
#FLUX: --priority=16

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
source activate atcs-project
python metatest_all.py --validate True --lr_decoder 5e-04 --lr_bert 5e-05 --updates 20 --support_set_size 20 --optimizer sgd --model_dir logs/bert_finetune_hindi/2021.05.18_14.46.31/
