#!/bin/bash
#FLUX: --job-name=translate-nematus
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

TASK_ID=$(printf '%0'$digits'd' $SLURM_ARRAY_TASK_ID)
echo $CUDA_VISIBLE_DEVICES
echo $TASK_ID
. /home/jwei/miniconda3/etc/profile.d/conda.sh
conda activate nematus
module load cuda/9.0.176
module load cudnn/7.0-cuda_9.0
./nematus/nematus/translate.py \
  --models data/translate/models/model.npz \
  -v -p 1 --n-best \
  --input data/translate/splits/test_splits/$TASK_ID \
  --output data/translate/output/output_splits/$TASK_ID \
