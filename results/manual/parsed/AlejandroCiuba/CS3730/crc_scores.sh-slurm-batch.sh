#!/bin/bash
#FLUX: --job-name=cs3730-scores
#FLUX: --queue=a100
#FLUX: -t=381600
#FLUX: --urgency=16

echo "RUN:" `date`
module load gcc/8.2.0 python/anaconda3.10-2022.10
source activate cs3730
unset PYTHONHOME
unset PYTHONPATH
echo "RUN: `date`"
version=`python scores.py --version`
echo "RUNNING $version SCRIPT ON $SLURM_ARRAY_TASK_ID"
if [ "${SLURM_ARRAY_TASK_ID}" = "0" ]; then
    python scores.py -m facebook/nllb-200-distilled-600M \
                     -f 1 \
                     -tc spa_Latn \
                     -ts "Translate from English to Spanish" \
                     -d datasets/ix_datasets/opus \
                     -lc 1 \
                     -s train \
                     -sl en \
                     -tl es \
                     -op 0 \
                     -tb 128 \
                     -b 32 \
                     -me sacrebleu \
                     -mk score \
                     -o datasets/ix_datasets/opus_nllb \
                     -lo logs \
                     -ln $SLURM_ARRAY_TASK_ID
elif [ "${SLURM_ARRAY_TASK_ID}" = "1" ]; then
        python scores.py -m google/flan-t5-large \
                         -f 1 \
                         -tc spa_Latn \
                         -ts "Translate from English to Spanish" \
                         -d datasets/ix_datasets/opus \
                         -lc 1 \
                         -s train \
                         -sl en \
                         -tl es \
                         -op 0 \
                         -tb 128 \
                         -b 32 \
                         -me sacrebleu \
                         -mk score \
                         -o datasets/ix_datasets/opus_flan \
                         -lo logs \
                         -ln $SLURM_ARRAY_TASK_ID
fi
echo "DONE"
command -v crc-job-stats &> /dev/null && command crc-job-stats
