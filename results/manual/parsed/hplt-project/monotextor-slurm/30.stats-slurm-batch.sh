#!/bin/bash
#SBATCH --job-name=clean
#SBATCH --output=logs/%x-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=1750
#SBATCH --time=3-00:00:00
#SBATCH --partition=small

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
