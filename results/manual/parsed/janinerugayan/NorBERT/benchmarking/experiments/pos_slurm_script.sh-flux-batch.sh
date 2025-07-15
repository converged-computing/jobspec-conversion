#!/bin/bash
#FLUX: --job-name=norbert_pos
#FLUX: -n=8
#FLUX: --queue=accel
#FLUX: -t=18000
#FLUX: --priority=16

module purge
module use -a /cluster/projects/nn9851k/software/easybuild/install/modules/all/
module load NLPL-transformers/4.2.2-gomkl-2019b-Python-3.7.4
MODEL_NAME=${1}
SHORT_MODEL_NAME=${2} # ltgoslo/norbert is valid
LANG=${3}
echo $MODEL_NAME
echo $SHORT_MODEL_NAME
echo $LANG
PYTHONHASHSEED=0 python3 pos_finetuning.py --model_name "$MODEL_NAME" --short_model_name "$SHORT_MODEL_NAME" --training_language $LANG --epochs 20
