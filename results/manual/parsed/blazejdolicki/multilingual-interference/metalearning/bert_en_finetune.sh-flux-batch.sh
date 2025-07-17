#!/bin/bash
#FLUX: --job-name=ConcatTreebanks
#FLUX: --queue=gpu_titanrtx_shared_course
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
source activate atcs-project
python train.py --config config/ud/en/udify_bert_finetune_en_ewt.json --name bert_finetune_en
