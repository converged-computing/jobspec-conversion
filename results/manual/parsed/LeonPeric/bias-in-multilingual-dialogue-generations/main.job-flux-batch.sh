#!/bin/bash
#FLUX: --job-name=runATCS
#FLUX: -c=18
#FLUX: --queue=gpu_mig
#FLUX: -t=129540
#FLUX: --urgency=16

module purge
module load 2022
module load Anaconda3/2022.05
cd $TMPDIR/bias-in-multilingual-dialogue-generations/
source activate dl2023
model_name='LLama'
max_new_tokens=512
temperature=0.0
sequences_amount=1
batch_size=1
language="English"
python run.py \
    --model_name $model_name\
    --max_new_tokens $max_new_tokens\
    --temperature $temperature\
    --sequences_amount $sequences_amount\
    --batch_size $batch_size\
    --language $language\
