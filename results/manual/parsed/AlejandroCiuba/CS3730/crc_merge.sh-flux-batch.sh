#!/bin/bash
#FLUX: --job-name=cs3730-merge
#FLUX: --queue=a100
#FLUX: -t=21600
#FLUX: --priority=16

module load gcc/8.2.0 python/anaconda3.10-2022.10
source activate cs3730
unset PYTHONHOME
unset PYTHONPATH
echo "RUN: `date`"
echo "RUN: `date`"
version=`python3 merge.py --version`
echo "RUNNING $version SCRIPT"
python3 merge.py -d datasets/ix_datasets/opus_flan datasets/ix_datasets/opus_nllb \
                 -s train test valid \
                 -o datasets/ix_datasets \
                 -l logs
echo "DONE"
command -v crc-job-stats &> /dev/null && command crc-job-stats
