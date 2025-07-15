#!/bin/bash
#FLUX: --job-name=cs3730-dataset
#FLUX: --queue=a100
#FLUX: -t=432000
#FLUX: --priority=16

module load gcc/8.2.0 python/anaconda3.10-2022.10
source activate cs3730
unset PYTHONHOME
unset PYTHONPATH
echo "RUN: `date`"
version=`python dataset.py --version`
echo "RUNNING $version SCRIPT"
python dataset.py -d opus_books opus_wikipedia \
                  -s train \
                  -sl en \
                  -tl es \
                  -op 1 \
                  -b 128 \
                  -o datasets/opus \
                  -lo logs
echo "DONE"
command -v crc-job-stats &> /dev/null && command crc-job-stats
