#!/bin/bash
#FLUX: --job-name=7B_wz
#FLUX: --queue=nvidia
#FLUX: -t=172799
#FLUX: --urgency=16

export HF_HOME='/scratch/ltl2113/huggingface_cache'

module purge
source ~/miniconda3/etc/profile.d/conda.sh
conda activate llava-med
export HF_HOME="/scratch/ltl2113/huggingface_cache"
python -u -m llava.serve.controller --host 0.0.0.0 --port 10000 &
sleep 10
 python3 -u -m llava.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40000 --worker http://localhost:40000 --model-path /scratch/ltl2113/LLaVA-Med/model --multi-modal
sleep 10
python3 -u -m llava.serve.test_message --model-name LLaVA-Med-7B --controller http://localhost:10000
sleep 10
python3 -u -m llava.serve.gradio_web_server --controller http://localhost:10000
