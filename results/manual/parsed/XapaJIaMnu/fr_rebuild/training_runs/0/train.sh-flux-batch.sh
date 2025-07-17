#!/bin/bash
#FLUX: --job-name=fat-lamp-4088
#FLUX: -t=43200
#FLUX: --urgency=16

BASE="/bask/projects/x/xngs6460-languages/gnail/enfr"
. ${BASE}/software/env.sh
MARIAN="${BASE}/software/source/marian-dev/build"
compute="--devices $(nvidia-smi --query-gpu=index --format=csv,nounits,noheader | tr '\n' ' ')"
$MARIAN/marian -c teacher.yml \
  --train-sets ${BASE}/data/dedup_fren/concat/combined.tsv.gz \
  --tempdir /tmp \
  --seed 1111 \
  ${compute} "${@}"
