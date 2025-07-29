#!/bin/bash
#FLUX: --job-name=chunkpt
#FLUX: -t=172800
#FLUX: --urgency=16

set -o pipefail -e
source $PWD/conf/astronet.conf
awk 'NR>15' $ASNWD/sbin/chunk-plasticc-test
date
SECONDS=0 # https://stackoverflow.com/a/8903280/4521950
which python
python -c "import astronet as asn; print(asn.__version__)"
python -c "import tensorflow as tf; print(tf.__version__)"
declare -a arr=(
                "${ASNWD}/data/plasticc/avocado/avo_aug_1.csv"
            )
echo "${arr[SLURM_ARRAY_TASK_ID-1]}"
dataset="${arr[SLURM_ARRAY_TASK_ID-1]}"
python $ASNWD/sbin/chunk_plasticc_test.py --file $dataset -o "${ASNWD}/data/plasticc/avocado/"
date
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
