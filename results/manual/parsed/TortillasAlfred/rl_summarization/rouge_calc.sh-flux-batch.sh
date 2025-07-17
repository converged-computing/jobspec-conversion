#!/bin/bash
#FLUX: --job-name=arid-fork-2637
#FLUX: -c=12
#FLUX: -t=360
#FLUX: --urgency=16

mkdir /scratch/magod/rouge_calc/
source ~/venvs/default/bin/activate
date
SECONDS=0
python -um src.scripts.rouge $SLURM_ARRAY_TASK_ID --data_path=/scratch/magod/summarization_datasets/cnn_dailymail/data --vectors_cache=/scratch/magod/embeddings/ --target_dir=/scratch/magod/summarization_datasets/cnn_dailymail/data/rouge_npy/ --dataset=val
diff=$SECONDS
echo "$(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
date
