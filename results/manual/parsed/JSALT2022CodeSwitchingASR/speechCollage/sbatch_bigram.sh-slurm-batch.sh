#!/bin/bash
#SBATCH --job-name=V2audioGen
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --partition=cpu-all

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
