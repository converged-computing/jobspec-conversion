#!/bin/bash
#FLUX: --job-name=V2audioGen
#FLUX: -c=40
#FLUX: --queue=cpu-all
#FLUX: --urgency=16

module load gcc6 slurm cmake
inputlist=$1
outdir=$2
data=$3
proc=$4
mkdir -p $outdir
python3 src/generate_bigram.py \
  --input $inputlist \
  --output $outdir \
  --data $data \
  --process $4
