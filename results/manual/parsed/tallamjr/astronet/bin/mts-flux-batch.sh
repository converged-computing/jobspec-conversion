#!/bin/bash
#FLUX: --job-name=mts-arr
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: -t=172800
#FLUX: --urgency=16

set -o pipefail -e
source $PWD/conf/astronet.conf
date
which python
python -c "import astronet as asn; print(asn.__version__)"
python -c "import tensorflow as tf; print(tf.__version__)"
ARCH=$1
echo "Using $ARCH architecture"
declare -a arr=(
                "ArabicDigits"
                "AUSLAN"
                "CharacterTrajectories"
                "CMUsubject16"
                "ECG"
                "JapaneseVowels"
                "KickvsPunch"
                "Libras"
                "NetFlow"
                "UWave"
                "Wafer"
                "WalkvsRun"
            )
echo "${arr[SLURM_ARRAY_TASK_ID-1]}"
dataset="${arr[SLURM_ARRAY_TASK_ID-1]}"
python $ASNWD/astronet/$ARCH/opt/hypertrain.py --dataset $dataset --epochs 50
date
awk 'NR>15' $ASNWD/bin/mts
