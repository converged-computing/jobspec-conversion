#!/bin/bash
#FLUX: --job-name=tsv2jsonl
#FLUX: -c=2
#FLUX: --queue=small
#FLUX: -t=86400
#FLUX: --urgency=16

module load cray-python/3.9.12.1
set -euo pipefail
shopt -s failglob
source .env
L=$1
COLL=$2
TMPSFX=tmp_$SLURM_JOB_ID
INPUT=$WORKSPACE/$COLL/$L/scored.$SLURM_ARRAY_TASK_ID.zst
OUTPUT=$WORKSPACE/$COLL/$L/scored.$SLURM_ARRAY_TASK_ID.jsonl.zst
zstdcat $INPUT \
| tsv2jsonl -l $L \
| zstdmt -10 -T2 >$OUTPUT.$TMPSFX \
|| {
    echo "Error in pipeline: ${PIPESTATUS[@]}"
    exit 1
}
mv $OUTPUT.$TMPSFX $OUTPUT
rm $INPUT # Remove scored tsv intermediate file to save inodes
