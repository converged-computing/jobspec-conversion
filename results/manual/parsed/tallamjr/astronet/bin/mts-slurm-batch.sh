#!/bin/bash
#SBATCH --job-name=mts-arr
#SBATCH --output=logs/%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=2-00:00:00
#SBATCH: --exclusive
#SBATCH --array=1-12

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
