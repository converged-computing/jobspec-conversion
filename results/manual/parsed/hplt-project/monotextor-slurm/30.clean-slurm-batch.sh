#!/bin/bash
#SBATCH --job-name=clean
#SBATCH --output=logs/%x-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=1750
#SBATCH --time=12:00:00
#SBATCH --partition=small

module load cray-python/3.9.12.1
module load parallel
source .env
set -euo pipefail
L=$1
input_dir=dedup
output_dir=clean
if [ "$EXTERNAL" = true ]; then
    input_dir=external
    output_dir=external_clean
fi
INPUT=$WORKSPACE/$input_dir/$L/${L}_$SLURM_ARRAY_TASK_ID.jsonl.zst
OUTPUT=$WORKSPACE/$output_dir/$L/${L}_$SLURM_ARRAY_TASK_ID.jsonl.zst
mkdir -p $WORKSPACE/$output_dir/$L
case "$L" in
    zh | ja | ko)
        FILTER_PARAMS="-a -z";;
    af | tl | ms | id | uz | sw | so)
        FILTER_PARAMS="-e -w -m";;
    fi)
        FILTER_PARAMS="-a -E";;
    *)
        FILTER_PARAMS="-a";;
esac
if [ "$EXTERNAL" = true ]; then
    FILTER_PARAMS="-w -m";
fi
if [ "$DISCARD" = true ]; then
    FILTER_PARAMS="$FILTER_PARAMS -f";
fi
zstdcat $INPUT \
| parallel --pipe --halt now,fail=1 \
    -j$SLURM_CPUS_ON_NODE --block 10M \
    python filter-docs.py $FILTER_PARAMS \
| zstdmt -T64 -10 \
>$OUTPUT.tmp
mv $OUTPUT.tmp $OUTPUT
