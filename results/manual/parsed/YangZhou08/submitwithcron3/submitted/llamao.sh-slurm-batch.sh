#!/bin/bash
#FLUX: --job-name=yangzho6
#FLUX: -c=10
#FLUX: --queue=devlab
#FLUX: -t=86400
#FLUX: --urgency=16

export WANDB_API_KEY='fbb26fc8718b8e58d743b5cdcabaa2396656f773 '
export CUDA_VISIBLE_DEVICES='0,1,2,3,4,5,6,7 '

source /private/home/beidic/.bashrc 
source /public/apps/anaconda3/2022.05/etc/profile.d/conda.sh 
source activate base 
conda activate base 
conda activate griffin 
pip uninstall transformers 
cd /private/home/beidic/yang 
git clone git@github.com:YangZhou08/transformersprofiling.git 
cd transformersprofiling 
pip install -e . 
cd /private/home/beidic/yang/GRIFFIN2 
git checkout yangobservation 
git pull --set-upstream-to=origin/yangobservation yangobservation 
git pull 
pip install termcolor 
pip install wandb 
pip install -U "huggingface_hub[cli]" 
pip install matplotlib 
pip install langdetect 
pip install immutabledict 
pip install sentencepiece 
which python 
export WANDB_API_KEY=fbb26fc8718b8e58d743b5cdcabaa2396656f773 
wandb login 
which python 
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 
echo xxxxxxxxxxxxxxxx | transformers-cli login 
huggingface-cli login --token xxxxxxxxxxxxxxxxxx
accelerate launch --main_process_port 29510 --num_processes 8 --num_machines 1 main.py --model xhf --model_args pretrained=meta-llama/Meta-Llama-3-8B-Instruct,griffin=True,check=False,griffinnotcats=True --tasks gsm8k --batch_size 1 
