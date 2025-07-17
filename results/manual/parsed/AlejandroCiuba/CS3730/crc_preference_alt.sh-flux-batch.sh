#!/bin/bash
#FLUX: --job-name=cs3730-preference-alt
#FLUX: --queue=a100
#FLUX: -t=432000
#FLUX: --urgency=16

echo "RUN:" `date`
module load gcc/8.2.0 python/anaconda3.10-2022.10
source activate cs3730
unset PYTHONHOME
unset PYTHONPATH
version=`python finetune_preference_alt.py --version`
echo "RUNNING $version SCRIPT"
python finetune_preference_alt.py -m google/mt5-small \
							  -dmt datasets/ix_datasets/opus \
							  -s train \
							  -lc 1 \
							  -sl en \
							  -tl es \
							  -op 1 \
							  -dpt datasets/ix_datasets/opus_flan_opus_nllb \
							  -mts flan-t5-large nllb-200-distilled-600M \
							  -mtk flan-t5-large_score nllb-200-distilled-600M_score \
							  -ts 0.3 \
							  -tb 256 \
							  -g 4.0 \
							  -t "English to Spanish" \
							  -me sacrebleu \
							  -mk score \
							  -sk 1 \
							  -f 1 \
							  -l 4e-5 \
							  -e 2 \
							  -b 16 \
							  -tm $SLURM_ARRAY_TASK_ID \
							  -sa 1 \
							  -x 100 \
							  -o models/ix_models/preference-alt-$SLURM_ARRAY_TASK_ID \
							  -lo logs
echo "DONE"
command -v crc-job-stats &> /dev/null && command crc-job-stats
