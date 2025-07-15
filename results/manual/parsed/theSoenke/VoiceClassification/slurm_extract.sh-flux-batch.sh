#!/bin/bash
#FLUX: --job-name=extract
#FLUX: -t=3600
#FLUX: --priority=16

set -e # Good Idea to stop operation on first error.
source /sw/batch/init.sh
module unload env
module load /sw/BASE/env/2017Q1-gcc-openmpi /sw/BASE/env/cuda-8.0.44_system-gcc
echo "Hello World! I am $(hostname -s) greeting you!"
echo "Also, my current TMPDIR: $TMPDIR"
echo "nvidia-smi:"
srun bash -c 'nvidia-smi'
srun bash -c 'LD_LIBRARY_PATH=/sw/compiler/cuda-8.0.44/lib64:$HOME/cuda/lib64/ python3 $WORK/VoiceClassification/extract_features.py --data $WORK/cv_corpus_v1'
