#!/bin/bash
#FLUX: --job-name=seq2seq_SMILE_attention_fw_bw
#FLUX: -n=28
#FLUX: --queue=gpu              #Request the GPU partition/queue
#FLUX: -t=36000
#FLUX: --priority=16

module load Anaconda/3-5.0.0.1
source activate tensorflow-gpu-1.3.0
module load cuDNN/5.1-CUDA-8.0.44
python translate.py --data_dir ./data --train_dir ./check-point --en_vocab_size=100 --fr_vocab_size=100
source deactivate
