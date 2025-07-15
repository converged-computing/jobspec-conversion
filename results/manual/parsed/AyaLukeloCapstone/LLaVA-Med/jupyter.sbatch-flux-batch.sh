#!/bin/bash
#FLUX: --job-name=7B_wz
#FLUX: -t=172799
#FLUX: --priority=16

export TRANSFORMERS_CACHE='/scratch/ltl2113/huggingface_cache'

module purge
source ~/miniconda3/etc/profile.d/conda.sh
conda activate llava-med
pip install llama-recipes transformers datasets accelerate sentencepiece protobuf==3.20 py7zr scipy peft bitsandbytes fire torch_tb_profiler ipywidgets
export TRANSFORMERS_CACHE="/scratch/ltl2113/huggingface_cache"
TRANSFORM=$(python -c "import transformers;print('/'.join(transformers.__file__.split('/')[:-1])+'/models/llama/convert_llama_weights_to_hf.py')")
model_dir='/scratch/ltl2113/LLaVA-Med/data/Llama-2-7b'
model_size='7B'
hf_model_dir='/scratch/ltl2113/LLaVA-Med/data/hf_model'
python $TRANSFORM --input_dir $model_dir --model_size $model_size --output_dir $hf_model_dir
python3 -u -m llava.model.apply_delta \
    --base $hf_model_dir \
    --target /scratch/ltl2113/LLaVA-Med/model \
    --delta liuhaotian/LLaVA-7b-delta-v0
