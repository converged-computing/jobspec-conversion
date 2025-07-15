#!/bin/bash
#FLUX: --job-name=evasive-caramel-6614
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=240000
#FLUX: --priority=16

module load cuda/11.7.0
module load any/python/3.8.3-conda
conda activate nlp
ROOT=/gpfs/space/projects/stud_ml_22/NLP
RUN_NAME=a100_longer_training_vicuna
nvidia-smi
gcc --version
python3.10 llama_finetune.py --output_dir $ROOT/experiments/$RUN_NAME --run_name $RUN_NAME --bf16
