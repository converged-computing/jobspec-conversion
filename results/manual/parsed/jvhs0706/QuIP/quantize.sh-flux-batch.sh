#!/bin/bash
#FLUX: --job-name=peachy-omelette-8822
#FLUX: -c=8
#FLUX: -t=179
#FLUX: --urgency=16

deactivate
module purge
module load gcc/9.3.0 python/3.10 arrow/11.0.0 nodejs cuda/11.7 cmake protobuf cudnn scipy-stack rust
source $HOME/Quantization_ENV/bin/activate
echo "The Python used is $(which python)"
TRANSFORMERS_CACHE=./model-storage CUDA_VISIBLE_DEVICES=0 python llama.py meta-llama/Llama-2-7b-hf c4 --wbits 4 --quant ldlq --incoh_processing #--groupsize 128
TRANSFORMERS_CACHE=./model-storage CUDA_VISIBLE_DEVICES=0 python llama.py meta-llama/Llama-2-7b-hf c4 --wbits 1 --quant gptq --groupsize 128
TRANSFORMERS_CACHE=./model-storage CUDA_VISIBLE_DEVICES=0 python llama.py meta-llama/Llama-2-7b-hf c4 --wbits 1 --quant gptq --incoh_processing --groupsize 128
