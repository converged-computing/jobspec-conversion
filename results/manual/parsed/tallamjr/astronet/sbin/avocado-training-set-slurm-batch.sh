#!/bin/bash
#FLUX: --job-name=ptest
#FLUX: -t=172800
#FLUX: --urgency=16

set -o pipefail -e
source $PWD/conf/astronet.conf
awk 'NR>15' $ASNWD/sbin/plasticc-test-set
date
SECONDS=0 # https://stackoverflow.com/a/8903280/4521950
which python
python -c "import astronet as asn; print(asn.__version__)"
python -c "import tensorflow as tf; print(tf.__version__)"
declare -a arr=(
                "avo_aug_1_chunk_0"
                "avo_aug_1_chunk_1"
                "avo_aug_1_chunk_2"
                "avo_aug_1_chunk_3"
                "avo_aug_1_chunk_4"
                "avo_aug_1_chunk_5"
                "avo_aug_1_chunk_6"
                "avo_aug_1_chunk_7"
                "avo_aug_1_chunk_8"
                "avo_aug_1_chunk_9"
                "avo_aug_1_chunk_10"
                "avo_aug_1_chunk_11"
                "avo_aug_1_chunk_12"
                "avo_aug_1_chunk_13"
                "avo_aug_1_chunk_14"
                "avo_aug_1_chunk_15"
                "avo_aug_1_chunk_16"
                "avo_aug_1_chunk_17"
                "avo_aug_1_chunk_18"
                "avo_aug_1_chunk_19"
                "avo_aug_1_chunk_20"
                "avo_aug_1_chunk_21"
                "avo_aug_1_chunk_22"
                "avo_aug_1_chunk_23"
                "avo_aug_1_chunk_24"
                "avo_aug_1_chunk_25"
                "avo_aug_1_chunk_26"
                "avo_aug_1_chunk_27"
                "avo_aug_1_chunk_28"
            )
echo "${arr[SLURM_ARRAY_TASK_ID-1]}"
dataset="${arr[SLURM_ARRAY_TASK_ID-1]}"
python $ASNWD/sbin/avocado_training_set.py --file $dataset
date
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
