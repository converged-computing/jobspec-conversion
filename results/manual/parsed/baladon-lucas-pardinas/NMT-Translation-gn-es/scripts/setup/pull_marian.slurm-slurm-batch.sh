#!/bin/bash
#SBATCH --job-name=MARIAN
#SBATCH --output=docker.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal
#SBATCH --qos=normal

export SINGULARITY_TMPDIR='$(pwd)/cache'

echo starting download...
export SINGULARITY_TMPDIR=$(pwd)/cache
singularity pull docker://lefterav/marian-nmt:1.11.0_sentencepiece_cuda-11.3.0
