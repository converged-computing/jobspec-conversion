#!/bin/bash
#FLUX: --job-name=wav2vec2phone
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

echo "Activating environment wav2vec" > array_$SLURM_ARRAY_TASK_ID.txt
conda activate wav2vec
echo "Launching wav2vec2 array" >> array_$SLURM_ARRAY_TASK_ID.txt
python recipes/array-frozen/prepare_jobs.py $SLURM_ARRAY_TASK_ID
python recipes/array-frozen/recipe.py recipes/array-frozen/temp/$SLURM_ARRAY_TASK_ID/temp.yml >> array_$SLURM_ARRAY_TASK_ID.txt
