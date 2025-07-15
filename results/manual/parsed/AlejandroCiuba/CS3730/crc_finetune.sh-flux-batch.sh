#!/bin/bash
#FLUX: --job-name=cs3730-finetune
#FLUX: --queue=a100
#FLUX: -t=345600
#FLUX: --urgency=16

echo "RUN:" `date`
module load gcc/8.2.0 python/anaconda3.10-2022.10
source activate cs3730
unset PYTHONHOME
unset PYTHONPATH
version=`python finetune.py --version`
echo "RUNNING $version SCRIPT"
python finetune.py -m google/mt5-small \
				   -d datasets/ix_datasets/opus \
				   -s train \
				   -lc 1 \
				   -sl en \
				   -tl es \
				   -ts 0.3 \
				   -op 1 \
				   -tb 256 \
				   -t "English to Spanish" \
				   -me sacrebleu \
				   -mk score \
				   -f 1 \
				   -l 4e-5 \
				   -e 2 \
				   -b 16 \
				   -sa 1 \
				   -x 100 \
				   -o models/ix_models/baseline-fixed \
                   -lo logs
echo "DONE"
command -v crc-job-stats &> /dev/null && command crc-job-stats
