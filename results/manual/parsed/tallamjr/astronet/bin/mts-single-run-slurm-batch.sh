#!/bin/bash
#SBATCH --job-name=mts-arr
#SBATCH --output=logs/%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

export PYTHONPATH='${PYTHONPATH}:/home/tallam/astronet/'

set -o pipefail -e
source $PWD/conf/astronet.conf
date
which python
export PYTHONPATH="${PYTHONPATH}:/home/tallam/astronet/"
python -c "import astronet as asn; print(asn.__version__)"
python -c "import tensorflow as tf; print(tf.__version__)"
ARCH=$1
echo "Using $ARCH architecture"
dataset=$2
echo "With $dataset"
python $ASNWD/astronet/$ARCH/opt/hypertrain.py --dataset $dataset --epochs 50
python $ASNWD/astronet/$ARCH/train.py --dataset $dataset --epochs 400
date
awk 'NR>15' $ASNWD/bin/mts
