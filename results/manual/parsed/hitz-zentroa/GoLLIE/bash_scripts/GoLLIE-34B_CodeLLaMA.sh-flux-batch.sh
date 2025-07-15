#!/bin/bash
#FLUX: --job-name=GoLLIE-34B_CodeLLaMA
#FLUX: -c=16
#FLUX: --priority=16

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export TOKENIZERS_PARALLELISM='true'
export TRANSFORMERS_NO_ADVISORY_WARNINGS='true'
export WANDB_ENTITY='hitz-GoLLIE'
export WANDB_PROJECT='GoLLIEv1.0'
export PYTHONPATH='$PYTHONPATH:$PWD'

source /ikerlariak/osainz006/venvs/GoLLIE/bin/activate
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export TOKENIZERS_PARALLELISM=true
export TRANSFORMERS_NO_ADVISORY_WARNINGS=true
export WANDB_ENTITY=hitz-GoLLIE
export WANDB_PROJECT=GoLLIEv1.0
echo CUDA_VISIBLE_DEVICES "${CUDA_VISIBLE_DEVICES}"
export PYTHONPATH="$PYTHONPATH:$PWD"
CONFIGS_FOLDER="configs/model_configs"
torchrun --standalone --master_port 37229 --nproc_per_node=2 src/run.py ${CONFIGS_FOLDER}/GoLLIE-34B_CodeLLaMA.yaml
