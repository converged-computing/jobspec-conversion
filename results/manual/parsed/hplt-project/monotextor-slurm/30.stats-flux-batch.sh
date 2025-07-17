#!/bin/bash
#FLUX: --job-name=clean
#FLUX: -c=6
#FLUX: --queue=small
#FLUX: -t=259200
#FLUX: --urgency=16

module load cray-python/3.9.12.1
source .env
set -euo pipefail
L=$1
input_dir=clean
if [ $EXTERNAL = true ]; then
    input_dir=external_clean
fi
INPUT=$WORKSPACE/$input_dir/$L/
OUTPUT=$WORKSPACE/$input_dir/$L/${L}_stats
zstdcat $INPUT/${L}_*.jsonl.zst \
| python scripts/filter-stats.py \
>$OUTPUT.tmp
mv $OUTPUT.tmp $OUTPUT
