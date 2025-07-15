#!/bin/bash
#FLUX: --job-name=reclusive-butter-8782
#FLUX: --priority=16

module load gcc6 slurm cmake
inputlist=$1
outdir=$2
data=$3
proc=$4
mkdir -p $outdir
python3 src/generate_unigram.py \
  --input $inputlist \
  --output $outdir \
  --data $data
  --process $4
