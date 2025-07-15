#!/bin/bash
#FLUX: --job-name=paraphrase
#FLUX: -c=16
#FLUX: --priority=16

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export TOKENIZERS_PARALLELISM='true'
export TRANSFORMERS_NO_ADVISORY_WARNINGS='true'
export WANDB_ENTITY='hitz-GoLLIE'
export WANDB_PROJECT='GoLLIE'

source /ikerlariak/osainz006/venvs/GoLLIE/bin/activate
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export TOKENIZERS_PARALLELISM=true
export TRANSFORMERS_NO_ADVISORY_WARNINGS=true
export WANDB_ENTITY=hitz-GoLLIE
export WANDB_PROJECT=GoLLIE
CONFIGS_FOLDER="configs/pharapharse_config"
python3 -m src.paraphrase.run_paraphrasing ${CONFIGS_FOLDER}/LlaMA2-Chat.yaml
