#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=12:00:00
#SBATCH --qos=epsrc
#SBATCH --array=0-16

BASE="/bask/projects/x/xngs6460-languages/gnail/enfr"
. ${BASE}/software/env.sh
MARIAN="${BASE}/software/source/marian-dev/build"
compute="--devices $(nvidia-smi --query-gpu=index --format=csv,nounits,noheader | tr '\n' ' ')"
$MARIAN/marian -c teacher.yml \
  --train-sets ${BASE}/data/dedup_fren/concat/combined.tsv.gz \
  --tempdir /tmp \
  --seed 1111 \
  ${compute} "${@}"
