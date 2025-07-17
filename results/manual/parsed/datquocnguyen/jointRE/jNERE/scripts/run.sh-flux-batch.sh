#!/bin/bash
#FLUX: --job-name=pusheena-leg-1913
#FLUX: --queue=long
#FLUX: --urgency=16

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

module load Python/2.7.13-intel-2017.03-GCC-6.3
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
source /mnt/nfs/home/ntv7/.DyNet/bin/activate
cd /mnt/nfs/home/ntv7/jNERE
python jNERE.py --dynet-mem 512 --epochs 100 --wembedding 100 --cembedding 25 --nembedding 100 --lr 0.0005 --lstmdims 100 --prevectors ../glove.6B.100d.txt --output outputs/exp_
