#!/bin/bash
#FLUX: --job-name=KGQG-5e4
#FLUX: -c=3
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
source venv/bin/activate
TOKENIZERS_PARALLELISM=false srun python -u main.py --gpus -1 --batch_size 2 --learning_rate 5e-4 --max_epochs 300 \
                                         --optimizer adafactor --dataset WQ --logdir t5_WQ --pre_trained t5
